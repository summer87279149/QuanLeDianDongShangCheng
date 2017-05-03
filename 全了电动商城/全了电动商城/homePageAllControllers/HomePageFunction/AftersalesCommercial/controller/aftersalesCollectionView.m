//
//  aftersalesCollectionView.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/31.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "aftersalesCollectionView.h"
#import "AftersalesModel.h"
#import "ACCollectionViewCell.h"
#import "AftersalesCommercial.h"
@interface aftersalesCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong)UICollectionView *ACCollectionView;
@property (nonatomic , strong)NSMutableArray *dataModelArray;

@end
int page = 1;
static NSString *reuseIndentifier = @"cell";
@implementation aftersalesCollectionView
- (NSMutableArray *)dataArray {
    if (!_dataModelArray) {
        _dataModelArray = [NSMutableArray array];
    }
    return _dataModelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setcollectionViewC];
    [self configNavigation];
    [self setRefreshTheUpAndDown];
    
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 15);
    [backButton setBackgroundImage:[UIImage imageNamed:@"箭头白"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dealBack) forControlEvents:UIControlEventTouchUpInside];
    UIButton *GoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    GoBtn.frame = CGRectMake(0, 0, 60, 15);
    [GoBtn setTitle:@"立即加入" forState:UIControlStateNormal];
    GoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [GoBtn addTarget:self action:@selector(setLestView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bacItem = [[UIBarButtonItem alloc] initWithCustomView:GoBtn];
    self.navigationItem.rightBarButtonItem = bacItem;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //导航添加背景颜色
    [self.navigationController.navigationBar setBarTintColor:kColor_RGB(217, 57, 84)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    if ([self.statuNumber intValue] == 1) {
        self.title = @"代理商";
    }else {
        self.title = @"售后商";
    }
}
- (void) dealBack {
    [self.navigationController popViewControllerAnimated:YES];
}
//上传界面
- (void)setLestView {
    AftersalesCommercial *AC = [AftersalesCommercial new];
    AC.statuNum = self.statuNumber;
    [self.navigationController pushViewController:AC animated:YES];
}
#pragma mark ----- setcollectionView
- (void)setcollectionViewC {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 8;
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH - 10, 300);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    _ACCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _ACCollectionView.delegate = self;
    _ACCollectionView.dataSource = self;
    _ACCollectionView.showsVerticalScrollIndicator = NO;
    _ACCollectionView.backgroundColor = kColor_RGB(240, 240, 240);
    [_ACCollectionView registerNib:[UINib nibWithNibName:@"ACCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIndentifier];
    [self.view addSubview:_ACCollectionView];
}
#pragma mark ----- UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentifier forIndexPath:indexPath];
    AftersalesModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)loadOldAnnouncedData:(NSString *)urlStr {
    LDWeakSelf(self);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        if (page>1) {
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.dataArray];
            [self.dataArray removeAllObjects];
            NSMutableArray *newArray = [NSMutableArray array];
            for (NSDictionary *tempDic in dataArray) {
                AftersalesModel *model = [AftersalesModel setDataModelWithDicL:tempDic];
                [newArray addObject:model];
            }
            [arrayM addObjectsFromArray:newArray];
            self.dataModelArray = arrayM;
            //结束上拉加载动作
            [weakself.ACCollectionView footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            //弹出小窗口 显示加载成功
            [ProgressHUD showSuccess:@"加载成功"];
        }else {
            [self.dataArray removeAllObjects];
            for (NSDictionary *tempDic in dataArray) {
                AftersalesModel *model = [AftersalesModel setDataModelWithDicL:tempDic];
                [self.dataArray addObject:model];
            }
            [weakself.ACCollectionView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
            [ProgressHUD showSuccess:@"刷新成功"];
        }
        [self.ACCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        [weakself.ACCollectionView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
        [weakself.ACCollectionView footerSetState:CoreFooterViewRefreshStateFailed];
        LDLog(@"失败 = %@",error);
    }];
    
}
//添加上下刷新的控件
- (void)setRefreshTheUpAndDown {
    [self.ACCollectionView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.ACCollectionView addFooterWithTarget:self action:@selector(foorterRefresh)];
    //队里延迟显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //数据刷新中
        [self.ACCollectionView headerSetState:CoreHeaderViewRefreshStateRefreshing];
    });
    
}

#pragma mark  动态顶部刷新
-(void)headerRefresh{
    page = 1;
    LDWeakSelf(self);
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/agentList/type/%@/nowpage/%d/pagesize/%d",self.statuNumber,page,LoadingNumber];
    if (weakself.dataArray.count != 0) {
        [weakself.dataArray removeAllObjects];
    }
    if (weakself.dataArray.count == 0) {
        [weakself loadOldAnnouncedData:urlStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.ACCollectionView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
        });
    }else{
        [weakself.ACCollectionView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.ACCollectionView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
    });
    [self.ACCollectionView reloadData];
}
#pragma mark ----- 动态底部刷新
-(void)foorterRefresh{
    page++;
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/agentList/type/%@/nowpage/%d/pagesize/%d",self.statuNumber,page,LoadingNumber];
    [self loadOldAnnouncedData:urlStr];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
