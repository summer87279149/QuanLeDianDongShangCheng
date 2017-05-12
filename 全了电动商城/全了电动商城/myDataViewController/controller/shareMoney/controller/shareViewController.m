//
//  shareViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/22.
//  Copyright © 2017年 亮点网络. All rights reserved.
//
#import "GetMoneyRecordViewController.h"
#import "YongjinViewController.h"
#import "InviteRecordViewController.h"
#import "shareViewController.h"
#import "shareTopView.h"
#import "inviteExplain.h"
#import "ExtractCash.h"
#import "depositAccount.h"

@interface shareViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong)UITableView *shareVC;
@property (nonatomic , strong)shareTopView *topV;

@end

@implementation shareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
    [self configNavigation];
    [self setTopView];
    [self setBottomView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"分享赚钱";
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
- (void)setTableView {
    self.shareVC.backgroundColor = [UIColor whiteColor];
    self.shareVC = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60) style:UITableViewStyleGrouped];
    self.shareVC.showsVerticalScrollIndicator = NO;
    self.shareVC.showsHorizontalScrollIndicator = NO;
    _shareVC.delegate = self;
    _shareVC.dataSource = self;
    [self.view addSubview:_shareVC];

}
- (void)setTopView {
    _topV = [[NSBundle mainBundle] loadNibNamed:
             @"shareTopView" owner:nil options:nil ].lastObject;
    _topV.imgURL = self.qrImgStr;
    _topV.frame = CGRectMake(0, 0, SCREEN_WIDTH, 406);
}
- (void)setBottomView {
    UIView *bottomView = [[UIView alloc]init];
   // bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    
    UIButton *ExtractCash = [[UIButton alloc]init];
    [ExtractCash setTitle:@"佣金提现" forState:UIControlStateNormal];
    [ExtractCash setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [ExtractCash setBackgroundImage:[UIImage imageNamed:@"橘色背景"] forState:UIControlStateNormal];
    [ExtractCash addTarget:self action:@selector(setExtractCashBtn) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:ExtractCash];
    
    UIButton *Recharge = [[UIButton alloc]init];
    [Recharge setTitle:@"存入账号" forState:UIControlStateNormal];
    [Recharge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Recharge setBackgroundImage:[UIImage imageNamed:@"橘色"] forState:UIControlStateNormal];
    [Recharge addTarget:self action:@selector(setRechargeBtn) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView addSubview:Recharge];
    
    [ExtractCash mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/2, 40));
        make.centerX.mas_equalTo(self.view);
    }];
    
//    [Recharge mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(ExtractCash.mas_right).offset(10);
//        make.top.mas_equalTo(10);
//        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30)/2, 40));
//    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _topV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 406;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"邀请记录";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"佣金明细";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"提现记录";
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"邀请说明";
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            InviteRecordViewController *vc = [[InviteRecordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 1:{
            YongjinViewController *vc = [[YongjinViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            
            GetMoneyRecordViewController *vc = [[GetMoneyRecordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
            [self.navigationController pushViewController:[inviteExplain new] animated:YES];
            break;
            
        default:
            break;
    }
}
#pragma mark ---- 2个点击事件
- (void)setExtractCashBtn {
    [self.navigationController pushViewController:[ExtractCash new] animated:YES];
}
- (void)setRechargeBtn {
    [self.navigationController pushViewController:[depositAccount new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
