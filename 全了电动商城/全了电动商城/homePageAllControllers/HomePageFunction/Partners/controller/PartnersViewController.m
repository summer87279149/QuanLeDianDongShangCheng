//
//  PartnersViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "PartnersViewController.h"
#import "loginViewController.h"

@interface PartnersViewController ()
@property (nonatomic , strong)NSString *userID;


@property (nonatomic , strong)UITextField *nameField;
@property (nonatomic , strong)UITextField *DianMianAdressField;
@property (nonatomic , strong)UITextField *phomeNumField;
@end

@implementation PartnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setAftersalesCommercial];
    [self configNavigation];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 创建导航栏
- (void)configNavigation {
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
#pragma mark  ----- 主体
- (void)setAftersalesCommercial {
    UIImageView *LogoImage = [UIImageView new];
    LogoImage.image = [UIImage imageNamed:@"全了"];
    [self.view addSubview:LogoImage];
    
    [LogoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    
    UILabel *DianMianLabel = [UILabel new];
    DianMianLabel.text = @"店面名称:";
    DianMianLabel.textColor = [UIColor grayColor];
    DianMianLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:DianMianLabel];
    
    UILabel *DianMianAdressLabel = [UILabel new];
    DianMianAdressLabel.text = @"店面地址:";
    DianMianAdressLabel.textColor = [UIColor grayColor];
    DianMianAdressLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:DianMianAdressLabel];
    
    UILabel *FaRenNameLabel = [UILabel new];
    FaRenNameLabel.text = @"法人姓名:";
    FaRenNameLabel.textColor = [UIColor grayColor];
    FaRenNameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:FaRenNameLabel];
    
    
    [DianMianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LogoImage.mas_bottom).offset(50);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [DianMianAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(DianMianLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [FaRenNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(DianMianAdressLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _nameField = [UITextField new];
    _nameField.placeholder = @"请输入姓名";
    _nameField.borderStyle = UITextBorderStyleNone;
    _nameField.font = [UIFont systemFontOfSize:13];
    _nameField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_nameField];
    
    _DianMianAdressField = [UITextField new];
    _DianMianAdressField.placeholder = @"请输入店面地址";
    _DianMianAdressField.borderStyle = UITextBorderStyleNone;
    _DianMianAdressField.font = [UIFont systemFontOfSize:13];
    _DianMianAdressField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_DianMianAdressField];
    
    _phomeNumField = [UITextField new];
    _phomeNumField.placeholder = @"请输入联系方式";
    _phomeNumField.borderStyle = UITextBorderStyleNone;
    _phomeNumField.font = [UIFont systemFontOfSize:13];
    _phomeNumField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_phomeNumField];
    
    
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LogoImage.mas_bottom).offset(50);
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_DianMianAdressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameField.mas_bottom).offset(15);
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_phomeNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_DianMianAdressField.mas_bottom).offset(15);
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *TiJiaoBtn = [UIButton new];
    [TiJiaoBtn setTitle:@"提交注册" forState:UIControlStateNormal];
    [TiJiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [TiJiaoBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    TiJiaoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [TiJiaoBtn addTarget:self action:@selector(setTiJiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TiJiaoBtn];
    
    [TiJiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    
}

//提交订单
- (void)setTiJiaoBtn {
    if (_nameField.text.length != 0 || _DianMianAdressField.text.length != 0 || _phomeNumField.text.length != 0 ) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *isLogin = [user objectForKey:@"isLogin"];
        if ([isLogin intValue] == 0) {
            if ([LDUserInfo sharedLDUserInfo].isLogin == YES) {
                //读取本地数据 获取用户ID
                [[LDUserInfo sharedLDUserInfo] readUserInfo];
                self.userID = [LDUserInfo sharedLDUserInfo].ID ;
                
                NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:12];
                parameters[@"name"] = @"";
                parameters[@"tel"] = _phomeNumField.text;
                parameters[@"address"] = _DianMianAdressField.text;
                parameters[@"linkman"] = _nameField.text;
                parameters[@"type"] = @"2";
                parameters[@"uid"] = self.userID;
                parameters[@"legal_name"] = @"";
                parameters[@"legal_tel"] = @"";
                parameters[@"legal_id"] = @"";
                parameters[@"business_license"] = @"";
                parameters[@"legal_img"] = @"";
                parameters[@"shop_img"] = @"";
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                
                // 1.创建请求管理对象
                [manager POST:@"http://myadmin.all-360.com:8080/Admin/AppApi/agent" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    LDLog(@"%@",responseObject);
                    NSString *code = responseObject[@"code"];
                    if ([code intValue] == 68111) {
                        [ProgressHUD showSuccess:@"注册成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else if ([code intValue] != 68111 ) {
                        [ProgressHUD showError:@"注册失败"];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    LDLog(@"注册失败 = %@",error);
                    [ProgressHUD showError:@"注册失败"];
                }];

            } else {
                //如果没登录就跳转
                [self.navigationController pushViewController:[loginViewController new] animated:YES];
            }
        }else if ([isLogin intValue] != 0) {
            self.userID = [user objectForKey:@"userID"];
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:12];
            parameters[@"name"] = @"";
            parameters[@"tel"] = _phomeNumField.text;
            parameters[@"address"] = _DianMianAdressField.text;
            parameters[@"linkman"] = _nameField.text;
            parameters[@"type"] = @"2";
            parameters[@"uid"] = self.userID;
            parameters[@"legal_name"] = @"";
            parameters[@"legal_tel"] = @"";
            parameters[@"legal_id"] = @"";
            parameters[@"business_license"] = @"";
            parameters[@"legal_img"] = @"";
            parameters[@"shop_img"] = @"";
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            // 1.创建请求管理对象
            [manager POST:@"http://myadmin.all-360.com:8080/Admin/AppApi/agent" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                LDLog(@"%@",responseObject);
                NSString *code = responseObject[@"code"];
                if ([code intValue] == 68111) {
                    [ProgressHUD showSuccess:@"注册成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else if ([code intValue] != 68111 ) {
                    [ProgressHUD showError:@"注册失败"];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                LDLog(@"注册失败 = %@",error);
                [ProgressHUD showError:@"注册失败"];
            }];

        }
    }else {
        [ProgressHUD showError:@"请填写完整信息"];
    }
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
