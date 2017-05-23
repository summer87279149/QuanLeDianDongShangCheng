//
//  loginViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//
#import "JPUSHService.h"
#import "loginViewController.h"
#import "registerViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
@interface loginViewController ()
/** 账号密码 */
@property (nonatomic, strong)UITextField *AccountField;
@property (nonatomic, strong)UITextField *passwordField;
/** 登录按钮 */
@property (nonatomic, strong)UIButton *loginBtn;
/** 注册账户 */
@property (nonatomic, strong)UIButton *registerAccountBtn;
/** 忘记密码 */
/** 微信 QQ */
@property (nonatomic , strong)UIButton *WeiChartBtn;
@property (nonatomic , strong)UIButton *QQBtn;

@property (nonatomic , strong)NSString *userID;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(247, 247, 247);
    [self configNavigation];
    //创建登录界面
    [self setLoginViewController];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark ----- 创建导航栏
- (void)configNavigation {
    self.title = @"登录";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 15);
    [backButton setBackgroundImage:[UIImage imageNamed:@"错"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(setDealBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    //导航添加背景颜色
    [self.navigationController.navigationBar setBarTintColor:kColor_RGB(217, 57, 84)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)setDealBack {
//
    if(self.type==1){
        [self.navigationController popViewControllerAnimated:YES];
    }else if(self.type==2){
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
        self.tabBarController.selectedIndex = 0;
    }
    
}
#pragma mark ----- setLoginViewController
- (void)setLoginViewController {
    /** 账号密码  */
    UIView *loginView = [UIView new];
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    
    UIImageView *accountImage = [UIImageView new];
    accountImage.image = [UIImage imageNamed:@"账号"];
    [loginView addSubview:accountImage];
    
    UIImageView *passwordImage = [UIImageView new];
    passwordImage.image = [UIImage imageNamed:@"密码"];
    [loginView addSubview:passwordImage];
    
    _AccountField = [UITextField new];
    _AccountField.font = [UIFont systemFontOfSize:13];
    _AccountField.borderStyle = UITextBorderStyleNone;
    _AccountField.backgroundColor = [UIColor whiteColor];
    _AccountField.placeholder = @"请输入账号:";
    _AccountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _AccountField.clearsOnBeginEditing = YES;
    _AccountField.keyboardType = UIKeyboardTypeNumberPad;
    _AccountField.returnKeyType = UIReturnKeyNext;
    [loginView addSubview:_AccountField];
    
    _passwordField = [UITextField new];
    _passwordField.font = [UIFont systemFontOfSize:13];
    _passwordField.borderStyle = UITextBorderStyleNone;
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.placeholder = @"请输入密码:";
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.clearsOnBeginEditing = YES;
    _passwordField.keyboardType = UIKeyboardTypeDefault;
    _passwordField.returnKeyType = UIReturnKeyNext;
    _passwordField.secureTextEntry = YES;
    [loginView addSubview:_passwordField];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kColor_RGB(214, 214, 214);
    [loginView addSubview:lineView];
    
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(loginView.mas_centerY);
        make.left.mas_equalTo(loginView.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    [accountImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [passwordImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-17);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [_AccountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(accountImage.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 50, 30));
    }];
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(passwordImage.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 50, 30));
    }];
    
    /** 登录按钮  注册按钮 */
    _loginBtn = [UIButton new];
    [_loginBtn setTitle:@"登   录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_loginBtn addTarget:self action:@selector(letBuyBuyBuy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _registerAccountBtn = [UIButton new];
    [_registerAccountBtn setTitle:@"注册用户" forState:UIControlStateNormal];
    _registerAccountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_registerAccountBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
//    [_registerAccountBtn setBackgroundImage:[UIImage imageNamed:@"加入宝箱"] forState:UIControlStateNormal];
    [_registerAccountBtn addTarget:self action:@selector(gotoRegisterViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerAccountBtn];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginView.mas_bottom).offset(20);
        make.left.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
    }];
    
    [_registerAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginBtn.mas_bottom).offset(10);
        make.right.mas_equalTo(_loginBtn);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    /** 中下部视图 两个三方登录 */
    _WeiChartBtn = [UIButton new];
    [_WeiChartBtn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [_WeiChartBtn addTarget:self action:@selector(setWeiChartBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_WeiChartBtn];
    
    _QQBtn = [UIButton new];
    [_QQBtn setBackgroundImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    [_QQBtn addTarget:self action:@selector(setQQBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_QQBtn];
    
    UILabel *WeiChartLabel = [UILabel new];
    WeiChartLabel.text = @"微信";
    WeiChartLabel.textAlignment = NSTextAlignmentCenter;
    WeiChartLabel.textColor = [UIColor grayColor];
    WeiChartLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:WeiChartLabel];
    
    UILabel *QQLabel = [UILabel new];
    QQLabel.text = @"QQ";
    QQLabel.textAlignment = NSTextAlignmentCenter;
    QQLabel.textColor = [UIColor grayColor];
    QQLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:QQLabel];
    
    UILabel *explainLabel = [UILabel new];
    explainLabel.text = @"或者使用以下三方登录";
    explainLabel.textAlignment = NSTextAlignmentCenter;
    explainLabel.textColor = [UIColor grayColor];
    explainLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:explainLabel];
    
    UIView *explainLine = [UIView new];
    explainLine.backgroundColor = kColor_RGB(214, 214, 214);
    [self.view addSubview:explainLine];
    
    UIView *explainLineView = [UIView new];
    explainLineView.backgroundColor = kColor_RGB(214, 214, 214);
    [self.view addSubview:explainLineView];
    
    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-150);
        make.left.mas_equalTo((SCREEN_WIDTH - 130)/2);
        make.size.mas_equalTo(CGSizeMake(130, 30));
    }];
    [explainLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-163);
        make.right.mas_equalTo(explainLabel.mas_left).offset(-5);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    [explainLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-163);
        make.left.mas_equalTo(explainLabel.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(1);
    }];
    
    [_WeiChartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(explainLabel.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.mas_equalTo((SCREEN_WIDTH - 120)/3);
    }];
    [_QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(explainLabel.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.right.mas_equalTo(-(SCREEN_WIDTH - 120)/3);
    }];
    [WeiChartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_WeiChartBtn.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.centerX.mas_equalTo(_WeiChartBtn.mas_centerX);
    }];
    [QQLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_QQBtn.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.centerX.mas_equalTo(_QQBtn.mas_centerX);
    }];
    
}

