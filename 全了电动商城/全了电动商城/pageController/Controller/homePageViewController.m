//
//  homePageViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/23.
//  Copyright © 2016年 亮点网络. All rights reserved.
//
#import "loginViewController.h"
#import "homePageViewController.h"
#import "headlineView.h"
#import "LYYScrollView.h"
#import "functionView.h"
#import "topCollectionView.h"
#import "HomePageCollectionViewCell.h"
#import "SearchViewController.h"
#import "tenYuanViewController.h"
#import "WinningViewController.h"
#import "commodityDetailedViewController.h"
#import "pageGoodsModel.h"

#define ItemSize ((SCREEN_WIDTH -1) /2)
#define scrollViewHight (170)
#define LoadingNumber 10
@interface homePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** collection */
@property (nonatomic , strong)UICollectionView *homePagecollection;
/** collectionHeadView */
@property (nonatomic , strong)UIView *collectionHeadView;
//滚动视图数组
@property (nonatomic, strong)NSMutableArray *scrollArray;
//数据数组
@property (nonatomic , strong)NSMutableArray *collectionArray;

@end

extern NSMutableDictionary *GoodsIDs;
extern NSMutableArray *ShopsIDs;
//页数
static  int p = 1;
static NSString *registert = @"cell";
@implementation homePageViewController


//数据数组
- (NSMutableArray *)collectionArray {
    if (!_collectionArray) {
        _collectionArray = [NSMutableArray array];
    }
    return _collectionArray;
}
//滚动视图数据数组
- (NSMutableArray *)scrollArray {
    if (!_scrollArray) {
        _scrollArray = [NSMutableArray array];
    }
    return _scrollArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //顶部头条
    [self setHeadLineView];
    //collectionView
    [self setHomePageCollectionView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBadgeValueAdd:) name:@"shopCarAnimationEnd" object:nil];
    //添加上下刷新的控件
    [self setRefreshTheUpAndDown];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = NO;
    //滚动视图诗句
    [self getHomePageScollViewImages];
    //将要显示的时候设置可以拨动
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.mm_drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    //
    [super viewWillAppear:animated];
    [self.homePagecollection scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];

}

#pragma mark - NSNotification
//tabbar上面数字加1的动画显示，周洋写的，我删了
- (void)shopCarBadgeValueAdd:(NSNotification *)notification {
    
//    UIViewController *vc = self.tabBarController.viewControllers[3];
//    NSInteger badgeValue = [vc.tabBarItem.badgeValue integerValue];
//    badgeValue += 1;
//    vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)badgeValue];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark  快消失的时候
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //将要隐藏的时候设置不可拨动
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
}
#pragma mark ----- topLineView
- (void)setHeadLineView {
    headlineView *headline = [[headlineView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 60) color:kColor_RGB(217, 57, 84)];
    headline.userInteractionEnabled = YES;
    [headline.leftBtn addTarget:self action:@selector(setLeftViewController) forControlEvents:UIControlEventTouchUpInside];
    [headline.searchBtn addTarget:self action:@selector(setSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headline];
}
#pragma mark ----- setCollectionHeadView
- (void)setCollectionHeadView {
    
    _collectionHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 403)];
    _collectionHeadView.backgroundColor = [UIColor whiteColor];
    LYYScrollView *scrollView = [[LYYScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, scrollViewHight) images:self.scrollArray];
    scrollView.pageControl.pageIndicatorTintColor = kColor_RGB(158, 148, 151);
    scrollView.pageControl.currentPageIndicatorTintColor = kColor_RGB(253, 106, 61);
    //排序
    functionView *functionViews = [[functionView alloc]initWithFrame:CGRectMake(0, scrollViewHight + 181, SCREEN_WIDTH, 52) color:[UIColor whiteColor]];
    //8个功能
    topCollectionView *topViews = [[topCollectionView alloc]initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 181) color:[UIColor whiteColor]];
    /** 排序 */
    [functionViews.newsBtn addTarget:self action:@selector(setNewBtn) forControlEvents:UIControlEventTouchUpInside];
    [functionViews.progressBtn addTarget:self action:@selector(setprogressBtn) forControlEvents:UIControlEventTouchUpInside];
    [functionViews.allDemand addTarget:self action:@selector(setallDemand) forControlEvents:UIControlEventTouchUpInside];
    [functionViews.cheapBtn addTarget:self action:@selector(setcheapBtn) forControlEvents:UIControlEventTouchUpInside];
    [_collectionHeadView addSubview:topViews];
    [_collectionHeadView addSubview:scrollView];
    [_collectionHeadView addSubview:functionViews];
}

