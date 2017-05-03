//
//  boxViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "boxViewController.h"
#import "CollectionViewCell.h"
#import "ClearingViewController.h"
#import "goodsDataModel.h"
@interface boxViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong)UIView *nilView;
@property (nonatomic , strong)UIImageView *nilImageView;
@property (nonatomic , strong)UICollectionView *boxCollection;
@property (nonatomic , strong)NSMutableArray *dataModelArray;
/** FootCollectionView */
@property (nonatomic , strong)UIView *footView;
// 共参与几件奖品
@property (nonatomic , strong)UILabel *bottomLabel;
//
@property (nonatomic , strong)UILabel *bottonNumber;
//总计
@property (nonatomic , strong)UILabel *ZongJiLabel;
//总计数量
@property (nonatomic , strong)UILabel *numberLabel;
//提交订单按钮
@property (nonatomic , strong)UIButton *orderBtn;
//总金额
@property (nonatomic , assign)NSInteger allMoney;
@end
//商品的ID
extern NSMutableArray *ShopsIDs;
static NSString *reuseIdentifier = @"cell";
@implementation boxViewController

- (NSMutableArray *)dataModelArray {
    if (!_dataModelArray) {
        _dataModelArray = [NSMutableArray array];
    }
    return _dataModelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(241, 238, 238);
    [self setFootView];
    [self setNilView];
    [self setBoxCollectionView];
    [self configNavigation];
   

}

#pragma mark - 创建导航栏
- (void)configNavigation {
    self.title = @"宝箱";
    //导航添加背景颜色
    [self.navigationController.navigationBar setBarTintColor:kColor_RGB(217, 57, 84)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.tabBarItem.badgeValue = nil;
    if (ShopsIDs.count == 0) {
        self.nilView.hidden = NO;
        self.boxCollection.hidden = YES;
    }else {
        self.nilView.hidden = YES;
        self.boxCollection.hidden = NO;
    }
    //加载数据
    [self loadCellDatas];
    LDLog(@"%@",ShopsIDs);
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //视图将要小时的时候  删除所有数据  否则一直增加  原因  控制没释放
    [self.dataModelArray removeAllObjects];

}

#pragma mark ----- 如果为空 显示空视图
- (void)setNilView {
    _nilView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _nilView.backgroundColor = kColor_RGB(241, 238, 238);
    [self.view addSubview:_nilView];
    _nilImageView = [UIImageView new];
    _nilImageView.image = [UIImage imageNamed:@"空箱子"];
    [_nilView addSubview:_nilImageView];
    [_nilImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 400));
        make.left.mas_equalTo(0);
    }];
}
#pragma mark ----- setNilView
- (void)setFootView {
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    _footView.backgroundColor = [UIColor whiteColor];
    
    _bottonNumber = [UILabel new];
    _bottonNumber.textColor = [UIColor orangeColor];
    _bottonNumber.text = @"3";
    _bottomLabel.font = [UIFont systemFontOfSize:13];
    [_footView addSubview:_bottonNumber];
    
    _bottomLabel = [UILabel new];
    _bottomLabel.text = [NSString stringWithFormat:@"共参与%lu件商品",(unsigned long)ShopsIDs.count];
    _bottomLabel.textColor = [UIColor grayColor];
    _bottomLabel.font = [UIFont systemFontOfSize:13];
    [_footView addSubview:_bottomLabel];
    
    

    _orderBtn = [UIButton new];
    [_orderBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _orderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_orderBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_orderBtn addTarget:self action:@selector(setOrderBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:_orderBtn];
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(240, 20));
    }];
    [_orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}
#pragma mark ----  点击提交定单
- (void)setOrderBtn: (UIButton *)sender {

    [self.navigationController pushViewController:[ClearingViewController new] animated:YES];
}
#pragma mark ----- setBoxCollectionView
- (void)setBoxCollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 140);
    //flowLayout.sectionFootersPinToVisibleBounds = YES;
    flowLayout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 60);
    _boxCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 110) collectionViewLayout:flowLayout];
    _boxCollection.delegate = self;
    _boxCollection.dataSource = self;
    _boxCollection.showsVerticalScrollIndicator = NO;
    _boxCollection.showsHorizontalScrollIndicator = NO;
    _boxCollection.backgroundColor = kColor_RGB(241, 238, 238);
    [_boxCollection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    /** 注册collectionView 尾部视图的重用池*/
    [_boxCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.view addSubview:_boxCollection];

}
#pragma mark ----- <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataModelArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    goodsDataModel *model = self.dataModelArray[indexPath.row];
    //把indexpath传到cell里面
    cell.row = indexPath.row;

    //判断状态
    if ([model.status intValue] == 1) {
        cell.model = model;
        cell.dataLabel.hidden = NO;
        cell.ShenYuLabel.hidden = NO;
        cell.AllMoneytopLine.constant = 8;
        cell.DanJiaLabel.font = [UIFont systemFontOfSize:13];
//        cell.row = indexPath.row;
    }else if ([model.status intValue] == 2) {
        cell.model = model;
        cell.dataLabel.hidden = YES;
        cell.ShenYuLabel.hidden = YES;
        cell.AllMoneytopLine.constant = -10;
        cell.DanJiaLabel.font = [UIFont systemFontOfSize:17];
        cell.DanJiaLabel.text = [NSString stringWithFormat:@"全直购价:%@元",model.zhigoujia];
    }else if ([model.status intValue] == 3) {
        cell.model = model;
        cell.dataLabel.hidden = YES;
        cell.ShenYuLabel.hidden = YES;
        cell.AllMoneytopLine.constant = -10;
        cell.DanJiaLabel.font = [UIFont systemFontOfSize:17];
        cell.DanJiaLabel.text = [NSString stringWithFormat:@"积分购:%@元 + %@积分",model.makeup_price,model.score_price];
    }
#pragma mark   价格显示 block?
    //实现方法
    cell.block = ^(UIButton *btn , goodsDataModel *model) {
        //删除当前的cell数据
        [self.dataModelArray removeObject:model];
        //刷新视图控制器
        [self.boxCollection reloadData];
        
    };
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    footerView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:_footView];

    return footerView;
}

- (void)loadCellDatas {
    for (NSDictionary *dic in ShopsIDs) {
        LDLog(@"%lu---%@",(unsigned long)ShopsIDs.count,ShopsIDs);
        NSString *statusStr = [NSString stringWithFormat:@"%@",dic[@"status"]];
        NSString *GoodsNum = [NSString stringWithFormat:@"%@",dic[@"jionNum"]];
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/productShow/id/%@",dic[@"goodsID"]];
        [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LDLog(@"%@",responseObject);
            NSDictionary *dataDic = responseObject;
            NSArray *dataArray = dataDic[@"data"];
            for (NSDictionary *tempDic in dataArray) {
                NSLog(@"%lu",(unsigned long)dataArray.count);
                goodsDataModel *model = [goodsDataModel setDataWithDic:tempDic];
                //赋值状态
                model.status = statusStr;
                model.shopsNum = GoodsNum;
                [self.dataModelArray addObject:model];
            }
            [self.boxCollection reloadData];
            _bottomLabel.text = [NSString stringWithFormat:@"共参与%lu件商品",(unsigned long)ShopsIDs.count];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LDLog(@"error = %@",error);
        }];
    }
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