#pragma mark ----- 按钮事件
//登录按钮
- (void)letBuyBuyBuy {
    //点击登录按钮
    if (![self valiMobile:self.AccountField.text]) {
        [ProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    [ProgressHUD showSuccess:@"正在登录"];
    //把参数写到字典里
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    parameters[@"userName"] = self.AccountField.text;
    parameters[@"pass"] = self.passwordField.text;
    [self loginWithPost:@"http://myadmin.all-360.com:8080/Admin/AppApi/login" withParameters:parameters WithLoginType:@"Phone"];
}
//注册
- (void)gotoRegisterViewController {
    [self.navigationController pushViewController:[registerViewController new] animated:YES];
}
//微信
- (void)setWeiChartBtn {
//    SendAuthReq* req =  [[SendAuthReq alloc]init]; //[[[SendAuthReq alloc ] init ] autorelease ];
//    req.scope = @"snsapi_userinfo" ;
//    req.state = @"123";
//    //第三方向微信终端发送一个SendAuthReq消息结构
//    [WXApi sendReq:req];
//    NSLog(@"%@",req);
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"error == %@",error);
        }else {
            UMSocialUserInfoResponse *resp = result;
            //        发送数据   /** 向后台发送json格式的数据传输值 */
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //申明返回的结果是json类型   申明请求的数据是json类型
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            //申明请求的数据是json类型
            manager.requestSerializer=[AFJSONRequestSerializer serializer];
            //如果报接受类型不一致请替换一致text/html或别的
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            NSMutableDictionary *WXParameters = [NSMutableDictionary dictionaryWithCapacity:3];
            WXParameters[@"openid"]     = resp.openid;
            WXParameters[@"name"]       = resp.name;
            WXParameters[@"iconurl"] = resp.iconurl;
            [manager POST:@"http://myadmin.all-360.com:8080/Admin/AppApi/extendLogin" parameters:WXParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                LDLog(@"%@",responseObject);
                NSString *code = responseObject[@"code"];
                LDLog(@"%@",WXParameters);
                if ([code intValue] == 6200) {
                    [ProgressHUD showSuccess:@"登录成功"];
                    //把请求返回的数据 储存起来 (储存用户数据)?
                    [LDUserInfo sharedLDUserInfo].ID = responseObject[@"data"][@"userId"];
                    
                    [JPUSHService setTags:nil alias:[LDUserInfo sharedLDUserInfo].ID fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                        
                    }];
                    [LDUserInfo sharedLDUserInfo].isLogin = YES;
                    [[LDUserInfo sharedLDUserInfo] saveUsrtInfo];
                    /** 后台返回用户的ID 和名字  */
                   // NSString *userID = responseObject[@"data"][@"userId"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else if ([code intValue] != 6200 ) {
                    [ProgressHUD showError:@"登录失败"];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [ProgressHUD showError:@"登录失败"];
            }];
        }
       
    }];
}
//QQ
- (void)setQQBtn {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //申明返回的结果是json类型   申明请求的数据是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSMutableDictionary *WXParameters = [NSMutableDictionary dictionaryWithCapacity:3];
        WXParameters[@"openid"]     = resp.openid;
        WXParameters[@"name"]       = resp.name;
        WXParameters[@"iconurl"] = resp.iconurl;
        [manager POST:@"http://myadmin.all-360.com:8080/Admin/AppApi/extendLogin" parameters:WXParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LDLog(@"%@",responseObject);
            NSString *code = responseObject[@"code"];
            LDLog(@"%@",WXParameters);
            if ([code intValue] == 6200) {
                [ProgressHUD showSuccess:@"登录成功"];
                //把请求返回的数据 储存起来 (储存用户数据)?
                [LDUserInfo sharedLDUserInfo].ID = responseObject[@"data"][@"userId"];
                [LDUserInfo sharedLDUserInfo].isLogin = YES;
                [LDUserInfo sharedLDUserInfo].oldIsLogin = YES;
                [[LDUserInfo sharedLDUserInfo] saveUsrtInfo];
                [JPUSHService setTags:nil alias:[LDUserInfo sharedLDUserInfo].ID fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    
                }];
                [self.navigationController popViewControllerAnimated:YES];
            } else if ([code intValue] != 6200 ) {
                [ProgressHUD showError:@"登录失败"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [ProgressHUD showError:@"登录失败"];
        }];
    }];
}


