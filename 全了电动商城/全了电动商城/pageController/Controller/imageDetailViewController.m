//
//  imageDetailViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/6.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "imageDetailViewController.h"
#import "imagesCollectionViewCell.h"
@interface imageDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//图片数组
@property (nonatomic , strong)NSMutableArray *iamgesArray;
@property (nonatomic , strong)UICollectionView *collectionView;
@end
static NSString *reuseIndentFier = @"cell";
@implementation imageDetailViewController
-(NSArray *)iamgesArray {
    if (!_iamgesArray) {
        _iamgesArray = [NSMutableArray array];
    }
    return _iamgesArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDatas];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(240, 240, 240);
    [self setCollectionView];
    [self configNavigation];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"图文详情";
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
}
#pragma mark ----- setCollectionView
- (void)setCollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = kColor_RGB(240, 240, 240);
    [_collectionView registerNib:[UINib nibWithNibName:@"imagesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIndentFier];
    [self.view addSubview:_collectionView];
    
}
#pragma mark ----- UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.iamgesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    imagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentFier forIndexPath:indexPath];
    [cell.images sd_setImageWithURL:[NSURL URLWithString:self.iamgesArray[indexPath.row]]];
   
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/2);
}

#pragma mark -- 加载数据
- (void)loadDatas {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/picText/id/%@",self.userID];
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        [self.iamgesArray removeAllObjects];
        for (NSMutableArray *tempDic in dataArray) {
            [self.iamgesArray addObject:tempDic];
        }
        [self.collectionView reloadData];
        NSLog(@"%@",self.iamgesArray);
        if (self.iamgesArray.count == 0) {
            [ProgressHUD showSuccess:@"暂无更多图片"];
        }
        [ProgressHUD showSuccess:@"加载成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"error = %@",error);
        [ProgressHUD showError:@"加载失败"];
    }];
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
