//
//  adressViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "adressViewController.h"
#import "adressTableViewCell.h"
#import "newAdressViewController.h"
#import "adressModel.h"
@interface adressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIView *bottomView;
@property (nonatomic , strong)UIView *nilView;
@property (nonatomic , strong)NSMutableArray *dataModelArray;
@end
static NSString *reuseIndentifier = @"cell";
@implementation adressViewController
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
    [self setBottomView];
    [self setTableView];
    [self setNilView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    [self loadCollectionCellData];
}
#pragma mark ----- 如果为空则显示空状态
- (void)setNilView {
    _nilView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _nilView.backgroundColor = kColor_RGB(247, 247, 247);
    [self.view addSubview:_nilView];
    _nilView.hidden = YES;
    UILabel *label = [UILabel new];
    label.text = @"地址为空 、快去填写吧 !";
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
    
    self.title = @"地址管理";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 15);
    [backButton setBackgroundImage:[UIImage imageNamed:@"箭头白"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dealBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 40, 20);
    [newBtn setTitle:@"新增" forState:UIControlStateNormal];
    [newBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newBtn addTarget:self action:@selector(gotoNewAdressViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *gotoBtn = [[UIBarButtonItem alloc]initWithCustomView:newBtn];
    self.navigationItem.rightBarButtonItem = gotoBtn;
    //导航添加背景颜色
    [self.navigationController.navigationBar setBarTintColor:kColor_RGB(217, 57, 84)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void) dealBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoNewAdressViewController {
    newAdressViewController *adressVC = [[newAdressViewController alloc]init];
    adressVC.userId = self.userId;
    [self.navigationController pushViewController:adressVC animated:YES];
}
#pragma mark ----- setBottomView 
- (void)setBottomView {
    _bottomView = [UIView new];
    _bottomView.backgroundColor = kColor_RGB(247, 247, 247);
    [self.view addSubview:_bottomView];
    UILabel *label = [UILabel new];
    label.text = @"*地址请尽量填写详细!";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    [_bottomView addSubview:label];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.left.mas_equalTo((SCREEN_WIDTH - 200)/2);
    }];
}
#pragma mark ----- setTableView
- (void)setTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"adressTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIndentifier];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
#pragma mark ----- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    adressModel *model =  self.dataModelArray[indexPath.row];

    [QLRequest deleteAddress:model.addressID success:^(id response) {
        if ([response[@"code"]intValue]==7400) {
            [ProgressHUD showSuccess];
            [self.dataModelArray removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            [ProgressHUD showError:response[@"message"]];
        }
    } error:^(id response) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    adressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
    adressModel *model = self.dataModelArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}






#pragma mark -- 加载数据
- (void)loadCollectionCellData{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/address/uid/%@",self.userId];
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //如果数组 是NSArray  这里是字典就用字典接受responseObject 数据
        NSDictionary *dataDic = responseObject;
        //data 里面是数组  用数组接受
        NSArray *dataArray = dataDic[@"data"];
        
        //移除所有数据
        [self.dataModelArray removeAllObjects];
        //里面是数组就用数组接受 现在是字典
        for (NSDictionary *tempDic in dataArray) {
            //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
            adressModel *goodsModel = [adressModel setAdressDataWithDic:tempDic];
            //有一个可变数组   (转变成模型)把数据放在可变数组里
            [self.dataModelArray addObject:goodsModel];
        }
        [ProgressHUD showSuccess:@"刷新成功"];
        if (self.dataModelArray.count == 0) {
            _nilView.hidden = NO;
        }else
            _nilView.hidden = YES;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        LDLog(@"失败 = %@",error);
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
