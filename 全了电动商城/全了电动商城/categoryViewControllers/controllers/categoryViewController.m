//
//  categoryViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/27.
//  Copyright © 2016年 亮点网络. All rights reserved.
//
#import "loginViewController.h"
#import "categoryViewController.h"
#import "categoryTableViewCell.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "commodityDetailedViewController.h"
#import "pageGoodsModel.h"
@interface categoryViewController ()<UITableViewDelegate,UITableViewDataSource>
/** topViewControl */
@property (nonatomic , strong)UIView *topView;
@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UIButton *backBtn;
/** tabelView */
@property (nonatomic , strong)UITableView *tabelView;
@property (nonatomic , strong)NSMutableArray *dataModelArray;
@end

extern NSMutableDictionary *GoodsIDs;
extern NSMutableArray *ShopsIDs;
//页数
static  int p = 1;
int numSid;
static NSString *reuseIdentifier = @"cell";
@implementation categoryViewController

- (NSMutableArray *)dataModelArray {
    if (!_dataModelArray) {
        _dataModelArray = [NSMutableArray array];
    }
    return _dataModelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopView];
    [self setTabelView];
    [self setRefreshTheUpAndDown];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    int intStr = [self.classifyNum intValue];
    numSid = intStr;
}
#pragma mark ----- setTopView
- (void)setTopView {
    
    _topView = [UIView new];
    _topView.backgroundColor = kColor_RGB(215, 59, 86);
    [self.view addSubview:_topView];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = self.title;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:_titleLabel];
    
    _backBtn = [UIButton new];
    [_backBtn setImage:[UIImage imageNamed:@"箭头白"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(gotoBackViewController) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_backBtn];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(_topView.mas_centerX);
    }];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(28);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

- (void)gotoBackViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ----- setTabelView
- (void)setTabelView {
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 40) style:UITableViewStylePlain];
    _tabelView.delegate   = self;
    _tabelView.dataSource = self;
    _tabelView.backgroundColor = [UIColor whiteColor];
    [_tabelView registerNib:[UINib nibWithNibName:@"categoryTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_tabelView];
    
}
#pragma mark ----- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    categoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.boxBtn addTarget:self action:@selector(SBsetJoinBoxBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.boxBtn.tag = indexPath.row;
    pageGoodsModel *model = self.dataModelArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    commodityDetailedViewController *vc = [[commodityDetailedViewController alloc]init];
    pageGoodsModel *model = self.dataModelArray[indexPath.row];
    NSNumber * nums = @([model.ID integerValue]);
    vc.identifying = nums;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark ------ 加入购物车动画
- (void)SBsetJoinBoxBtn: (UIButton *)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    categoryTableViewCell *cell = (categoryTableViewCell *)[self.tabelView cellForRowAtIndexPath:indexPath];
    NSString* userid;
    //判断登入
    [[LDUserInfo sharedLDUserInfo] readUserInfo];
    if ([LDUserInfo sharedLDUserInfo].ID) {
        userid = [LDUserInfo sharedLDUserInfo].ID ;
        NSDictionary *para = @{@"uid":userid,
                               @"cpid":cell.ID,
                               @"chutype":@"2",
                               @"num":@"1"};
        [ProgressHUD show];
        [QLRequest submitOrder:para success:^(id response) {
            [ProgressHUD dismiss];
            if (!([response[@"code"] integerValue]==97100)) {
                [ProgressHUD showError:@"加入购物车失败"];
            }
        } error:^(id response) {
            [ProgressHUD dismiss];
            [ProgressHUD showError:@"加入购物车失败"];
        }];
    }else{
        [ProgressHUD showError:@"未登入"];
        return;
    }
    
}

#pragma mark -- 加载数据
- (void)loadCollectionCellData:(NSString *)urlStr{
    LDWeakSelf(self);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //如果数组 是NSArray  这里是字典就用字典接受responseObject 数据
        NSDictionary *dataDic = responseObject;
        //data 里面是数组  用数组接受
        NSArray *dataArray = dataDic[@"data"];
        //如果页面大于1
        if (p>1) {
            //先将上次加载的数据保存到新的数组里
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.dataModelArray];
            //移除原先的数据
            [self.dataModelArray removeAllObjects];
            //创建一个新的可变数组  用于存放新的数据
            NSMutableArray *newArray  = [NSMutableArray array];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                pageGoodsModel *goodsModel = [pageGoodsModel getLoadDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里//把数据放到新的可变数组里
                [newArray addObject:goodsModel];
            }
            //把新数组里的数据存放到存放第一次加载数据的数组里
            [arrayM addObjectsFromArray:newArray];
            //把合并后的数据源数组 赋值给你的数据源数组啊
            self.dataModelArray = arrayM;
            //结束上拉加载动作
            [weakself.tabelView footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            //弹出小窗口 显示加载成功
            [ProgressHUD showSuccess:@"加载成功"];
        }else{
            //移除所有数据
            [self.dataModelArray removeAllObjects];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                pageGoodsModel *goodsModel = [pageGoodsModel getLoadDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里
                [self.dataModelArray addObject:goodsModel];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/product/off/2/pagesize/%d/nowpage/%d/sid/%d",LoadingNumber, p,numSid];
    if (weakself.dataModelArray.count != 0) {
        [weakself.dataModelArray removeAllObjects];
    }
    if (weakself.dataModelArray.count == 0) {
        [weakself loadCollectionCellData:urlStr];
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
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/product/off/2/pagesize/%d/nowpage/%d/sid/%d",LoadingNumber, p,numSid];
    [self loadCollectionCellData:urlStr];
}





































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