#pragma mark --  判断手机号码格式是否正确
- (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

#pragma  mark -- 登录
- (void)loginWithPost:(NSString *)URLString withParameters:(NSDictionary *)parametes WithLoginType:(NSString *)type{
    //发送数据   /** 向后台发送json格式的数据传输值 */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型   申明请求的数据是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URLString parameters:parametes progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSString *code = responseObject[@"code"];
        if ([code intValue] == 6000) {
            [ProgressHUD showSuccess:@"登录成功"];
            //把请求返回的数据 储存起来 (储存用户数据)?
            [LDUserInfo sharedLDUserInfo].userName = self.AccountField.text;
            [LDUserInfo sharedLDUserInfo].userPassword = self.passwordField.text;
            [LDUserInfo sharedLDUserInfo].ID = responseObject[@"data"][@"userId"];
            _userID = responseObject[@"data"][@"userId"];
            [LDUserInfo sharedLDUserInfo].isLogin = YES;
            [[LDUserInfo sharedLDUserInfo] saveUsrtInfo];
            [self setUserDefauts];
            [JPUSHService setTags:nil alias:[LDUserInfo sharedLDUserInfo].ID fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                
            }];
            [self.navigationController popViewControllerAnimated:YES];
        } else if ([code intValue] == 6004 ) {
            [ProgressHUD showError:@"账号或密码错误"];
        } else if ([code intValue] == 6003 ) {
            [ProgressHUD showError:@"用户名或密码不能为空"];
        } else if ([code intValue] == 6002 ) {
            [ProgressHUD showError:@"该账户状态关闭"];
        }else {
            [ProgressHUD showError:@"登录失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ProgressHUD showError:@"登录失败"];
    }];
}
- (void)setUserDefauts {
    NSString *userName = self.AccountField.text;
    NSString *userPassword = self.passwordField.text;
    NSString *isLogin = @"1";
    NSString *UID = _userID;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:isLogin forKey:@"isLogin"];
    [user setObject:userName forKey:@"userName"];
    [user setObject:userPassword forKey:@"userPassword"];
    [user setObject:UID forKey:@"userID"];
    
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