#pragma mark ----- setCollectionView
- (void)setHomePageCollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.itemSize = CGSizeMake(ItemSize, 267);
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 403);
    
    _homePagecollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 60 - 40) collectionViewLayout:flowLayout];
    _homePagecollection.delegate   = self;
    _homePagecollection.dataSource = self;
    _homePagecollection.backgroundColor = kColor_RGB(244, 242, 242);
    /** 注册collectionView cell 的重用池*/
    [_homePagecollection registerNib:[UINib nibWithNibName:@"HomePageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:registert];
    _homePagecollection.showsVerticalScrollIndicator = NO;
    _homePagecollection.showsHorizontalScrollIndicator = NO;
    //    /** 注册collectionView 头视图的重用池*/
    [_homePagecollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:_homePagecollection];
    
}
#pragma mark ----- <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.collectionArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:registert forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    //点中cell的时候 没有任何状态
    //小封装 把可变数组里的数据放到模型里 然后将模型放到cell的数组里 然后赋值
    pageGoodsModel *model = self.collectionArray[indexPath.row];
    cell.goodsModel = model;
    [cell.boxBtn addTarget:self action:@selector(setJoinBoxView:) forControlEvents:UIControlEventTouchUpInside];
    if ([model.makeup_price intValue] == 0) {
        cell.JiFenLabel.hidden = YES;
    } else if ([model.makeup_price intValue] != 0) {
        cell.JiFenLabel.hidden = NO;
    }
    //通过按钮的和cell相同的tag值，拿到相对应的cell,在获取cell上的图片
    cell.boxBtn.tag = indexPath.row;
    return cell;
}

#pragma mark ----- 商品详情
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    pageGoodsModel *model = self.collectionArray[indexPath.row];
    NSNumber * IDNums = @([model.ID integerValue]);
    commodityDetailedViewController *commodity = [[commodityDetailedViewController alloc]init];
    commodity.identifying = IDNums;
    LDLog(@"%@", commodity.identifying );
    
    [self.navigationController pushViewController:commodity animated:YES];
}
//CollectionHeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:_collectionHeadView];
    
    return headerView;
}

#pragma mark ----- 弹出左侧控制器
- (void)setLeftViewController {
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
//右侧搜索
- (void)setSearchBtn {
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}

#pragma mark ----- setJoinBoxView 加入清单动画 提示框
- (void)setJoinBoxView:(UIButton *)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    NSLog(@"%@",indexPath);
    HomePageCollectionViewCell *cell = (HomePageCollectionViewCell *)[self.homePagecollection cellForItemAtIndexPath:indexPath];
    NSString* userid;
    //判断登入
    [[LDUserInfo sharedLDUserInfo] readUserInfo];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [user objectForKey:@"isLogin"];
    if ([isLogin intValue] == 0) {
        if ([LDUserInfo sharedLDUserInfo].isLogin == YES) {
            //读取本地数据 获取用户ID
            [[LDUserInfo sharedLDUserInfo] readUserInfo];
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
                           @"cpid":cell.ID,
                           @"chutype":@"2",
                           @"num":@"1"};
    [ProgressHUD show];
    [QLRequest submitOrder:para success:^(id response) {
        [ProgressHUD dismiss];
//        NSLog(@"打印一下返回:%@",response);
        if (!([response[@"code"] integerValue]==97100)) {
            [ProgressHUD showError:@"加入购物车失败"];
        }
    } error:^(id response) {
        [ProgressHUD dismiss];
        [ProgressHUD showError:@"加入购物车失败"];
    }];
    
    //下面是周洋写的，别动它
    GoodsIDs = [NSMutableDictionary dictionary];
    /** 点击的商品ID  状态 */
    [GoodsIDs setValue:@"1" forKey:@"jionNum"];
    [GoodsIDs setValue:@"1" forKey:@"status"];
    [GoodsIDs setValue:cell.ID forKey:@"goodsID"];
    [ShopsIDs addObject:GoodsIDs];
    LDLog(@"%@",GoodsIDs);
    LDLog(@"%@",ShopsIDs);

    [self addProductsAnimation:cell.homeImage dropToPoint:CGPointMake(SCREEN_WIDTH - 110, SCREEN_HEIGHT - 40) isNeedNotification:YES];
    self.addShopCarFinished = ^{
        LDLog(@"完成了动画（如果不使用通知的方式，可以使用这种方式）");
    };
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
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.collectionArray];
            //移除原先的数据
            [self.collectionArray removeAllObjects];
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
            self.collectionArray = arrayM;
            //结束上拉加载动作
            [weakself.homePagecollection footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            //弹出小窗口 显示加载成功
            [ProgressHUD showSuccess:@"加载成功"];
        }else{
            //移除所有数据
            [self.collectionArray removeAllObjects];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                pageGoodsModel *goodsModel = [pageGoodsModel getLoadDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里
                [self.collectionArray addObject:goodsModel];
            }
            //结束下拉加载的动画
            [weakself.homePagecollection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
            [ProgressHUD showSuccess:@"刷新成功"];
            
        }
        [self.homePagecollection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        [weakself.homePagecollection headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
        [weakself.homePagecollection footerSetState:CoreFooterViewRefreshStateFailed];
        LDLog(@"失败 = %@",error);
    }];
}
//添加上下刷新的控件
- (void)setRefreshTheUpAndDown {
    [self.homePagecollection addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.homePagecollection addFooterWithTarget:self action:@selector(foorterRefresh)];
    //队里延迟显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //数据刷新中
        [self.homePagecollection headerSetState:CoreHeaderViewRefreshStateRefreshing];
    });
    
}

