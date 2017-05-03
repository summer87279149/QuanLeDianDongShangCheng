//
//  sideslipViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/25.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "sideslipViewController.h"
#import "sideslipArraysModel.h"
#import "TableViewCell.h"
#import "homePageViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "categoryViewController.h"

@interface sideslipViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 顶部小视图 */
@property (nonatomic , strong)UIView *topView;
/** tabelView */
@property (nonatomic , strong)UITableView *tabelView;
@property (nonatomic , strong)NSMutableArray *datasArray;
/** 传值sid给下个界面 */
@property (nonatomic , strong)NSString *GoodsSid;
@end
static NSString *reuseIdentifier = @"cell";
@implementation sideslipViewController
//数据源
- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopView];
    [self setTabelView];
    [self loadDatas];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
#pragma mark ----- 顶部小视图
- (void)setTopView {
    
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    
    UIButton *backHomeView = [[UIButton alloc]init];
    [backHomeView setImage:[UIImage imageNamed:@"首页"] forState:UIControlStateNormal];
    [backHomeView addTarget:self action:@selector(gotoHomeView) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:backHomeView];
    
    UILabel *backLabel = [UILabel new];
    backLabel.text = @"首页";
    backLabel.font = [UIFont systemFontOfSize:14];
    backLabel.textColor = [UIColor blackColor];
    [_topView addSubview:backLabel];
    
    [self setTopViewMasonry:backHomeView withLabel:backLabel];
}
#pragma mark ----- setTabelView
- (void)setTabelView {
    _tabelView = [[UITableView alloc]init];
    _tabelView.backgroundColor = [UIColor whiteColor];
    _tabelView.delegate   = self;
    _tabelView.dataSource = self;
    _tabelView.tableHeaderView.backgroundColor = kColor_RGB(241, 238, 238);
    [_tabelView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_tabelView];
    [_tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topView.mas_bottom).offset(0);
        make.left.mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - _topView.bounds.size.height));
    }];
}
//返回主界面
- (void)gotoHomeView {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

#pragma mark ----- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    sideslipArraysModel *model = self.datasArray[indexPath.row];
    cell.dataModel = model;
    _GoodsSid = model.ID;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"分类列表";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    sideslipArraysModel *model = self.datasArray[indexPath.row];
    _GoodsSid = model.ID;
    categoryViewController *cateVC = [[categoryViewController alloc]init];
    cateVC.classifyNum = self.GoodsSid;
    [self presentViewController:cateVC animated:YES completion:nil];
    
}

#pragma mark ----- AllMasonry 

- (void)setTopViewMasonry:(UIButton *)backHomeView withLabel:(UILabel *)backLabel {
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    [backHomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_topView.mas_left).offset(10);
        make.centerY.mas_equalTo(_topView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backHomeView.mas_right).offset(10);
        make.centerY.mas_equalTo(_topView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}

#pragma mark ----- loadData
- (void)loadDatas {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [session GET:@"http://myadmin.all-360.com:8080/Admin/AppApi/cateGory" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        [self.datasArray removeAllObjects];
        for (NSDictionary *tempDic in dataArray) {
            sideslipArraysModel *model = [sideslipArraysModel getLoadDataWithDic:tempDic];
            [self.datasArray addObject:model];
        }
        [self.tabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"error = %@",error);
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
