//
//  boxViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "payListViewController.h"
#import "loginViewController.h"
#import "boxViewController.h"
#import "CollectionViewCell.h"
#import "ClearingViewController.h"
#import "goodsDataModel.h"
@interface boxViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString*level;//保存用户级别
}
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
    [self configNavigation];
    [self setBoxCollectionView];
    
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
    [self request];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
    _bottomLabel.text = @"总价:";
    _bottomLabel.textColor = [UIColor grayColor];
    _bottomLabel.font = [UIFont systemFontOfSize:13];
    [_footView addSubview:_bottomLabel];
    
    _orderBtn = [UIButton new];
    [_orderBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _orderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_orderBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_orderBtn addTarget:self action:@selector(SBsetOrderBtn:) forControlEvents:UIControlEventTouchUpInside];
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
/** 获取个人信息 */
- (void)loadPersonalModel {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/userInfo/uid/%@",[LDUserInfo sharedLDUserInfo].ID];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            level = tempDic[@"level"];
        }
        //        NSLog(@"只为拿到level：%@",dataDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark ----  点击提交定单
- (void)SBsetOrderBtn: (UIButton *)sender {
    if (self.dataModelArray.count>0) {
        NSMutableArray *arr = [NSMutableArray array];
        for (goodsDataModel *model in self.dataModelArray) {
            NSDictionary*dic = @{@"uid":[LDUserInfo sharedLDUserInfo].ID ,
                                 @"cpid":model.cpid,
                                 @"cpqs":model.dangqishu,
                                 @"chanpindanjia":model.danjia,
                                 @"shuliang":model.shopsNum,
                                 @"chutype":model.status,
                                 @"abot":level,
                                 @"jifen":model.score_price
                                 };
            NSLog(@"dic=%@",dic);
            [arr addObject:dic];
        }
        NSDictionary *para = @{@"dingdan":arr};
        [QLRequest orderRuKuWithPara:para success:^(id response) {
            NSString *orderNumber = response[@"data"];
            payListViewController *vc = [payListViewController new];
            vc.orderNum = orderNumber;
            [self.navigationController pushViewController:vc animated:YES];
        } error:^(id response) {
            
        }];
    }
    
    
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
    [_boxCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.view addSubview:_boxCollection];
//    [_boxCollection addFooterWithCallback:
    [self setNilView];
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
    cell.row = indexPath.row;
    
    //判断状态
    if ([model.status intValue] == 2) {
        cell.model = model;
        cell.dataLabel.hidden = NO;
        cell.ShenYuLabel.hidden = NO;
        cell.AllMoneytopLine.constant = 8;
        cell.DanJiaLabel.font = [UIFont systemFontOfSize:13];
        //        cell.row = indexPath.row;
    }else if ([model.status intValue] == 1) {
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
    
    cell.block = ^(UIButton *btn , goodsDataModel *model) {
        [ProgressHUD show];
        [QLRequest deleteCarItem:[LDUserInfo sharedLDUserInfo].ID carID:model.ID success:^(id response) {
            NSLog(@"%@",response);
            [ProgressHUD dismiss];
            [self request];
            [ProgressHUD showSuccess];
        } error:^(id response) {
            
        }];
    };
    cell.jianBlock=^(UIButton *btn , goodsDataModel *model){
        [ProgressHUD show];
        [QLRequest carNumbersEdit:model.ID type:@"-" success:^(id response) {
            [ProgressHUD dismiss];
            [self request];
            [ProgressHUD showSuccess];
        } error:^(id response) {
            [ProgressHUD dismiss];
        }];
    };
    cell.jiaBlock=^(UIButton *btn , goodsDataModel *model){
        [ProgressHUD show];
        [QLRequest carNumbersEdit:model.ID type:@"+" success:^(id response) {
            [ProgressHUD dismiss];
            [self request];
            [ProgressHUD showSuccess];
        } error:^(id response) {
            [ProgressHUD dismiss];
        }];
    };
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    footerView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:_footView];
    
    return footerView;
}


-(NSString*)judgeLogin{
    NSString *userid;
    [[LDUserInfo sharedLDUserInfo] readUserInfo];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [user objectForKey:@"isLogin"];
    if ([isLogin intValue] == 0) {
        if ([LDUserInfo sharedLDUserInfo].isLogin == YES) {
            [[LDUserInfo sharedLDUserInfo] readUserInfo];
            userid = [LDUserInfo sharedLDUserInfo].ID ;
            
        } else {
//            loginViewController *vc = [loginViewController new] ;
//            vc.type = 1;
//            [self.navigationController pushViewController:vc animated:YES];
            return nil;
        }
    }else if ([isLogin intValue] != 0) {
        userid = [user objectForKey:@"userID"];
    }
    return userid;
    
}
-(void)request{
    NSString* result = [self judgeLogin];
    if (result!=nil) {
        [ProgressHUD show];
        [QLRequest queryCarList:result success:^(id response) {
            [ProgressHUD dismiss];
            [self.dataModelArray removeAllObjects];
            NSLog(@"打印返回gouwuche list:%@",response);
            NSDictionary *dataDic = response;
            NSArray *dataArray = dataDic[@"data"];
            if (dataArray.count==0) {
                _nilView.hidden = NO;
            }else{
                _nilView.hidden = YES;
            }
            for (NSDictionary *tempDic in dataArray) {
                goodsDataModel *model = [goodsDataModel setDataWithDic:tempDic];
                //赋值状态
                [self.dataModelArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.boxCollection reloadData];
            });
        } error:^(id response) {
            [ProgressHUD dismiss];
        }];
        [self queryTotalPrice];
        [self loadPersonalModel];
    }else{
        return;
    }
    
}

-(void)queryTotalPrice{
    [QLRequest totalPrice:[LDUserInfo sharedLDUserInfo].ID  success:^(id response) {
        __block NSString *zongjia = response[@"data"];
        NSLog(@"查询总价：%@",response);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_boxCollection setHeader:CoreHeaderViewRefreshStateNorMal];
            if ([response[@"data"]isKindOfClass:[NSNull class]]) {
                zongjia = @"0";
            }
            _bottomLabel.text = [NSString stringWithFormat:@"总价:%@元",zongjia];
        });
    } error:^(id response) {
    }];
}

#pragma mark ----- 如果为空 显示空视图
- (void)setNilView {
    _nilView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _nilView.backgroundColor = kColor_RGB(241, 238, 238);
    [self.view addSubview:_nilView];
//    _nilView.hidden = YES;
    _nilImageView = [UIImageView new];
    _nilImageView.image = [UIImage imageNamed:@"空箱子"];
    [_nilView addSubview:_nilImageView];
    [_nilImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 400));
        make.left.mas_equalTo(0);
    }];
}

































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
