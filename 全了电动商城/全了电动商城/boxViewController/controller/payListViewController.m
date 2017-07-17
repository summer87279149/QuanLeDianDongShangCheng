//
//  payListViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/11.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "payListViewController.h"
#import <WebKit/WebKit.h>
@interface payListViewController ()<WKNavigationDelegate>

@property (nonatomic , strong)UIButton *payBtn;
/** 订单详情 */
@property (nonatomic , strong)UILabel *orderData;
@property (nonatomic , strong)UILabel *orderMoney;
/** 支付按钮选择 */
@property (nonatomic , strong)UIButton *weiXinBtn;
@property (nonatomic , strong)UIButton *ZFBBtn;
@property (nonatomic , strong)UIButton *surplusBtn;
/** 订单总额 */
@property (nonatomic , strong)NSString *allMoney;
/** 订单总额积分 */
@property (nonatomic , strong)NSString *allJiFen;

/** 是否打开微信 */
@property (nonatomic , strong)NSString *WeiChartPay;


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
//支付方式
@property (nonatomic , assign)int payStatus;

/** 微信支付的View */
@property (nonatomic , strong)UIView *weiXinView;
@end

@implementation payListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _payStatus = 1;
    self.view.backgroundColor = kColor_RGB(242, 242, 242);
    [self configNavigation];
    [self setTopView];
    [self setBottomView];
    //支付监听
    [self listenNotifications];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAllMoneyData];
}
#pragma mark ----- 获取数据
//返回总额
- (void)getAllMoneyData {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/sureOrder/orderid/%@",_orderNum];
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"111111%@",responseObject);
        _allMoney = responseObject[@"data"][@"total"];
        _allJiFen = responseObject[@"data"][@"jifen"];
        _WeiChartPay = responseObject[@"data"][@"WX"];
        //选择是否打开微信支付
        if ([_WeiChartPay intValue] == 0) {
            _weiXinView.hidden = YES;
        }else if ([_WeiChartPay intValue] != 0) {
            _weiXinView.hidden = NO;
        }
        _orderMoney.text = [NSString stringWithFormat:@"订单金额: %@",_allMoney];
        _orderData.text = [NSString stringWithFormat:@"订单号: %@",_orderNum];
        LDLog(@"%@",_allMoney);
        [self getOrderData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
//返回订单信息  需要提交给支付接口
- (void)getOrderData {
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/wxPay/orderid/%@/total/%@/jifen/%@",_orderNum,_allMoney,_allJiFen];
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _payBtn.enabled = YES;
        LDLog(@"%@",responseObject);
        _appid = responseObject[@"data"][@"appid"];
        _partnerid = responseObject[@"data"][@"partnerid"];
        _prepayid = responseObject[@"data"][@"prepayid"];
        _package = responseObject[@"data"][@"package"];
        _noncestr = responseObject[@"data"][@"noncestr"];
        _timestamp = responseObject[@"data"][@"timestamp"];
        _sign = responseObject[@"data"][@"sign"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"error = %@",error);
    }];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"支付方式";
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
//顶部灰色30分钟说明
- (void)setTopView {
    //    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    //    topView.backgroundColor = [UIColor grayColor];
    //    [self.view addSubview:topView];
    //
    //    UILabel *firstLabel = [UILabel new];
    //    firstLabel.text = @"订单提交成功,只差最后一步支付就可以啦!";
    //    firstLabel.textColor = [UIColor whiteColor];
    //    firstLabel.font = [UIFont systemFontOfSize:14];
    //    [topView addSubview:firstLabel];
    //
    //    UILabel *secondLabel = [UILabel new];
    //    secondLabel.text = @"请在30分钟内完支付,否则会自动取消";
    //    secondLabel.textColor = [UIColor whiteColor];
    //    secondLabel.font = [UIFont systemFontOfSize:12];
    //    [topView addSubview:secondLabel];
    
    //    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo (15);
    //        make.top.mas_equalTo(10);
    //    }];
    //    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo (15);
    //        make.bottom.mas_equalTo(-10);
    //    }];
    
    /** 订单详情 */
    UIView *orderDataView = [UIView new];
    orderDataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:orderDataView];
    
    _orderData = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 20, 18)];
    _orderData.text = @"订单号:  ";
    _orderData.font = [UIFont systemFontOfSize:13];
    _orderData.textColor = [UIColor grayColor];
    [orderDataView addSubview:_orderData];
    
    _orderMoney = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH - 20, 18)];
    _orderMoney.text = [NSString stringWithFormat:@"订单金额: %@",_allMoney];
    _orderMoney.font = [UIFont systemFontOfSize:13];
    _orderMoney.textColor = [UIColor grayColor];
    [orderDataView addSubview:_orderMoney];
    
    [orderDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
    }];
    
    /** 支付方式 */
    UIView *payExplainView = [UIView new];
    payExplainView.backgroundColor = kColor_RGB(242, 242, 242);
    [self.view addSubview:payExplainView];
    
    UILabel *payExplainLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 160, 18)];
    payExplainLabel.text = @"选择支付方式:";
    payExplainLabel.font = [UIFont systemFontOfSize:13];
    [payExplainView addSubview:payExplainLabel];
    [payExplainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderDataView.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 36));
    }];
    
    /** 微信支付 */
    _weiXinView = [UIView new];
    _weiXinView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_weiXinView];
    
    UIImageView *weiImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 13, 150, 40)];
    weiImage.image = [UIImage imageNamed:@"WePayLogo"];
    [_weiXinView addSubview:weiImage];
    
    UIImageView *WeiXinLabelView = [UIImageView new];
    WeiXinLabelView.image = [UIImage imageNamed:@"按钮标签"];
    [_weiXinView addSubview:WeiXinLabelView];
    
    _weiXinBtn = [UIButton new];
    [_weiXinBtn setImage:[UIImage imageNamed:@"勾号"] forState:UIControlStateNormal];
    [_weiXinBtn addTarget:self action:@selector(setWeiXinBtn) forControlEvents:UIControlEventTouchUpInside];
    [_weiXinView addSubview:_weiXinBtn];
    
