//
//  RechargeViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/13.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "RechargeViewController.h"
#import "loginViewController.h"
#import <WebKit/WebKit.h>
@interface RechargeViewController ()<WKNavigationDelegate>
/** 6种金额按钮 */
@property (nonatomic , strong)UIButton *twentyBtn;
@property (nonatomic , strong)UIButton *fiftyBtn;
@property (nonatomic , strong)UIButton *oneHundredBtn;
@property (nonatomic , strong)UIButton *twoHundredBtn;
@property (nonatomic , strong)UIButton *fiveHundredBtn;
@property (nonatomic , strong)UIButton *aThousandBtn;
/** 确认充值 */
@property (nonatomic , strong)UIButton *affirmPayBtn;

/** 调起支付的6个参数 */
/** 应用ID */
@property (nonatomic, strong)NSString *appid;
/** 商户号 */
@property (nonatomic, strong)NSString *partnerid;
/** 预支付交易会话ID */
@property (nonatomic, strong)NSString *prepayid;
/** 扩展字段 */
@property (nonatomic, strong)NSString *package;
/** 随机字符串 */
@property (nonatomic, strong)NSString *noncestr;
/** 时间戳 */
@property (nonatomic, strong)NSString *timestamp;
/** 签名 */
@property (nonatomic, strong)NSString *sign;

/** 微信支付的状态 */
@property (nonatomic , strong)NSString *WeiXinStatus;
@end
int payMoney = 20;
@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setViewController];
    [self configNavigation];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO];
    [self setWeiXinPayStatus];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"充值";
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

