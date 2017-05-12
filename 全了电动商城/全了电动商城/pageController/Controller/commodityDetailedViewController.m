//
//  commodityDetailedViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//
#import "loginViewController.h"
#import "commodityDetailedViewController.h"
#import "LYYScrollView.h"
#import "commodityHeadView.h"
#import "commodityTableViewCell.h"
#import "commodityBottomView.h"
#import "imageDetailViewController.h"
#import "oldAnnouncedViewController.h"
#import "WinningViewController.h"
#import "AppDelegate.h"
#import "sideslipViewController.h"
#import "commodityModel.h"
#import "oldAnnouncedViewController.h"
#define LoadingNumber 10
@interface commodityDetailedViewController ()<UITableViewDelegate,UITableViewDataSource>
//主视图
@property (nonatomic , strong)UITableView *tabelView;
//存放滚动图片的数组
@property (nonatomic , strong)NSMutableArray *imagesArray;
//headTabelView
@property (nonatomic , strong)UIView *headView;
/** 商品的当前期数 */
@property (nonatomic , strong)NSString *qiHao;
/** 商品内容详情 */
@property (nonatomic , strong)NSMutableArray *goodsArray;
/** 保存当前参与用户的信息数据 */
@property (nonatomic , strong)NSMutableArray *userDataArray;
/** 模型传过来滚动视图的URL 字符串 */
@property (nonatomic , strong)NSString *imagesUrl;
/** 测试传值给下个界面 商品ID 和 当前期数 */
@property (nonatomic , strong)NSString *goodsID;
@property (nonatomic , strong)NSString *goodsDate;
/** 接受商品剩余的数量值 */
@property (nonatomic , assign)int surplusNum;
//购买方式view
@property (nonatomic , strong)commodityHeadView *TopheadView;
/** 接受传来的积分 */
@property (nonatomic , strong)NSString *jiFenStr;
@end

extern NSMutableDictionary *GoodsIDs;
extern NSMutableArray *ShopsIDs;
//页数
static  int p = 1;
/** 用户传输到购物车的商品数量 */
int number = 1;
static NSString *reuseIndentifier = @"cell";

@implementation commodityDetailedViewController
- (NSArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}
- (NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}
- (NSMutableArray *)userDataArray {
    if (!_userDataArray) {
        _userDataArray = [NSMutableArray array];
    }
    return _userDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self configNavigation];
    [self setTabelViewController];
    //添加上下刷新的控件
    [self setRefreshTheUpAndDown];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark ----- setHeadTabelView
