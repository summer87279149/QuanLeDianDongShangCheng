//
//  UsViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/2.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "UsViewController.h"

@interface UsViewController ()

@end

@implementation UsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigation];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMainContent];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"关于我们";
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


- (void)setMainContent {
    UITextView *LabelView = [[UITextView alloc]initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH - 60, 200)];
    LabelView.text = @"关于我们: 全了电动商城众筹平台以 : 众筹 模式为各类商品的销售提供的网络空间。在本平台，商品被平分成若干等份，支持者可以使用夺宝币支持一份或多份，当等份全部售完后，由系统根据平台规则计算出最终获得商品的支持者，其他支持者则可获得相应的“宝石”。";
    LabelView.font = [UIFont systemFontOfSize:16];
    LabelView.textColor = [UIColor grayColor];
    [self.view addSubview:LabelView];
    
    UILabel *label = [UILabel new];
    label.text = @"扬州亮点网络技术有限公司";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.left.mas_equalTo((SCREEN_WIDTH - 300)/2);
        make.bottom.mas_equalTo(-80);
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