#pragma mark  动态顶部刷新
-(void)headerRefresh{
    p = 1;
    LDWeakSelf(self);
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/product/pagesize/%d/nowpage/%d/off/2",LoadingNumber, p];
    if (weakself.collectionArray.count != 0) {
        [weakself.collectionArray removeAllObjects];
    }
    if (weakself.collectionArray.count == 0) {
        [weakself loadCollectionCellData:urlStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.homePagecollection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
        });
    }else{
        [weakself.homePagecollection headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.homePagecollection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
    });
    [self.homePagecollection reloadData];
}
#pragma mark ----- 动态底部刷新
-(void)foorterRefresh{
    p++;
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/product/pagesize/%d/nowpage/%d/off/2",LoadingNumber, p];
    [self loadCollectionCellData:urlStr];
}

#pragma mark ----- 获取首页幻灯片数据
- (void)getHomePageScollViewImages {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [session GET:@"http://myadmin.all-360.com:8080/Admin/AppApi/falsh" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        LDLog(@"%@",dataArray);
        [self.scrollArray removeAllObjects];
        //把dataArray 里面的数据放到数据源里
        [self.scrollArray addObjectsFromArray:dataArray];
        LDLog(@"%@",self.scrollArray);
        //collectionHeadView  //
        [self setCollectionHeadView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"error = %@",error);
    }];
}

#pragma mark ----- 排序
- (void)setNewBtn {
    //self.collectionArray  目标数组 调用方法  /*sortedArrayUsingSelector:* 数组比较的方法 */
    NSArray *sorted = [self.collectionArray sortedArrayUsingSelector:@selector(compareReQi:)];
    /** 显示排序效果 */

    //数据清空
    [self.collectionArray removeAllObjects];
    //把重新排列好的数据放入数据源累
    [self.collectionArray addObjectsFromArray:sorted];
    //刷新视图显示
    [self.homePagecollection reloadData];
}
- (void)setprogressBtn {
    //self.collectionArray  目标数组 调用方法  /*sortedArrayUsingSelector:* 数组比较的方法 */
    NSArray *sorted = [self.collectionArray sortedArrayUsingSelector:@selector(compareID:)];
    /** 显示排序效果 */

    //数据清空
    [self.collectionArray removeAllObjects];
    //把重新排列好的数据放入数据源累
    [self.collectionArray addObjectsFromArray:sorted];
    //刷新视图显示
    [self.homePagecollection reloadData];
}
- (void)setallDemand {
    //self.collectionArray  目标数组 调用方法  /*sortedArrayUsingSelector:* 数组比较的方法 */
    NSArray *sorted = [self.collectionArray sortedArrayUsingSelector:@selector(compareZhigoujiaDa:)];

    //数据清空
    [self.collectionArray removeAllObjects];
    //把重新排列好的数据放入数据源累
    [self.collectionArray addObjectsFromArray:sorted];
    //刷新视图显示
    [self.homePagecollection reloadData];
}
- (void)setcheapBtn {
    //self.collectionArray  目标数组 调用方法  /*sortedArrayUsingSelector:* 数组比较的方法 */
    NSArray *sorted = [self.collectionArray sortedArrayUsingSelector:@selector(compareZhigoujiaXiao:)];

    //数据清空
    [self.collectionArray removeAllObjects];
    //把重新排列好的数据放入数据源累
    [self.collectionArray addObjectsFromArray:sorted];
    //刷新视图显示
    [self.homePagecollection reloadData];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
