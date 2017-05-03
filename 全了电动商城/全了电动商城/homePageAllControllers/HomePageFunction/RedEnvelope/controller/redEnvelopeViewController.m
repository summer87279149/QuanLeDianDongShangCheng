//
//  redEnvelopeViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/8.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "redEnvelopeViewController.h"
#import "redBagModel.h"
#import "redTableViewCell.h"
#import "loginViewController.h"
@interface redEnvelopeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *redTableView;
@property (nonatomic , strong)NSString *userNumber;
@property (nonatomic , strong)NSMutableArray *dataModelArr;
@end
int YeShu;
static NSString *indentifier = @"cell";
@implementation redEnvelopeViewController
- (NSMutableArray *)dataModelArr {
    if (!_dataModelArr) {
        _dataModelArr = [NSMutableArray array];
    }
    return _dataModelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigation];
    [self setTableViewC];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
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

    [self setRefreshTheUpAndDown];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    self.title = @"我的红包";
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

- (void)setTableViewC {
    self.redTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.redTableView registerNib:[UINib nibWithNibName:@"redTableViewCell" bundle:nil] forCellReuseIdentifier:indentifier];
    _redTableView.delegate = self;
    _redTableView.dataSource = self;
    [self.view addSubview:_redTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    redTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    redBagModel *model = self.dataModelArr[indexPath.row];
    cell.model = model;
    if ([cell.redBagStatu.text isEqualToString:@"未使用"]) {
        cell.useDate.hidden = YES;
    } else if ([cell.redBagStatu.text isEqualToString:@"已使用"]) {
        cell.useDate.hidden = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 167;
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
        if (YeShu>1) {
            //先将上次加载的数据保存到新的数组里
            NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.dataModelArr];
            //移除原先的数据
            [self.dataModelArr removeAllObjects];
            //创建一个新的可变数组  用于存放新的数据
            NSMutableArray *newArray  = [NSMutableArray array];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                redBagModel *goodsModel = [redBagModel setRedBagDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里//把数据放到新的可变数组里
                [newArray addObject:goodsModel];
            }
            //把新数组里的数据存放到存放第一次加载数据的数组里
            [arrayM addObjectsFromArray:newArray];
            //把合并后的数据源数组 赋值给你的数据源数组啊
            self.dataModelArr = arrayM;
            //结束上拉加载动作
            [weakself.redTableView footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            //弹出小窗口 显示加载成功
            [ProgressHUD showSuccess:@"加载成功"];
        }else{
            //移除所有数据
            [self.dataModelArr removeAllObjects];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                redBagModel *goodsModel = [redBagModel setRedBagDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里
                [self.dataModelArr addObject:goodsModel];
            }
            //结束下拉加载的动画
            [weakself.redTableView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
            [ProgressHUD showSuccess:@"刷新成功"];
        }
        [self.redTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        [weakself.redTableView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
        [weakself.redTableView footerSetState:CoreFooterViewRefreshStateFailed];
        LDLog(@"失败 = %@",error);
    }];
}
//添加上下刷新的控件
- (void)setRefreshTheUpAndDown {
    [self.redTableView addHeaderWithTarget:self action:@selector(headerRefreshEvent)];
    [self.redTableView addFooterWithTarget:self action:@selector(foorterRefreshEvent)];
    //队里延迟显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //数据刷新中
        [self.redTableView headerSetState:CoreHeaderViewRefreshStateRefreshing];
    });
    
}

#pragma mark  动态顶部刷新
-(void)headerRefreshEvent{
    YeShu = 1;
    LDWeakSelf(self);
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/hongBaoList/uid/%@/pagesize/%d/nowpage/%d",self.userNumber,LoadingNumber, YeShu];
    if (weakself.dataModelArr.count != 0) {
        [weakself.dataModelArr removeAllObjects];
    }
    if (weakself.dataModelArr.count == 0) {
        [weakself loadCollectionCellData:urlStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.redTableView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
        });
    }else{
        [weakself.redTableView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.redTableView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
    });
    [self.redTableView reloadData];
}
#pragma mark ----- 动态底部刷新
-(void)foorterRefreshEvent{
    YeShu++;
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/hongBaoList/uid/%@/pagesize/%d/nowpage/%d",self.userNumber,LoadingNumber, YeShu];
    [self loadCollectionCellData:urlStr];
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