//    [_weiXinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-25);
//        make.centerY.mas_equalTo(_weiXinView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
//    
//    [WeiXinLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(20);
//        make.left.mas_equalTo(weiImage.mas_right).offset(15);
//        make.size.mas_equalTo(CGSizeMake(50, 20));
//    }];
//    [_weiXinView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(payExplainView.mas_bottom).offset(0);
//        make.left.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
//    }];
//    
    /** 支付宝支付 */
    UIView *ZFBView = [UIView new];
    ZFBView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ZFBView];
    
    UIImageView *ZFBImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 350, 60)];
    ZFBImage.image = [UIImage imageNamed:@"ZFB支付宝推荐使用"];
    [ZFBView addSubview:ZFBImage];
    
    _ZFBBtn = [UIButton new];
    [_ZFBBtn setImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
    [_ZFBBtn addTarget:self action:@selector(setZFBBtn) forControlEvents:UIControlEventTouchUpInside];
    [ZFBView addSubview:_ZFBBtn];
    
    [_ZFBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.centerY.mas_equalTo(ZFBView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [ZFBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payExplainView.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
    }];
    _payStatus = 2;
    
    /** 余额支付 */
    UIView *yuEView = [UIView new];
    yuEView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:yuEView];
    
    UIImageView *yuEImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 13, 150, 40)];
    yuEImage.image = [UIImage imageNamed:@"余额支付"];
    [yuEView addSubview:yuEImage];
    
    _surplusBtn = [UIButton new];
    [_surplusBtn setImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
    [_surplusBtn addTarget:self action:@selector(setSurplusBtn) forControlEvents:UIControlEventTouchUpInside];
    [yuEView addSubview:_surplusBtn];
    
//    [_surplusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-25);
//        make.centerY.mas_equalTo(yuEView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
//    
//    [yuEView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(ZFBView.mas_bottom).offset(5);
//        make.left.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
//    }];
}


