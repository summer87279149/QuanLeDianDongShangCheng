//
//  LuckViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//
#import "baskOrderViewController.h"
#import "LuckViewController.h"
#import "luckModel.h"
#import "luckTableViewCell.h"
#import "AllMyController.pch"

@interface LuckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIView *nilView;
@property (nonatomic , strong)NSMutableArray *dataModelArray;

@end
//页数
static  int p = 1;
static NSString *reuseIndentifier = @"cell";
@implementation LuckViewController
- (NSMutableArray *)dataModelArray {
    if (!_dataModelArray) {
        _dataModelArray = [NSMutableArray array];
    }
    return _dataModelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavigation];
    [self setTableViewController];
    [self setNilView];
    [self setRefreshTheUpAndDown];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark ----- 如果为空则显示空状态
- (void)setNilView {
    _nilView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _nilView.backgroundColor = kColor_RGB(247, 247, 247);
    [self.view addSubview:_nilView];
    _nilView.hidden = YES;
    UILabel *label = [UILabel new];
    label.text = @"您还未中奖、快去参与吧!";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    [_nilView addSubview:label];
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"收藏"];
    [_nilView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo((SCREEN_WIDTH - 200)/2);
        make.size.mas_equalTo(CGSizeMake(200, 300));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        make.left.mas_equalTo((SCREEN_WIDTH - 200)/2);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"幸运记录";
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
#pragma mark ----- setTableViewController
- (void)setTableViewController {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"luckTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIndentifier];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
#pragma mark ----- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    luckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
    cell.winStatus.text = @"恭喜中奖";
    cell.winStatus.textColor = [UIColor redColor];
    luckModel *model = self.dataModelArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
//晒单跳转回去 并且传值
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    luckModel *model = self.dataModelArray[indexPath.row];
//    if (self.block) {
//        self.block(model.name,model.ID,model.cpqs,model.zhonghao);
//    }
    
    //什么乱七八糟的东西，fuck
    baskOrderViewController *vc = [[baskOrderViewController alloc]init];
    vc.uid = [LDUserInfo sharedLDUserInfo].ID;
    vc.shopName = model.name;
    vc.cpid = model.ID;
    vc.qihao = model.cpqs;
    vc.zhongh = model.zhonghao;
    [self.navigationController pushViewController:vc animated:YES];
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
                luckModel *goodsModel = [luckModel setLuckDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里//把数据放到新的可变数组里
                [newArray addObject:goodsModel];
            }
            //把新数组里的数据存放到存放第一次加载数据的数组里
            [arrayM addObjectsFromArray:newArray];
            //把合并后的数据源数组 赋值给你的数据源数组啊
            self.dataModelArray = arrayM;
            //结束上拉加载动作
            [weakself.tableView footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            //弹出小窗口 显示加载成功
            [ProgressHUD showSuccess:@"加载成功"];
        }else{
            //移除所有数据
            [self.dataModelArray removeAllObjects];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                luckModel *goodsModel = [luckModel setLuckDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里
                [self.dataModelArray addObject:goodsModel];
            }
            //结束下拉加载的动画
            [weakself.tableView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
            if (self.dataModelArray.count == 0) {
                
            }
            [ProgressHUD showSuccess:@"刷新成功"];
        }
        if (self.dataModelArray.count == 0) {
            _nilView.hidden = NO;
        }else
            _nilView.hidden = YES;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        [weakself.tableView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
        [weakself.tableView footerSetState:CoreFooterViewRefreshStateFailed];
        LDLog(@"失败 = %@",error);
    }];
}
//添加上下刷新的控件
- (void)setRefreshTheUpAndDown {
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshBtns)];
    [self.tableView addFooterWithTarget:self action:@selector(foorterRefreshBtns)];
    //队里延迟显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //数据刷新中
        [self.tableView headerSetState:CoreHeaderViewRefreshStateRefreshing];
    });
    
}

#pragma mark  动态顶部刷新
-(void)headerRefreshBtns{
    p = 1;
    LDWeakSelf(self);
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/zhongJiangList/pagesize/%d/nowpage/%d/uid/%@",LoadingNumber,p, _userID];
//    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/zhongJiangList/pagesize/%d/nowpage/%d/uid/8594",LoadingNumber,p];
    if (weakself.dataModelArray.count != 0) {
        [weakself.dataModelArray removeAllObjects];
    }
    if (weakself.dataModelArray.count == 0) {
        [weakself loadCollectionCellData:urlStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
        });
    }else{
        [weakself.tableView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
    });
    [self.tableView reloadData];
}
#pragma mark ----- 动态底部刷新
-(void)foorterRefreshBtns{
    p++;
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/zhongJiangList/pagesize/%d/nowpage/%d/uid/%@",LoadingNumber,p, _userID];
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
