//
//  tenYuanViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/28.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "tenYuanViewController.h"
#import "categoryTableViewCell.h"
#import "commodityDetailedViewController.h"
#import "pageGoodsModel.h"
@interface tenYuanViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tabelView */
@property (nonatomic , strong)UITableView *tabelView;
@property (nonatomic , strong)NSMutableArray *dataModelArray;
@end
//页数
static  int p = 1;
static NSString *reuseIdentifier = @"cell";
@implementation tenYuanViewController
-(NSMutableArray *)dataModelArray {
    if (!_dataModelArray) {
        _dataModelArray = [NSMutableArray array];
    }
    return _dataModelArray;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavigation];
    [self setTabelView];
    //添加上下刷新的控件
    [self setRefreshTheUpAndDown];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"十元专区";
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
#pragma mark ----- setTabelView
- (void)setTabelView {
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tabelView.delegate   = self;
    _tabelView.dataSource = self;
    _tabelView.backgroundColor = [UIColor whiteColor];
    [_tabelView registerNib:[UINib nibWithNibName:@"categoryTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_tabelView];
    
}
#pragma mark ----- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    categoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.boxBtn.tag = indexPath.row;
    [cell.boxBtn addTarget:self action:@selector(setJoinBoxBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.tenYuan.hidden = NO;
    pageGoodsModel *model = self.dataModelArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    commodityDetailedViewController *commodityVC = [[commodityDetailedViewController alloc]init];
    pageGoodsModel *model = self.dataModelArray[indexPath.row];
    NSNumber * nums = @([model.ID integerValue]);
    commodityVC.identifying = nums;
    [self.navigationController pushViewController:commodityVC animated:YES];
}
#pragma mark ------ 加入购物车动画
- (void)setJoinBoxBtn: (UIButton *)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    categoryTableViewCell *cell = (categoryTableViewCell *)[self.tabelView cellForRowAtIndexPath:indexPath];
    GoodsIDs = [NSMutableDictionary dictionary];
    /** 点击的商品ID 🐔 状态 */
    [GoodsIDs setValue:@"1" forKey:@"jionNum"];
    [GoodsIDs setValue:@"1" forKey:@"status"];
    [GoodsIDs setValue:cell.ID forKey:@"goodsID"];
    [ShopsIDs addObject:GoodsIDs];
    LDLog(@"%@",GoodsIDs);
    LDLog(@"%@",ShopsIDs);
    [self addProductsAnimation:cell.imageView dropToPoint:CGPointMake(self.view.bounds.size.width -50, self.view.layer.bounds.size.height - 40) isNeedNotification:YES];
    [ProgressHUD showSuccess:@"成功加入购物车"];
}
//添加上下刷新的控件
- (void)setRefreshTheUpAndDown {
    [self.tabelView addHeaderWithTarget:self action:@selector(HeaderRefresh)];
    [self.tabelView addFooterWithTarget:self action:@selector(FoorterRefresh)];
    //队里延迟显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //数据刷新中
        [self.tabelView headerSetState:CoreHeaderViewRefreshStateRefreshing];
    });
    
}

- (void)HeaderRefresh {
    p = 1;
    LDWeakSelf(self);
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/product/danjia/10/off/2/pagesize/%d/nowpage/%d",LoadingNumber, p];
    if (weakself.dataModelArray.count != 0) {
        [weakself.dataModelArray removeAllObjects];
    }
    if (weakself.dataModelArray.count == 0) {
        [weakself loadTenCellData:urlStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tabelView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
        });
    }else{
        [weakself.tabelView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tabelView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
    });
    [self.tabelView reloadData];
}
- (void)FoorterRefresh {
    p++;
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/product/danjia/10/off/2/pagesize/%d/nowpage/%d",LoadingNumber, p];
    [self loadTenCellData:urlStr];
}

- (void)loadTenCellData:(NSString *)urlStr {
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
                pageGoodsModel *goodsModel = [pageGoodsModel getLoadDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里//把数据放到新的可变数组里
                [newArray addObject:goodsModel];
            }
            //把新数组里的数据存放到存放第一次加载数据的数组里
            [arrayM addObjectsFromArray:newArray];
            //把合并后的数据源数组 赋值给你的数据源数组啊
            self.dataModelArray = arrayM;
            //结束上拉加载动作
            [weakself.tabelView footerSetState:CoreFooterViewRefreshStateSuccessedResultDataShowing];
            //弹出小窗口 显示加载成功
            [ProgressHUD showSuccess:@"加载成功"];
        }else{
            //移除所有数据
            [self.dataModelArray removeAllObjects];
            //里面是数组就用数组接受 现在是字典
            for (NSDictionary *tempDic in dataArray) {
                //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
                pageGoodsModel *goodsModel = [pageGoodsModel getLoadDataWithDic:tempDic];
                //有一个可变数组   (转变成模型)把数据放在可变数组里
                [self.dataModelArray addObject:goodsModel];
            }
            //结束下拉加载的动画
            [weakself.tabelView headerSetState:CoreHeaderViewRefreshStateSuccessedResultDataShowing];
            [ProgressHUD showSuccess:@"刷新成功"];
        }
        [self.tabelView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"加载出现错误"];
        [weakself.tabelView headerSetState:CoreHeaderViewRefreshStateRefreshingFailed];
        [weakself.tabelView footerSetState:CoreFooterViewRefreshStateFailed];
        LDLog(@"失败 = %@",error);
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