- (void)setHeadTabelView {
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 580)];
    _headView.backgroundColor = [UIColor whiteColor];
    LYYScrollView *scrollView = [[LYYScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) images:self.imagesArray];
    LDLog(@"%@",self.imagesArray);
    scrollView.pageControl.pageIndicatorTintColor = kColor_RGB(247, 247, 247);
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    self.TopheadView = [[NSBundle mainBundle]loadNibNamed:@"commodityHeadView" owner:nil options:nil].lastObject;
    //把获取数据源 跟cell里的模型要对应起来
    _TopheadView.goodsModel = self.goodsArray.firstObject;
    //当前商品的期号
    self.qiHao  = _TopheadView.dangQiShu;
    
    [_headView addSubview:scrollView];
    [_headView addSubview:_TopheadView];
    [_TopheadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 420));
    }];
    /** 4个人次选择 */
    [_TopheadView.fiveBtn addTarget:self action:@selector(setFiveBtn) forControlEvents:UIControlEventTouchUpInside];
    [_TopheadView.tenBtn addTarget:self action:@selector(setTenBtn) forControlEvents:UIControlEventTouchUpInside];
    [_TopheadView.twentyBtn addTarget:self action:@selector(setTwentyBtn) forControlEvents:UIControlEventTouchUpInside];
    [_TopheadView.allBtn addTarget:self action:@selector(setAllSurplusBtn) forControlEvents:UIControlEventTouchUpInside];
    //加入购物车按钮
    //1.
    [_TopheadView.jionBoxOne addTarget:self action:@selector(SetJoinListBtn) forControlEvents:UIControlEventTouchUpInside];
    [_TopheadView.jionBoxNowOne addTarget:self action:@selector(gotoListViewController) forControlEvents:UIControlEventTouchUpInside];
    //2.
    [_TopheadView.jionBoxTwo addTarget:self action:@selector(SetIntegralListBtn) forControlEvents:UIControlEventTouchUpInside];
    [_TopheadView.jionBoxNowTwo addTarget:self action:@selector(gotoIntegralViewController) forControlEvents:UIControlEventTouchUpInside];
    //3.
    [_TopheadView.jionBoxThree addTarget:self action:@selector(SetAllListBtn) forControlEvents:UIControlEventTouchUpInside];
    [_TopheadView.jionBoxNowThree addTarget:self action:@selector(gotoAllViewController) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark ----- 创建导航栏
- (void)configNavigation {
    self.title = @"内容详情";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 15);
    [backButton setBackgroundImage:[UIImage imageNamed:@"箭头白"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dealBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    //导航添加背景颜色
    [self.navigationController.navigationBar setBarTintColor:kColor_RGB(217, 57, 84)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
}
- (void) dealBack {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ----- setTabelViewController
- (void)setTabelViewController {
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tabelView.backgroundColor = [UIColor whiteColor];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.showsVerticalScrollIndicator = NO;
    [_tabelView registerNib:[UINib nibWithNibName:@"commodityTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIndentifier];
    [self.view addSubview:_tabelView];
}
#pragma mark ----- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else
        return self.userDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"identifier"];
            if (indexPath.row == 0) {
                cell.textLabel.text = @"图文详情";
                cell.detailTextLabel.text = @"建议在WiFi下查看";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"往期揭晓";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else if(indexPath.row == 2) {
                cell.textLabel.text = @"晒单分享";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        return cell;
    }else{
        commodityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
        commodityModel *model = self.userDataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return _headView;
    }else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [UILabel new];
        label.text = @"所有参与记录";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 30));
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(5);
        }];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 580;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                imageDetailViewController *imageDetailVC = [[imageDetailViewController alloc]init];
                imageDetailVC.userID = self.goodsID;
                [self.navigationController pushViewController:imageDetailVC animated:YES];
            }else if (indexPath.row == 1) {
                oldAnnouncedViewController *oldAnnouncedVC = [[oldAnnouncedViewController alloc]init];
                [self.navigationController pushViewController:oldAnnouncedVC animated:YES];
                oldAnnouncedVC.indentif = self.goodsID;
                oldAnnouncedVC.date     = self.goodsDate;
            }else {
                WinningViewController *winningVC = [[WinningViewController alloc]init];
                winningVC.cpid = self.goodsID;
                [self.navigationController pushViewController:winningVC animated:YES];
            }
            break;
        case 1:
            
            break;
    }
}

