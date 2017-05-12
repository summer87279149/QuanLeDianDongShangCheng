//
//  myViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/30.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "myViewController.h"
#import "myTopView.h"
#import "myCollectionModel.h"
#import "myCollectionViewCell.h"
#import "AllMyController.pch"
#import "MyTableViewCell.h"
#import "myDataModel.h"


@interface myViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UICollectionView *myCollection;
@property (nonatomic , strong)UITableView *myTabelView;
@property (nonatomic , strong)NSString *userNumber;
@property (nonatomic , strong)myTopView *topsView;

@property (nonatomic, strong) NSString *qrImgStr;
@end

static NSString *reuseIndentifier = @"cell";
static NSString *Indentifier = @"TabelCell";
@implementation myViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(241, 238, 238);
    [self.navigationController setNavigationBarHidden:YES];
    [self setTopView];
    [self setMyCollectionView];
    [self setTabelViewController];
    [QLRequest shareSuccess:^(id response) {
        NSLog(@"%@",response);
        if ([response[@"code"]intValue]==95000) {
            self.qrImgStr = response[@"data"];
        }
    } error:^(id response) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    LDUserInfo* u = [LDUserInfo sharedLDUserInfo];
    [u readUserInfo];
    NSLog(@"打印 UID%@",u.ID);
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = NO;
    
    //取本地信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [user objectForKey:@"isLogin"];
    if ([isLogin intValue] == 0) {
        if ([LDUserInfo sharedLDUserInfo].isLogin == YES) {
            //读取本地数据 获取用户ID
            [[LDUserInfo sharedLDUserInfo] readUserInfo];
            self.userNumber = [LDUserInfo sharedLDUserInfo].ID ;
            
        } else {
            //如果没登录就跳转
            [self.navigationController pushViewController:[loginViewController new] animated:YES];
        }
    }else if ([isLogin intValue] != 0) {
        self.userNumber = [user objectForKey:@"userID"];
    }
    
    [self setMyDatas];
}

#pragma  mark ----- setTopView
- (void)setTopView {
    _topsView = [[NSBundle mainBundle] loadNibNamed:
                 @"myTopView" owner:nil options:nil ].lastObject;
    _topsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3);
    //如果登录  设置信息
    [_topsView.LoginBtn setTitle:@"退出" forState:UIControlStateNormal];
    [_topsView.settingBtn addTarget:self action:@selector(gotoPersonalViewController) forControlEvents:UIControlEventTouchUpInside];
    [_topsView.payBtn addTarget:self action:@selector(gotoReachargeViewController) forControlEvents:UIControlEventTouchUpInside];
    [_topsView.LoginBtn addTarget:self action:@selector(gotoLoginViewController) forControlEvents:UIControlEventTouchUpInside];
    if (IS_IPHONE_5 | IS_IPHONE_6) {
        _topsView.bottomLine.constant = -70;
    }
    /** 圆形 */
    _topsView.userImage.layer.masksToBounds = YES;
    _topsView.userImage.layer.cornerRadius = _topsView.userImage.bounds.size.width * 0.5;
    _topsView.userImage.layer.borderWidth = 2;
    _topsView.userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:_topsView];
}