#pragma mark ----- 底部支付
- (void)setBottomView {
    _payBtn = [UIButton new];
    _payBtn.enabled = NO;
    [_payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [_payBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_payBtn addTarget:self action:@selector(setPayBtn) forControlEvents:UIControlEventTouchUpInside];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_payBtn];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-60);
        make.left.mas_equalTo(80);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-160, 40));
    }];
}
//微信选择按钮
- (void)setWeiXinBtn {
    _payStatus = 1;
    [_weiXinBtn setImage:[UIImage imageNamed:@"勾号"] forState:UIControlStateNormal];
    [_ZFBBtn setImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
    [_surplusBtn setImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
}
//支付宝按钮
- (void)setZFBBtn {
    _payStatus = 2;
    [_weiXinBtn setImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
    [_ZFBBtn setImage:[UIImage imageNamed:@"勾号"] forState:UIControlStateNormal];
    [_surplusBtn setImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
}
//余额选择按钮
- (void)setSurplusBtn {
    _payStatus = 3;
    [_weiXinBtn setImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
    [_ZFBBtn setImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
    [_surplusBtn setImage:[UIImage imageNamed:@"勾号"] forState:UIControlStateNormal];
}




//确认支付
- (void)setPayBtn {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"全价购买请在支付完成后前往'我的=>直购记录'填写收货地址，夺宝购请等待开奖" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    if (_payStatus == 1) {
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = _partnerid;
        request.prepayId  = _prepayid;
        request.package   = _package;
        request.nonceStr  = _noncestr;
        request.timeStamp = [_timestamp intValue];
        request.sign      = _sign;
        [WXApi sendReq: request];
        LDLog(@"%@=%@=%@=%@=%u=%@",request.partnerId,request.prepayId,request.package,request.nonceStr,(unsigned int)request.timeStamp,request.sign);
        LDLog(@"微信支付 ==== %@",request);
        
    }else if (_payStatus == 2) {
        //        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        //        webView.navigationDelegate = self;
        //        [self.view addSubview:webView];
        NSString *urlStr = [NSString stringWithFormat:@"http://www.all-360.com/alipay/wappay/pay.php?orderid=%@&amount=%@&jifen=%@",_orderNum,_allMoney,_allJiFen];
        NSURL *url = [ [ NSURL alloc ] initWithString: urlStr ];
        [[UIApplication sharedApplication] openURL:url];
        
        //        NSURL *URL = [NSURL URLWithString:urlStr];
        //        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        //        [webView loadRequest:request];
        //
    }else if (_payStatus == 3){
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/balancePay/total/%@/orderid/%@/jifen/%@",_allMoney,_orderNum,_allJiFen];
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *code = responseObject[@"code"];
            LDLog(@"%@======%@=====%@",_allMoney,_allJiFen,_orderNum);
            if ([code intValue] == 9300) {
                [ProgressHUD showSuccess:@"支付成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([code intValue] == 9301) {
                [ProgressHUD showError:@"缺少参数"];
            }else if ([code intValue] == 9302) {
                [ProgressHUD showError:@"余额不足"];
            }else {
                [ProgressHUD showError:@"支付失败"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [ProgressHUD showError:@"支付失败"];
        }];
        LDLog(@"余额支付");
    }
    
}
//WKNavigationDelegate
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"加载成功");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"失败%@" , error);
}
#pragma mark -- 监听通知相关的方法
- (void)listenNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenAlipayResults:) name:@"listenWXpayResults" object:nil];
}

#pragma mark -- 监听到场地信息变化的消息后做的事情
- (void)listenAlipayResults:(NSNotification *)notification
{
    BaseResp *resp =  notification.userInfo[@"resultDic"];
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg;
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            
            [ProgressHUD showSuccess:strMsg];
            LDLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            break;
            
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            [ProgressHUD showError:strMsg];
            LDLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
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
