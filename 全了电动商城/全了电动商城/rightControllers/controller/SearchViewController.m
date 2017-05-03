//
//  SearchViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/27.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "SearchViewController.h"
#import "LDSeystemInfoModel.h"



@interface SearchViewController ()<YUFoldingTableViewDelegate>
@property (nonatomic, weak) YUFoldingTableView *foldingTableView;
@property (strong,nonatomic) NSMutableArray *sourceDataArray;
@end

@implementation SearchViewController

- (NSMutableArray *)sourceDataArray{
    if (!_sourceDataArray) {
        _sourceDataArray = [NSMutableArray array];
        //        _sourceDataArray = [[DBDataManager manager] getSourceDataArray];//本地的json数据
    }
    return _sourceDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(247, 247, 247);
    
    [self configNavigation];
    
    [self setupFoldingTableView];
    [self loadSourceData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}



#pragma mark --    请求数据
- (void )loadSourceData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer  =[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof (self) weakSelf = self;
    [manager GET:@"http://myadmin.all-360.com:8080/Admin/AppApi/news" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        
        if ([responseObject[@"code"] intValue]==5100) {
            for (NSDictionary* dict in responseObject[@"data"]) {
                LDSeystemInfoModel* model = [[LDSeystemInfoModel alloc] initWithDictionary:dict];
                [weakSelf.sourceDataArray addObject:model];
            }
            
            [weakSelf.foldingTableView reloadData];
        }else{
            LDLog(@"没能搞到后台数据！%@",responseObject);
            [self setNilView];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"请求数据失败！%@",error.userInfo);
        [self setNilView];
        
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
    return 1;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
//    LDSeystemInfoModel *model = self.sourceDataArray[section];
//    CGSize size = [self sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(self.view.frame.size.width-20,100) string:model.name];
//    return size.height;
    return 44;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDSeystemInfoModel *model = self.sourceDataArray[indexPath.section];
    CGSize size = [self sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(200, 280) string:model.neirong];
    return size.height;
}

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string{
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}


- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    LDSeystemInfoModel *model = self.sourceDataArray[section];
    return [NSString stringWithFormat:@"%@",model.name];
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    LDSeystemInfoModel *sourceDataModel = self.sourceDataArray[indexPath.section];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",sourceDataModel.neirong];
    
    cell.detailTextLabel.lineBreakMode = NO;
    cell.detailTextLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NO;
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}




//#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）
//
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section
{
    LDSeystemInfoModel *sourceDataModel = self.sourceDataArray[section];
    return sourceDataModel.atime;
}

#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"系统通知";
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
#pragma mark ----- 功能未定 占给没有消息
- (void)setNilView {
    UILabel *label = [UILabel new];
    label.text = @"没有短信消息!!";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(180,30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
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