#pragma  mark ----- setMyCollectionView
- (void)setMyCollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = (SCREEN_WIDTH - 100 - 180)/2;
    flowLayout.sectionInset = UIEdgeInsetsMake(3, 50, 3, 50);
    flowLayout.itemSize = CGSizeMake(60, 60);
    _myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3, SCREEN_WIDTH, 66) collectionViewLayout:flowLayout];
    _myCollection.backgroundColor = [UIColor whiteColor];
    _myCollection.delegate= self;
    _myCollection.dataSource = self;
    _myCollection.showsVerticalScrollIndicator = NO;
    [_myCollection registerNib:[UINib nibWithNibName:@"myCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIndentifier];
    [self.view addSubview:_myCollection];
}

#pragma mark ----- UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [myCollectionModel new].imagesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    myCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentifier forIndexPath:indexPath];
    cell.myImage.image = [UIImage imageNamed:[myCollectionModel new].imagesArray[indexPath.row]];
    cell.myLabel.text  = [myCollectionModel new].labelsArray[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[RechargeViewController new] animated:YES];
            break;
        case 1:
        {
            integralViewController *ViewVC = [[integralViewController alloc]init];
            ViewVC.userID = self.userNumber;
            [self.navigationController pushViewController:ViewVC animated:YES];
        }
            break;
        case 2:
        {
            baskOrderViewController *baskVC = [[baskOrderViewController alloc]init];
            baskVC.uid = self.userNumber;
            [self.navigationController pushViewController:baskVC animated:YES];
        }
            break;
    }
}
#pragma mark ----- setTabelViewController
- (void)setTabelViewController {
    _myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, _myCollection.bounds.size.height+SCREEN_HEIGHT/3, SCREEN_WIDTH, SCREEN_HEIGHT - 50 -_myCollection.bounds.size.height-SCREEN_HEIGHT/3) style:UITableViewStylePlain];
    _myTabelView.delegate = self;
    _myTabelView.dataSource = self;
    _myTabelView.showsVerticalScrollIndicator = NO;
    _myTabelView.backgroundColor = [UIColor whiteColor];
    [_myTabelView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:Indentifier];
    [self.view addSubview:_myTabelView];
}
#pragma mark ----- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [myCollectionModel new].functionImage.count;
    }else
        return [myCollectionModel new].functionImages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.MarkLabel.text = [myCollectionModel new].functionLabel[indexPath.row];
        cell.MarkImage.image = [UIImage imageNamed:[myCollectionModel new].functionImage[indexPath.row]];
    }else if (indexPath.section == 1) {
        cell.MarkLabel.text = [myCollectionModel new].functionLabels[indexPath.row];
        cell.MarkImage.image = [UIImage imageNamed:[myCollectionModel new].functionImages[indexPath.row]];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = kColor_RGB(242, 242, 242);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [UILabel new];
        label.text = @"声明:所有奖品抽奖活动与苹果公司(Apple Inc.)无关";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view.mas_centerX);
            make.centerY.mas_equalTo(view.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
        }];
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 40;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                ParticipateViewController *participateVC = [[ParticipateViewController alloc]init];
                participateVC.userId = self.userNumber;
                [self.navigationController pushViewController:participateVC animated:YES];
            }else if (indexPath.row == 1) {
                LuckViewController *luckVC = [[LuckViewController alloc]init];
                luckVC.userID = self.userNumber;
                [self.navigationController pushViewController:luckVC animated:YES];
            }else if (indexPath.row == 2) {
                allPriceViewController *allMoneyVC = [[allPriceViewController alloc]init];
                allMoneyVC.userID = self.userNumber;
                [self.navigationController pushViewController:allMoneyVC animated:YES];
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                orderRecordViewController *orderVC = [[orderRecordViewController alloc]init];
                orderVC.userID = self.userNumber;
                [self.navigationController pushViewController:orderVC animated:YES];
            }else if (indexPath.row == 1) {
                intergralRecordViewController *intergralVC = [[intergralRecordViewController alloc]init];
                intergralVC.userID = self.userNumber;
                [self.navigationController pushViewController:intergralVC animated:YES];
            }else if (indexPath.row == 2) {
                adressViewController *adressVC = [[adressViewController alloc]init];
                adressVC.userId = self.userNumber;
                [self.navigationController pushViewController:adressVC animated:YES];
            }else if (indexPath.row == 3){
                
                shareViewController *shareVC = [[shareViewController alloc]init];
                shareVC.qrImgStr = self.qrImgStr;
                [self.navigationController pushViewController:shareVC animated:YES];
            }
            break;
    }
}
#pragma mark ----- 个人设置界面
- (void)gotoPersonalViewController {
    personalInformationTableViewController *personal = [[personalInformationTableViewController alloc]init];
    int userNum = [self.userNumber intValue];
    personal.userID = userNum;
    [self.navigationController pushViewController:personal animated:YES];
}
//充值界面
- (void)gotoReachargeViewController {
    RechargeViewController *rechargeVC = [[RechargeViewController alloc]init];
    rechargeVC.userUID = self.userNumber;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
//登录界面
- (void)gotoLoginViewController {
    [LDUserInfo sharedLDUserInfo].isLogin = NO;
    [[LDUserInfo sharedLDUserInfo] saveUsrtInfo];
    [self.navigationController pushViewController:[loginViewController new] animated:YES];
}



#pragma mark ----- 加载个人信息 显示在主页上
- (void)setMyDatas {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    int userID = [self.userNumber intValue];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/userInfo/uid/%d",userID];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            myDataModel *model = [myDataModel setMyDatasWithDic:tempDic];
            _topsView.model = model;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"error = %@",error);
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
