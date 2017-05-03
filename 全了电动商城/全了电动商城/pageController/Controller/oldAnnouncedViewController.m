//
//  oldAnnouncedViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/6.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "oldAnnouncedViewController.h"
#import "oldCollectionViewCell.h"
#import "oldAnnouncedModel.h"
@interface oldAnnouncedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong)UICollectionView *collection;
@property (nonatomic , strong)NSMutableArray *dataArray;
@end
int p = 1;
static NSString *reuseIndentifier = @"cell";
@implementation oldAnnouncedViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setcollectionView];
    [self configNavigation];
    [self setRefreshTheUpAndDown];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"往期揭晓";
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /** 转换期号 和 产品ID */
    self.identi = [self.indentif intValue];
    self.dateNum = [self.date intValue];

}
- (void) dealBack {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ----- setcollectionView
- (void)setcollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 8;
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH - 10, 150);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.showsVerticalScrollIndicator = NO;
    _collection.backgroundColor = kColor_RGB(240, 240, 240);
    [_collection registerNib:[UINib nibWithNibName:@"oldCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIndentifier];
    [self.view addSubview:_collection];
}
#pragma mark ----- UICollectionViewDelegate,UICollectionViewDataSource 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    oldCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentifier forIndexPath:indexPath];
    oldAnnouncedModel *model = self.dataArray[indexPath.row];
    cell.oldModel = model;
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
        if (p>1) {
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.dataArray];
            [self.dataArray removeAllObjects];
            NSMutableArray *newArray = [NSMutableArray array];
            for (NSDictionary *tempDic in dataArray) {
                oldAnnouncedModel *model = [oldAnnouncedModel setOldDataWithDic:tempDic];
                [newArray addObject:model];
            }
            [arrayM addObjectsFromArray:newArray];
            self.dataArray = arrayM;
            //结束上拉加载动作
            [weakself.collection footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            //弹出小窗口 显示加载成功
            [ProgressHUD showSuccess:@"加载成功"];
        }else {
            [self.dataArray removeAllObjects];
            for (NSDictionary *tempDic in dataArray) {
                oldAnnouncedModel *model = [oldAnnouncedModel setOldDataWithDic:tempDic];
                [self.dataArray addObject:model];
            }
            [weakself.collection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
            [ProgressHUD showSuccess:@"刷新成功"];
        }
        [self.collection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        [weakself.collection headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
        [weakself.collection footerSetState:CoreFooterViewRefreshStateFailed];
        LDLog(@"失败 = %@",error);
    }];

}
//添加上下刷新的控件
- (void)setRefreshTheUpAndDown {
    [self.collection addHeaderWithTarget:self action:@selector(headerRefresh)];
    [self.collection addFooterWithTarget:self action:@selector(foorterRefresh)];
    //队里延迟显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //数据刷新中
        [self.collection headerSetState:CoreHeaderViewRefreshStateRefreshing];
    });
    
}

#pragma mark  动态顶部刷新
-(void)headerRefresh{
    p = 1;
    LDWeakSelf(self);
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/announced/sid/%d/qihao/%d/type/past/nowpage/%d/pagesize/%d",self.identi,self.dateNum,p,LoadingNumber];
    if (weakself.dataArray.count != 0) {
        [weakself.dataArray removeAllObjects];
    }
    if (weakself.dataArray.count == 0) {
        [weakself loadOldAnnouncedData:urlStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
        });
    }else{
        [weakself.collection headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
    });
    [self.collection reloadData];
}
#pragma mark ----- 动态底部刷新
-(void)foorterRefresh{
    p++;
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/announced/sid/%d/qihao/%d/type/past/nowpage/%d/pagesize/%d",self.identi,self.dateNum,p,LoadingNumber];
    [self loadOldAnnouncedData:urlStr];
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
