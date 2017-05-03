//
//  discloseViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "discloseViewController.h"
#import "discloseCollectionViewCell.h"
#import "discloseDataModel.h"
#import "commodityDetailedViewController.h"
@interface discloseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong)UICollectionView *discloseCollection;
@property (nonatomic , strong)NSMutableArray *dataModelArray;
@end
static int p = 1;
static NSString *reuseIdentifier = @"cell";
@implementation discloseViewController
- (NSMutableArray *)dataModelArray {
    if (!_dataModelArray) {
        _dataModelArray = [NSMutableArray array];
    }
    return _dataModelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setDiscloseCollectionView];
    [self configNavgation];
    [self setRefreshTheUpAndDown];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark confugNavgation
- (void)configNavgation {
    //添加颜色
    [self.navigationController.navigationBar setBarTintColor:kColor_RGB(217, 57, 84)];
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置是否为透明
    [self.navigationController.navigationBar setTranslucent:NO];
    
}

#pragma mark ----- setDiscloseCollectionView 
- (void)setDiscloseCollectionView {
    UICollectionViewFlowLayout *flowLayou = [UICollectionViewFlowLayout new];
    flowLayou.minimumInteritemSpacing = 0.5;
    flowLayou.minimumLineSpacing = 0.5;
    flowLayou.itemSize = CGSizeMake((SCREEN_WIDTH - 1)/2, 228);
    flowLayou.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayou.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _discloseCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayou];
    _discloseCollection.showsVerticalScrollIndicator = NO;
    _discloseCollection.showsHorizontalScrollIndicator = NO;
    _discloseCollection.backgroundColor = kColor_RGB(224 , 224, 224);
    _discloseCollection.delegate = self;
    _discloseCollection.dataSource = self;
    [_discloseCollection registerNib:[UINib nibWithNibName:@"discloseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_discloseCollection];
}

#pragma mark ----- UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    discloseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    discloseDataModel *model = self.dataModelArray[indexPath.row];
    cell.model = model;
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
}


//添加上下刷新的控件
- (void)setRefreshTheUpAndDown {
    [self.discloseCollection addHeaderWithTarget:self action:@selector(headerRefreshModel)];
    [self.discloseCollection addFooterWithTarget:self action:@selector(foorterRefreshModel)];
    //队里延迟显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //数据刷新中
        [self.discloseCollection headerSetState:CoreHeaderViewRefreshStateRefreshing];
    });
    
}

#pragma mark  动态顶部刷新
-(void)headerRefreshModel{
    p = 1;
    LDWeakSelf(self);
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/announcedNew/pagesize/%d/nowpage/%d",LoadingNumber, p];
    if (weakself.dataModelArray.count != 0) {
        [weakself.dataModelArray removeAllObjects];
    }
    if (weakself.dataModelArray.count == 0) {
        [weakself loadCollectionCellData:urlStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.discloseCollection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
        });
    }else{
        [weakself.discloseCollection headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.discloseCollection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
    });
    [self.discloseCollection reloadData];
}
#pragma mark ----- 动态底部刷新
-(void)foorterRefreshModel{
    p++;
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/announcedNew/pagesize/%d/nowpage/%d",LoadingNumber, p];
    [self loadCollectionCellData:urlStr];
}
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
                discloseDataModel *goodsModel = [discloseDataModel setDiscloseDataModel:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里//把数据放到新的可变数组里
                [newArray addObject:goodsModel];
            }
            //把新数组里的数据存放到存放第一次加载数据的数组里
            [arrayM addObjectsFromArray:newArray];
            //把合并后的数据源数组 赋值给你的数据源数组啊
            self.dataModelArray = arrayM;
            //结束上拉加载动作
            [weakself.discloseCollection footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            //弹出小窗口 显示加载成功
            [ProgressHUD showSuccess:@"加载成功"];
        }else{
            //移除所有数据
            [self.dataModelArray removeAllObjects];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                discloseDataModel *goodsModel = [discloseDataModel setDiscloseDataModel:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里
                [self.dataModelArray addObject:goodsModel];
            }
            //结束下拉加载的动画
            [weakself.discloseCollection headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
            [ProgressHUD showSuccess:@"刷新成功"];
        }
        [self.discloseCollection reloadData];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        [weakself.discloseCollection headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
        [weakself.discloseCollection footerSetState:CoreFooterViewRefreshStateFailed];
        LDLog(@"失败 = %@",error);
    }];
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