#pragma mark ----- 创建主视图
- (void)setViewController {
    /** 支付方式 */
    UIView *headView = [UIView new];
    headView.backgroundColor = kColor_RGB(247, 247, 247);
    [self.view addSubview:headView];
    
    UILabel *headLabel = [UILabel new];
    headLabel.text = @"选择支付方式";
    headLabel.textColor = [UIColor grayColor];
    headLabel.font = [UIFont systemFontOfSize:12];
    [headView addSubview:headLabel];
    
    UILabel *payLabel = [UILabel new];
    payLabel.text = @"微信支付";
    payLabel.textColor = [UIColor grayColor];
    payLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:payLabel];
    
    UIButton *payBtn = [UIButton new];
    [payBtn setBackgroundImage:[UIImage imageNamed:@"勾号"] forState:UIControlStateNormal];
    [self.view addSubview:payBtn];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).offset(10);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    /** 支付金额的标题 */
    UIView *payView = [UIView new];
    payView.backgroundColor = kColor_RGB(247, 247, 247);
    [self.view addSubview:payView];
    
    UILabel *payTitleLabel = [UILabel new];
    payTitleLabel.text = @"选择支付方式";
    payTitleLabel.textColor = [UIColor grayColor];
    payTitleLabel.font = [UIFont systemFontOfSize:12];
    [payView addSubview:payTitleLabel];
    
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    [payTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    /** 支付金额的详情 */
    _twentyBtn = [UIButton new];
    [_twentyBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [_twentyBtn setTitle:@"20" forState:UIControlStateNormal];
    _twentyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_twentyBtn addTarget:self action:@selector(setTwentyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_twentyBtn];
    
    _fiftyBtn = [UIButton new];
    [_fiftyBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [_fiftyBtn setTitle:@"50" forState:UIControlStateNormal];
    _fiftyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_fiftyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiftyBtn addTarget:self action:@selector(setFiftyBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fiftyBtn];
    
    _oneHundredBtn = [UIButton new];
    [_oneHundredBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [_oneHundredBtn setTitle:@"100" forState:UIControlStateNormal];
    _oneHundredBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_oneHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_oneHundredBtn addTarget:self action:@selector(setOneHundredBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_oneHundredBtn];
    
    _twoHundredBtn = [UIButton new];
    [_twoHundredBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [_twoHundredBtn setTitle:@"200" forState:UIControlStateNormal];
    _twoHundredBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_twoHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_twoHundredBtn addTarget:self action:@selector(setTwoHundredBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_twoHundredBtn];
    
    _fiveHundredBtn = [UIButton new];
    [_fiveHundredBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [_fiveHundredBtn setTitle:@"500" forState:UIControlStateNormal];
    _fiveHundredBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_fiveHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiveHundredBtn addTarget:self action:@selector(setFiveHundredBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fiveHundredBtn];
    
    _aThousandBtn = [UIButton new];
    [_aThousandBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [_aThousandBtn setTitle:@"1000" forState:UIControlStateNormal];
    _aThousandBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_aThousandBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_aThousandBtn addTarget:self action:@selector(setAThousandBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_aThousandBtn];
    
    [@[_twentyBtn,_fiftyBtn,_oneHundredBtn,_twoHundredBtn,_fiveHundredBtn,_aThousandBtn]mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [_twentyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payView.mas_bottom).offset(20);
        make.left.mas_equalTo((SCREEN_WIDTH - 100*3)/4);
    }];
    [_fiftyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payView.mas_bottom).offset(20);
        make.left.mas_equalTo(_twentyBtn.mas_right).offset((SCREEN_WIDTH - 100*3)/4);
    }];
    [_oneHundredBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payView.mas_bottom).offset(20);
        make.left.mas_equalTo(_fiftyBtn.mas_right).offset((SCREEN_WIDTH - 100*3)/4);
    }];
    [_twoHundredBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fiftyBtn.mas_bottom).offset(20);
        make.left.mas_equalTo((SCREEN_WIDTH - 100*3)/4);
    }];
    [_fiveHundredBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fiftyBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(_twoHundredBtn.mas_right).offset((SCREEN_WIDTH - 100*3)/4);
    }];
    [_aThousandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fiftyBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(_fiveHundredBtn.mas_right).offset((SCREEN_WIDTH - 100*3)/4);
    }];
    
    /** 确认充值 */
    _affirmPayBtn = [UIButton new];
    [_affirmPayBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_affirmPayBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    _affirmPayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_affirmPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_affirmPayBtn addTarget:self action:@selector(setAffirmPayBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_affirmPayBtn];
    
    [_affirmPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-60);
        make.left.mas_equalTo((SCREEN_WIDTH - 200)/2);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
}
#pragma mark ------ ALLPayBtn Methods
- (void)setTwentyBtn {
    payMoney = 20;
    [_twentyBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
    [_fiftyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_oneHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_twoHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiveHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_aThousandBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
- (void)setFiftyBtn {
    payMoney = 50;
    [_twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiftyBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
    [_oneHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_twoHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiveHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_aThousandBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
- (void)setOneHundredBtn {
    payMoney = 100;
    [_twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiftyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_oneHundredBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
    [_twoHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiveHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_aThousandBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
- (void)setTwoHundredBtn {
    payMoney = 200;
    [_twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiftyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_oneHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_twoHundredBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
    [_fiveHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_aThousandBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
- (void)setFiveHundredBtn {
    payMoney = 500;
    [_twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiftyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_oneHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_twoHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiveHundredBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
    [_aThousandBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
- (void)setAThousandBtn {
    payMoney = 1000;
    [_twentyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiftyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_oneHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_twoHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_fiveHundredBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_aThousandBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
}
#pragma mark ----- 支付按钮
- (void)setAffirmPayBtn {
    
    if ([_WeiXinStatus intValue] == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *ZFBAction = [UIAlertAction actionWithTitle:@"支付宝支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlStr = [NSString stringWithFormat:@"http://www.all-360.com/alipay/wappay/recharge.php?amount=%d&uid=%@",payMoney,self.userUID];
            NSURL *url = [ [ NSURL alloc ] initWithString:urlStr ];
            [[UIApplication sharedApplication] openURL:url];
        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:ZFBAction];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if ([_WeiXinStatus intValue] != 0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *ZFBAction = [UIAlertAction actionWithTitle:@"支付宝支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlStr = [NSString stringWithFormat:@"http://www.all-360.com/alipay/wappay/recharge.php?amount=%d&uid=%@",payMoney,self.userUID];
            NSURL *url = [ [ NSURL alloc ] initWithString:urlStr ];
            [[UIApplication sharedApplication] openURL:url];
            
        }];
        UIAlertAction *WeiChartAction = [UIAlertAction actionWithTitle:@"支付宝支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //取本地信息
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *isLogin = [user objectForKey:@"isLogin"];
            if ([isLogin intValue] == 0) {
                if ([LDUserInfo sharedLDUserInfo].isLogin == YES) {
                    //读取本地数据 获取用户ID
                    [[LDUserInfo sharedLDUserInfo] readUserInfo];
                    self.userUID = [LDUserInfo sharedLDUserInfo].ID ;
                    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
                    session.responseSerializer = [AFJSONResponseSerializer serializer];
                    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/recharge/uid/%@/total/%d",self.userUID,payMoney];
                    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        LDLog(@"%@",responseObject);
                        PayReq *request = [[PayReq alloc] init];
                        request.partnerId = responseObject[@"data"][@"partnerid"];
                        request.prepayId = responseObject[@"data"][@"prepayid"];
                        request.package = responseObject[@"data"][@"package"];
                        request.nonceStr = responseObject[@"data"][@"noncestr"];
                        request.timeStamp = [responseObject[@"data"][@"timestamp"]intValue];
                        request.sign = responseObject[@"data"][@"sign"];
                        [WXApi sendReq: request];
                        LDLog(@"%@=%@=%@=%@=%u=%@",request.partnerId,request.prepayId,request.package,request.nonceStr,(unsigned int)request.timeStamp,request.sign);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        LDLog(@"error = %@",error);
                    }];
                } else {
                    //如果没登录就跳转
                    [self.navigationController pushViewController:[loginViewController new] animated:YES];
                }
            }else if ([isLogin intValue] != 0) {
                self.userUID = [user objectForKey:@"userID"];
                AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
                session.responseSerializer = [AFJSONResponseSerializer serializer];
                session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/recharge/uid/%@/total/%d",self.userUID,payMoney];
                [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    LDLog(@"%@",responseObject);
                    PayReq *request = [[PayReq alloc] init];
                    request.partnerId = responseObject[@"data"][@"partnerid"];
                    request.prepayId = responseObject[@"data"][@"prepayid"];
                    request.package = responseObject[@"data"][@"package"];
                    request.nonceStr = responseObject[@"data"][@"noncestr"];
                    request.timeStamp = [responseObject[@"data"][@"timestamp"]intValue];
                    request.sign = responseObject[@"data"][@"sign"];
                    [WXApi sendReq: request];
                    LDLog(@"%@=%@=%@=%@=%u=%@",request.partnerId,request.prepayId,request.package,request.nonceStr,(unsigned int)request.timeStamp,request.sign);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    LDLog(@"error = %@",error);
                }];
            }

        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:ZFBAction];
        [alertController addAction:WeiChartAction];
        [alertController addAction:cancleAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

//WKNavigationDelegate
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"加载成功");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"失败%@" , error);
}



- (void)setWeiXinPayStatus {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [session GET:@"http://myadmin.all-360.com:8080/Admin/AppApi/wxCode" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _WeiXinStatus = responseObject[@"data"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
