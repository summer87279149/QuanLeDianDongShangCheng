//
//  freshmanHelpViewController.m
//  全了电动商城
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "freshmanHelpViewController.h"
//模型
#import "DBSourceDataModel.h"
#import "DBChildModel.h"

//跳转下个显示的控制器
#import "DBShowDetailViewController.h"

@interface freshmanHelpViewController ()<YUFoldingTableViewDelegate>
@property (nonatomic, weak) YUFoldingTableView *foldingTableView;
@property (strong,nonatomic) NSMutableArray *sourceDataArray;
@end

@implementation freshmanHelpViewController

- (NSMutableArray *)sourceDataArray{
    if (!_sourceDataArray) {
        _sourceDataArray = [NSMutableArray array];
        //        _sourceDataArray = [[DBDataManager manager] getSourceDataArray];//本地的json数据
    }
    return _sourceDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavigation];
    // 创建tableView
    [self setupFoldingTableView];
    [self loadSourceData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"常见问题";
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



#pragma mark --    请求数据
- (void )loadSourceData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer  =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof (self) weakSelf = self;
    [manager GET:@"http://myadmin.all-360.com:8080/Admin/AppApi/helpCategory/" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue]==4000) {
            for (NSDictionary* dict in responseObject[@"data"]) {
                DBSourceDataModel* model = [[DBSourceDataModel alloc] initWithDictionary:dict];
                [weakSelf.sourceDataArray addObject:model];
            }
            [weakSelf.foldingTableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"请求数据失败！%@",error.userInfo);
        
    }];
    
}

#pragma mark --     创建表格部分
// 创建tableView
- (void)setupFoldingTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    YUFoldingTableView *foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _foldingTableView = foldingTableView;
    
    [self.view addSubview:foldingTableView];
    foldingTableView.foldingDelegate = self;
}

#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return YUFoldingSectionHeaderArrowPositionLeft;
}

// 返回section头的颜色
- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView backgroundColorForHeaderInSection:(NSInteger )section{
    //这里颜色自己调
    return kColor_RGB(150, 150, 150);
}





- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return self.sourceDataArray.count;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    DBSourceDataModel *model = self.sourceDataArray[section];
    return model.child.count;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    DBSourceDataModel *model = self.sourceDataArray[section];
    return [NSString stringWithFormat:@"%@",model.name];
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    DBSourceDataModel *sourceDataModel = self.sourceDataArray[indexPath.section];
    DBChildModel *childModel = sourceDataModel.child[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",childModel.name];
    
    return cell;
}
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
    DBShowDetailViewController *showVC = [[DBShowDetailViewController alloc] init];
    DBSourceDataModel *model = self.sourceDataArray[indexPath.section];
    DBChildModel *childModel = model.child[indexPath.row];
    showVC.naviTitle = childModel.name;
    showVC.childModel = childModel;
    [self.navigationController pushViewController:showVC animated:YES];
}




//#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）
//
//- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section
//{
//选择实现的方法 section表头  detailText文本显示的内容
//    return @"detailText";
//}

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
