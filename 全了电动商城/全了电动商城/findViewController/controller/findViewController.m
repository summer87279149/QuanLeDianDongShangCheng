//
//  findViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "findViewController.h"
#import "TableViewCell.h"
#import "fineTableViewCell.h"
#import "WinningViewController.h"
#import "UsViewController.h"
#import "freshmanHelpViewController.h"

@interface findViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tabelView */
@property (nonatomic , strong)UITableView *tabelView;
@property (nonatomic , strong)NSArray *imagesArray;
@property (nonatomic , strong)NSArray *labelsArray;
@end

static NSString *reuseIdentifier = @"cell";
@implementation findViewController
-(NSArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSArray array];
        _imagesArray = @[@"家用家电",@"金银宝饰",@"幸运"];
    }
    return _imagesArray;
}
-(NSArray *)labelsArray {
    if (!_labelsArray) {
        _labelsArray = [NSArray array];
        _labelsArray = @[@"晒单分享",@"常见问题",@"关于我们"];
    }
    return _labelsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(241, 238, 238);
    [self setTabelViewController];
    [self configNavigation];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"中奖晒单";
    //导航添加背景颜色
    [self.navigationController.navigationBar setBarTintColor:kColor_RGB(217, 57, 84)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark ------ setTabelViewController
- (void)setTabelViewController {
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    _tabelView.backgroundColor = [UIColor whiteColor];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.showsVerticalScrollIndicator = NO;
    [_tabelView registerNib:[UINib nibWithNibName:@"fineTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_tabelView];
}
#pragma mark ------ UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imagesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    fineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.shopImage.image = [UIImage imageNamed:self.imagesArray[indexPath.row]];
    cell.shopLabel.text = self.labelsArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[WinningViewController new]  animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[freshmanHelpViewController new]   animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[UsViewController new]   animated:YES];
            break;
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