#pragma mark ----- 4个人次选择按钮方法
- (void)setFiveBtn {
    if (_surplusNum < 5) {
        _TopheadView.fiveBtn.userInteractionEnabled = NO;
        [ProgressHUD showError:@"商品数量不足5人次"];
        number = 1;
    }else {
    [_TopheadView.fiveBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_TopheadView.tenBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.allBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _TopheadView.buyNumber.text = [NSString stringWithFormat:@"选择购买的次数:   5次"];
        number = 5;
    }
}
- (void)setTenBtn {
    if (_surplusNum < 10) {
        _TopheadView.tenBtn.userInteractionEnabled = NO;
        [ProgressHUD showError:@"商品数量不足10人次"];
        number = 1;
    }else {
    [_TopheadView.fiveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.tenBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_TopheadView.twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.allBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _TopheadView.buyNumber.text = [NSString stringWithFormat:@"选择购买的次数:   10次"];
        number = 10;
    }
}
- (void)setTwentyBtn {
    if (_surplusNum < 20) {
        _TopheadView.twentyBtn.userInteractionEnabled = NO;
        [ProgressHUD showError:@"商品数量不足20人次"];
        number = 1;
    }else {
    [_TopheadView.fiveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.tenBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.twentyBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_TopheadView.allBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _TopheadView.buyNumber.text = [NSString stringWithFormat:@"选择购买的次数:   20次"];
        number = 20;
    }
}
- (void)setAllSurplusBtn {
    [_TopheadView.fiveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.tenBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_TopheadView.allBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.TopheadView.buyNumber.text = [NSString stringWithFormat:@"选择购买的次数:   %d次",_surplusNum];
    number = _surplusNum;
    
}
#pragma mark ------> 立即参与 、 加入清单
//众筹价立即购买
- (void)gotoListViewController {
    [self reWriteChouTi];
    NSString *numStr = [NSString stringWithFormat:@"%d",number];
    [self addCar:@"2" num:numStr];
}
//众筹价加入购物车
- (void)SetJoinListBtn {
    NSString *numStr = [NSString stringWithFormat:@"%d",number];
    [self addCar:@"2" num:numStr];
}
//全价直购立即购买
- (void)gotoAllViewController {
    [self reWriteChouTi];
    [self addCar:@"1" num:@"1"];
}
//全价直购加入购物车
- (void)SetAllListBtn {
    [self addCar:@"1" num:@"1"];
}
//积分购立即购买
- (void)gotoIntegralViewController {
    if ([self.jiFenStr intValue] == 0) {
        [ProgressHUD showError:@"占未开启积分"];
        _TopheadView.jionBoxTwo.userInteractionEnabled = NO;
        _TopheadView.jionBoxNowTwo.userInteractionEnabled = NO;
    } else {
        [self reWriteChouTi];
        [self addCar:@"3" num:@"1"];
    }
}
//积分购加入购物车
- (void)SetIntegralListBtn {
    if ([self.jiFenStr intValue] == 0) {
        [ProgressHUD showError:@"占未开启积分"];
        _TopheadView.jionBoxTwo.userInteractionEnabled = NO;
        _TopheadView.jionBoxNowTwo.userInteractionEnabled = NO;
    } else {
        [self addCar:@"3" num:@"1"];
    }
}
//创建抽屉 重写抽屉功能 否则抽屉无用
-(void)reWriteChouTi{
    sideslipViewController *sideslip = [[sideslipViewController alloc]init];
    /**
     主视图 ---> 左侧 ---> 右侧
     */
    UIStoryboard *boadr = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UITabBarController *tabbarController = [boadr instantiateViewControllerWithIdentifier:@"tabbar"];
    tabbarController.tabBar.tintColor = kColor_RGB(215, 59, 100);
    tabbarController.tabBar.backgroundColor = [UIColor whiteColor];
    tabbarController.tabBar.barTintColor = [UIColor whiteColor];
    MMDrawerController *drawerController = [[MMDrawerController alloc]initWithCenterViewController:tabbarController leftDrawerViewController:sideslip rightDrawerViewController:nil];
    //4、设置打开/关闭抽屉的手势
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    drawerController.maximumLeftDrawerWidth = 200.0;
    drawerController.maximumRightDrawerWidth = 200.0;
    [[UIApplication sharedApplication].delegate window].rootViewController = drawerController;
    tabbarController.selectedIndex = 3;

}
-(void)addCar:(NSString*)typeString num:(NSString*)num{
    ///加入购物车
    NSString* userid;
    [[LDUserInfo sharedLDUserInfo] readUserInfo];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [user objectForKey:@"isLogin"];
    if ([isLogin intValue] == 0) {
        if ([LDUserInfo sharedLDUserInfo].isLogin == YES) {
            userid = [LDUserInfo sharedLDUserInfo].ID ;
        } else {
            //如果没登录就跳转
            loginViewController *vc = [loginViewController new] ;
            vc.type = 1;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    }else if ([isLogin intValue] != 0) {
        userid = [user objectForKey:@"userID"];
    }
    NSDictionary *para = @{@"uid":userid,
                           @"cpid":_identifying,
                           @"chutype":typeString,
                           @"num":num};
    [ProgressHUD show];
    [QLRequest submitOrder:para success:^(id response) {
        [ProgressHUD dismiss];
        NSLog(@"打印一下返回:%@",response);
        if (!([response[@"code"] integerValue]==97100)) {
            [ProgressHUD showError:@"加入购物车失败"];
        }
    } error:^(id response) {
        [ProgressHUD dismiss];
        [ProgressHUD showError:@"加入购物车失败"];
    }];
    
}
#pragma mark ------ 请求数据上半区的数据
- (void)loadData {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/productShow/id/%@",self.identifying];
    LDLog(@"%@",self.identifying);
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        [self.goodsArray removeAllObjects];
        for (NSDictionary *tempDic in dataArray) {
            commodityModel *model = [commodityModel getGoodsDetailsDataWithDic:tempDic];
            //用来判断的积分价格
            self.jiFenStr = model.makeup_price;
            
            [self.goodsArray addObject:model];
            _imagesUrl = [NSString stringWithFormat:@"%@",model.tupianji];
            _surplusNum = [model.remain intValue];
            LDLog(@"%d",_surplusNum);
            /** 传ID 和产品期号到下个界面<先复制给自己 再跳转的时候传入?> */
            _goodsID = model.ID;
            _goodsDate = model.dangqishu;
        }
        #pragma mark ------重点<正则表达式> 滚动视图的切割字符串 代做吧
        //正则表达式 待研究 剖析
        NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:@"\"/[0-9a-zA-Z, \\., /, _]+\"" options:NSRegularExpressionAnchorsMatchLines error:NULL];
        [re enumerateMatchesInString:_imagesUrl options:0 range:NSMakeRange(0, _imagesUrl.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            NSString *matchStr = [_imagesUrl substringWithRange:result.range];
            NSString *matchString = [matchStr substringFromIndex:1];
            NSString *str = [ImageUrl stringByAppendingString:matchString];
            str =  [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            [self.imagesArray addObject:str];
        }];
        [self setHeadTabelView];
        [self.tabelView reloadData];
        LDLog(@"加载商品详情成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"加载商品详情失败");
    }];
}
//请求下半区cell的数据
- (void)loadCellData:(NSString *)urlStr {
    LDWeakSelf(self);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        if (p > 1) {
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.userDataArray];
            [self.userDataArray removeAllObjects];
            NSMutableArray *newArray  = [NSMutableArray array];
            for (NSDictionary *tempDic in dataArray) {
                commodityModel *model = [commodityModel getGoodsDetailsDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里//把数据放到新的可变数组里
                [newArray addObject:model];
                
            }
            [arrayM addObjectsFromArray:newArray];
            self.userDataArray = arrayM;
            [weakself.tabelView footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            [ProgressHUD showSuccess:@"加载成功"];
        } else {
            //移除所有数据
            [self.userDataArray removeAllObjects];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                commodityModel *model = [commodityModel getGoodsDetailsDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里
                [self.userDataArray addObject:model];
        }
            //结束下拉加载的动画
            [weakself.tabelView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
            [ProgressHUD showSuccess:@"刷新成功"];
        }
        [self.tabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        [weakself.tabelView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
        [weakself.tabelView footerSetState:CoreFooterViewRefreshStateFailed];
        LDLog(@"失败 = %@",error);
    }];
}
//添加上下刷新的控件
- (void)setRefreshTheUpAndDown {
    [self.tabelView addHeaderWithTarget:self action:@selector(headerRefreshBtn)];
    [self.tabelView addFooterWithTarget:self action:@selector(foorterRefreshBtn)];
    //队里延迟显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //数据刷新中
        [self.tabelView headerSetState:CoreHeaderViewRefreshStateRefreshing];
    });
}
#pragma mark  动态顶部刷新
-(void)headerRefreshBtn{
    p = 1;
    LDWeakSelf(self);
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/gouList/sid/%@/qihao/%@/nowpage/%d/pagesize/%d",self.identifying,self.qiHao,p,LoadingNumber];
    if (weakself.userDataArray.count != 0) {
        [weakself.userDataArray removeAllObjects];
    }
    if (weakself.userDataArray.count == 0) {
        [weakself loadCellData:urlStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tabelView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
        });
    }else{
        [weakself.tabelView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tabelView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
    });
    [self.tabelView reloadData];
}
#pragma mark ----- 动态底部刷新
-(void)foorterRefreshBtn{
    p++;
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/gouList/sid/%@/qihao/%@/nowpage/%d/pagesize/%d",self.identifying,self.qiHao,p,LoadingNumber];
    [self loadCellData:urlStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
