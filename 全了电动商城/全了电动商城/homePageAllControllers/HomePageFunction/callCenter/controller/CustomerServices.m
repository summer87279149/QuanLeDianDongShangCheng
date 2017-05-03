//
//  CustomerServices.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "CustomerServices.h"
#import <WebKit/WebKit.h>
@interface CustomerServices ()<WKNavigationDelegate>

@end

@implementation CustomerServices

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavigation];
    [self setView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    self.title = @"客服中心";
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
- (void)setView {
    UIImageView *LogoImage = [UIImageView new];
    LogoImage.image = [UIImage imageNamed:@"全了"];
    [self.view addSubview:LogoImage];
    
    [LogoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    UILabel *DianMianLabel = [UILabel new];
    DianMianLabel.text = @"客服网址:  www.yzldwl.com";
    DianMianLabel.textColor = [UIColor grayColor];
    DianMianLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:DianMianLabel];
    
    UILabel *DianMianAdressLabel = [UILabel new];
    DianMianAdressLabel.text = @"客服邮箱:  123456@qq.com";
    DianMianAdressLabel.textColor = [UIColor grayColor];
    DianMianAdressLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:DianMianAdressLabel];
    
    UILabel *FaRenNameLabel = [UILabel new];
    FaRenNameLabel.text = @"客服电话:  0514 - 85166037";
    FaRenNameLabel.textColor = [UIColor grayColor];
    FaRenNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:FaRenNameLabel];
    
    UILabel *FaRenPhoneLabel = [UILabel new];
    FaRenPhoneLabel.text = @"客服QQ:  1234556";
    FaRenPhoneLabel.textColor = [UIColor grayColor];
    FaRenPhoneLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:FaRenPhoneLabel];
    
    UILabel *FaRenIDCardLabel = [UILabel new];
    FaRenIDCardLabel.text = @"客服微信:  qlddsc123456";
    FaRenIDCardLabel.textColor = [UIColor grayColor];
    FaRenIDCardLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:FaRenIDCardLabel];
//    
//    UILabel *YINYELabel = [UILabel new];
//    YINYELabel.text = @"营业执照:";
//    YINYELabel.textColor = [UIColor grayColor];
//    YINYELabel.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:YINYELabel];
//    
//    UILabel *DianMianImageLabel = [UILabel new];
//    DianMianImageLabel.text = @"店面照片:";
//    DianMianImageLabel.textColor = [UIColor grayColor];
//    DianMianImageLabel.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:DianMianImageLabel];
    [DianMianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LogoImage.mas_bottom).offset(50);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [DianMianAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(DianMianLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [FaRenNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(DianMianAdressLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [FaRenPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FaRenNameLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [FaRenIDCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FaRenPhoneLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
//    [YINYELabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(FaRenIDCardLabel.mas_bottom).offset(15);
//        make.left.mas_equalTo(20);
//        make.height.mas_equalTo(20);
//    }];
//    [DianMianImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(YINYELabel.mas_bottom).offset(15);
//        make.left.mas_equalTo(20);
//        make.height.mas_equalTo(20);
//    }];
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
