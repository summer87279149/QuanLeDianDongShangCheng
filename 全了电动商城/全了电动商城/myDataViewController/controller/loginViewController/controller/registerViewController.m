//
//  registerViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/17.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "registerViewController.h"
#import "BXHttpManager.h"
#define REGISTER_HEIGHT (40*3)
@interface registerViewController ()
@property (nonatomic, strong) NSString *storeYZM;
@property (nonatomic , strong)UITextField *phoneNumber;
@property (nonatomic , strong)UITextField *SecurityCode;
@property (nonatomic , strong)UITextField *password;
//验证码
@property (nonatomic , strong)UIButton *verificationBtn;
/** 时间 */
@property (nonatomic, assign) NSInteger secondsCountDown;
@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(247, 247, 247);
    [self configNavigation];
    //给验证码时间60S
    self.secondsCountDown = 60;
    [self setRegisterView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark ----- 创建导航栏
- (void)configNavigation {
    self.title = @"注册账户";
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
#pragma mark ----- setRegisterView
- (void)setRegisterView {
    UIView *loginView = [[UIView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH , REGISTER_HEIGHT)];
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    
    _phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 40, 30)];
    _phoneNumber.borderStyle = UITextBorderStyleNone;
    _phoneNumber.placeholder = @"请输入手机号码";
    _phoneNumber.clearsOnBeginEditing = YES;
    _phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    [loginView addSubview:_phoneNumber];
    
    _SecurityCode = [[UITextField alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH - 40 - 120, 30)];
    _SecurityCode.borderStyle = UITextBorderStyleNone;
    _SecurityCode.placeholder = @"短信验证码:";
    _SecurityCode.clearsOnBeginEditing = YES;
    [loginView addSubview:_SecurityCode];
    
    _password = [[UITextField alloc]initWithFrame:CGRectMake(20, 90, SCREEN_WIDTH - 40, 30)];
    _password.borderStyle = UITextBorderStyleNone;
    _password.placeholder = @"密码:6-16位数字和字母";
    _password.secureTextEntry = YES;
    _password.clearsOnBeginEditing = YES;
    _password.keyboardType = UIKeyboardTypeDefault;
    [loginView addSubview:_password];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = kColor_RGB(234, 236, 236);
    [loginView addSubview:lineView];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 85, SCREEN_WIDTH, 1)];
    lineview.backgroundColor = kColor_RGB(234, 236, 236);
    [loginView addSubview:lineview];
    
    _verificationBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 50, 100, 30)];
    [_verificationBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_verificationBtn addTarget:self action:@selector(setVerificationLabelChange) forControlEvents:UIControlEventTouchUpInside];
    [_verificationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_verificationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _verificationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginView addSubview:_verificationBtn];
    /** 注册按钮 */
    UIButton *RegisterBtn = [UIButton new];
    [RegisterBtn setTitle:@"注  册" forState:UIControlStateNormal];
    [RegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegisterBtn.backgroundColor = kColor_RGB(210, 12, 22);
    RegisterBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    RegisterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:RegisterBtn];
    [RegisterBtn addTarget:self action:@selector(setRegisterViewController) forControlEvents:UIControlEventTouchUpInside];
    [RegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-60);
        make.left.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 200, 40));
    }];
}
//在这里改变文字
- (void)setVerificationLabelChange {
    if (![self valiMobile:self.phoneNumber.text]) {
        [ProgressHUD showError:@"手机号输入不正确"];
        return;
    }
    //给60秒
    [_verificationBtn setTitle:[NSString stringWithFormat:@"%lds",(long)self.secondsCountDown] forState:UIControlStateNormal];
    //给换个背景色 且 按钮为不可点击状态
    [_verificationBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
    [_verificationBtn setBackgroundImage:[UIImage imageNamed:@"加入宝箱"] forState:UIControlStateNormal];
    _verificationBtn.userInteractionEnabled = NO;
    /*
     TimerInterval : 执行之前等待的时间。比如设置成1.0，就代表1秒后执行方法 (每次执行的秒数)
     target : 需要执行方法的对象。
     selector : 需要执行的方法
     repeats : 是否需要循环 */
    //创建定时器
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setVerificationTimes:) userInfo:nil repeats:YES];
    
}
- (void)setVerificationTimes:(NSTimer *)countDownTimer{
    //定时器的方法
    //倒计时 开始计时
    _secondsCountDown--;
    [_verificationBtn setTitle:[NSString stringWithFormat:@"%lds",(long)self.secondsCountDown] forState:UIControlStateNormal];
    //当计时器数字到59秒的时候 -- 发送验证码
    if (_secondsCountDown == 59) {
        //发送验证码
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:1];
        parameter[@"mobil"] = _phoneNumber.text;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/sendSms/mobil/%@",_phoneNumber];
        //格式转换
        NSString *urlF = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager POST:urlF parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LDLog(@"%@",responseObject);
            self.storeYZM = responseObject[@"data"];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LDLog(@"err = %@",error);
        }];
    }
    
    //当计时结束后  需要做的事情
    if (_secondsCountDown == 0) {
        //结束定时器
        [countDownTimer invalidate];
        [_verificationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_verificationBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
        _secondsCountDown = 60;
        _verificationBtn.userInteractionEnabled = YES;
    }
}
- (void)setRegisterViewController {
    //点击注册  发送数据  显示注册成功 或者 失败
    //成功 跳转  失败 则停留在此页面
    if (self.phoneNumber.text.length == 0|| self.password.text.length == 0) {
        [ProgressHUD showError:@"用户名、密码、验证码\n不能为空"];
        return;
    }
    if (![self valiMobile:self.phoneNumber.text]) {
        [ProgressHUD showError:@"手机号输入不正确"];
        return;
    }
    [ProgressHUD show:@"正在注册"];
    //发送数据   /** 向后台发送json格式的数据传输值 */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型   申明请求的数据是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //把参数写到字典里
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"userName"] = _phoneNumber.text;
    parameters[@"pass"] = _password.text;
    parameters[@"verify"] = _SecurityCode.text;
    parameters[@"returnYzm"] = self.storeYZM;
    // 1.创建请求管理对象
    [manager POST:@"http://myadmin.all-360.com:8080/Admin/AppApi/reg" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSString *code = responseObject[@"code"];
        LDLog(@"%@",parameters);
        if ([code intValue] == 6110) {
            [ProgressHUD showSuccess:@"注册成功"];
            //把请求返回的数据 储存起来 (储存用户数据)?
            [LDUserInfo sharedLDUserInfo].userName = self.phoneNumber.text;
            [LDUserInfo sharedLDUserInfo].userPassword = self.password.text;
            LDLog(@"Result = %@" , responseObject[@"Result"]);
            [self.navigationController popViewControllerAnimated:YES];
        } else if ([code intValue] != 6110 ) {
            [ProgressHUD showError:@"注册失败"];
        } else if ([code intValue] == 6113 ) {
            [ProgressHUD showError:@"该用于已存在"];
        } else if ([code intValue] == 6115 ) {
            [ProgressHUD showError:@"验证码不正确"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"注册失败 = %@",error);
        [ProgressHUD showError:@"注册失败"];
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









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
