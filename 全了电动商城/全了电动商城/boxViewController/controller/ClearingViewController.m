//
//  ClearingViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/11.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "ClearingViewController.h"
#import "listTableViewCell.h"
#import "payListViewController.h"
#import "goodsDataModel.h"
#import "loginViewController.h"
#import "newAdressViewController.h"
@interface ClearingViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 提交订单 */
@property (nonatomic , strong)UIButton *submitBtn;
//tabelView
@property (nonatomic , strong)UITableView *tabelView;
//储存的数据源
@property (nonatomic , strong)NSMutableArray *dataModelArray;
@property (nonatomic , strong)UILabel *payLabel;
//用户的IP
@property (nonatomic , strong)NSString *IPAdress;
//用户的ID
@property (nonatomic , strong)NSString *userID;
//模型属性
@property (nonatomic , strong)goodsDataModel *models;
//当前世界
@property (nonatomic , strong)NSString *CurrentTime;
//保存数据数组
@property (nonatomic , strong)NSMutableArray *parametersArray;
@property (nonatomic , strong)NSMutableDictionary *parameters;
//订单号
@property (nonatomic , strong)NSString *order;

@end

//商品的ID
extern NSMutableArray *ShopsIDs;
static NSString *reuseIndentifier = @"cell";

@implementation ClearingViewController
- (NSMutableArray *)dataModelArray {
    if (!_dataModelArray) {
        _dataModelArray = [NSMutableArray array];
    }
    return _dataModelArray;
}
- (NSMutableArray *)parametersArray {
    if (!_parametersArray) {
        _parametersArray = [NSMutableArray array];
    }
    return _parametersArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(247, 247, 247);

    [self setTabelView];
    [self setBottomView];
    [self configNavigation];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    /** 判断是否登录 */
    [self setIsLoginBtn];
    [self loadCellDatas];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //视图将要小时的时候  删除所有数据  否则一直增加  原因  控制没释放
    [self.dataModelArray removeAllObjects];
    [self.parametersArray removeAllObjects];
    allMoney = 0;
    LDLog(@"%@",ShopsIDs);
}
#pragma mark ----- 在这里判断是否登录
- (void)setIsLoginBtn {
    //取本地信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [user objectForKey:@"isLogin"];
    if ([isLogin intValue] == 0) {
        if ([LDUserInfo sharedLDUserInfo].isLogin == YES) {
            //读取本地数据 获取用户ID
            [[LDUserInfo sharedLDUserInfo] readUserInfo];
            self.userID = [LDUserInfo sharedLDUserInfo].ID ;
            
        } else {
            //如果没登录就跳转
            [self.navigationController pushViewController:[loginViewController new] animated:YES];
        }
    }else if ([isLogin intValue] != 0) {
        self.userID = [user objectForKey:@"userID"];
    }
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"确认订单";
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
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50)];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.backgroundColor = [UIColor whiteColor];
    [_tabelView registerNib:[UINib nibWithNibName:@"listTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIndentifier];
    [self.view addSubview:_tabelView];

}
#pragma mark ----- setBottomView
- (void)setBottomView {
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = kColor_RGB(243, 243, 243);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
        make.left.mas_equalTo(0);
    }];
    
    _payLabel = [UILabel new];
    _payLabel.text = @"应付总金额:";
    _payLabel.textColor = [UIColor grayColor];
    _payLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:_payLabel];
    
    _submitBtn = [UIButton new];
    [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_submitBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(setSubmitListBtn) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_submitBtn];
    
    /** Masonry */
    [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(20);
    }];
 
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
}
#pragma  mark ------ 提交订单
- (void)setSubmitListBtn {
    //发送数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   _parameters[@"uid"] = self.userID;//用户的ID
    LDLog(@"%@",self.parametersArray);
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithCapacity:1];
    dicData[@"dingdan"] = self.parametersArray;
    NSLog(@"%@",dicData);
    // 1.创建请求管理对象
    [manager POST:@"http://myadmin.all-360.com:8080/Admin/AppApi/orderHandle" parameters:dicData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSString *code = responseObject[@"code"];
        LDLog(@"%@",self.parametersArray);
        if ([code intValue] == 50100) {
            [ProgressHUD showSuccess:@"订单提交成功"];
            payListViewController *payListVC = [[payListViewController alloc]init];
            payListVC.orderNum = responseObject[@"data"];
            [self.navigationController pushViewController:payListVC animated:YES];
        } else if ([code intValue] != 50103 ) {
            [ProgressHUD showError:@"请勿重复提交"];
        }else
            [ProgressHUD showError:@"订单提交失败"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"注册失败 = %@",error);
        [ProgressHUD showError:@"订单提交失败"];
    }];
}



#pragma mark ----- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    listTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:reuseIndentifier forIndexPath:indexPath];
     goodsDataModel *model = self.dataModelArray[indexPath.row];
    //判断状态
    if ([model.status intValue] == 1) {
        cell.model = model;
    }else if ([model.status intValue] == 2) {
        cell.model = model;
        cell.jionNum.text = [NSString stringWithFormat:@"总金额:%@元",model.zhigoujia];
        cell.allMoney.hidden = YES;
    }else if ([model.status intValue] == 3) {
        cell.model = model;
        cell.jionNum.text = [NSString stringWithFormat:@"积分购:%@元 + %@积分",model.makeup_price,model.score_price];
        cell.allMoney.hidden = YES;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
int allMoney = 0;
int allJiFen = 0;
- (void)loadCellDatas {
    
    //获取本地时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyMMddHHmmss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    self.CurrentTime= dateTime;
    NSLog(@"当前时间是===%@",_CurrentTime);
    
    long x = arc4random() % 10009999;
    long y = arc4random() % 1099;
    _order = [NSString stringWithFormat:@"%@%ld%ld",_CurrentTime,x,y];
    LDLog(@"%@",_order);
    for (NSDictionary *dic in ShopsIDs) {
        LDLog(@"%lu---%@",(unsigned long)ShopsIDs.count,ShopsIDs);
        NSString *statusStr = [NSString stringWithFormat:@"%@",dic[@"status"]];
        NSString *GoodsNum = [NSString stringWithFormat:@"%@",dic[@"jionNum"]];
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/productShow/id/%@",dic[@"goodsID"]];
        [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LDLog(@"%@",responseObject);
            NSDictionary *dataDic = responseObject;
            NSArray *dataArray = dataDic[@"data"];
            for (NSDictionary *tempDic in dataArray) {
                LDLog(@"%lu",(unsigned long)dataArray.count);
                goodsDataModel *model = [goodsDataModel setDataWithDic:tempDic];
                
                
                /** 保存发给后台的数据 */
                
                //本地IP
                _IPAdress = [[newAdressViewController new]getIPAddress];
                LDLog(@"%@",_IPAdress);

                //把参数写到字典里
                _parameters = [NSMutableDictionary dictionaryWithCapacity:9];
                
                _parameters[@"orderid"] = _order;//订单号
                _parameters[@"uid"] = self.userID;//用户的ID
                _parameters[@"cpid"] = model.ID;//商品的ID
                _parameters[@"cpqs"] = model.dangqishu;//商品的期号
                _parameters[@"chanpindanjia"] = model.danjia;//产品的单价
                _parameters[@"shuliang"] = GoodsNum;//产品的数量
                
                if ([statusStr intValue] == 2) {
                    //直购
                    //MD5
                    NSString *MD5str = [NSString stringWithFormat:@"%@%@%@%@%@",self.userID,model.dangqishu,_order,model.ID,[NSString stringWithFormat:@"%d",[model.zhigoujia intValue]*[GoodsNum intValue]]];
                    _parameters[@"token"] = [MD5Str md5String:MD5str];//MD5
                    LDLog(@"%@",MD5str);
                    _parameters[@"zongjia"] = [NSString stringWithFormat:@"%d",[model.zhigoujia intValue]*[GoodsNum intValue]];
                    _parameters[@"chutype"] = @"1";
                    _parameters[@"jifen"] = @"0";//产品的积分
                }else if ([statusStr intValue] == 1) {
                    //夺宝购
                    //MD5
                    NSString *MD5str = [NSString stringWithFormat:@"%@%@%@%@%@",self.userID,model.dangqishu,_order,model.ID,[NSString stringWithFormat:@"%d",[model.danjia intValue]*[GoodsNum intValue]]];
                    _parameters[@"token"] = [MD5Str md5String:MD5str];//MD5
                    _parameters[@"zongjia"] = [NSString stringWithFormat:@"%d",[model.danjia intValue]*[GoodsNum intValue]];
                    _parameters[@"chutype"] = @"2";
                    _parameters[@"jifen"] = @"0";
                }else if ([statusStr intValue] == 3) {
                    //积分购
                    NSString *MD5str = [NSString stringWithFormat:@"%@%@%@%@%@",self.userID,model.dangqishu,_order,model.ID,[NSString stringWithFormat:@"%d",[model.makeup_price intValue]*[GoodsNum intValue]]];
                    _parameters[@"token"] = [MD5Str md5String:MD5str];//MD5
                    _parameters[@"zongjia"] = [NSString stringWithFormat:@"%d",[model.makeup_price intValue]*[GoodsNum intValue]];
                    _parameters[@"chutype"] = @"1";
                    _parameters[@"jifen"] = [NSString stringWithFormat:@"%d",[model.score_price intValue]*[GoodsNum intValue]];
                }

                _parameters[@"abot"] = @"1";//用户的级别
                [self.parametersArray addObject:_parameters];
                LDLog(@"%@",self.parametersArray);
                
                /***********************/
                //赋值状态
                model.status = statusStr;
                model.shopsNum = GoodsNum;
                LDLog(@"%@-- %@",GoodsNum,model.danjia);
                if ([model.status intValue] == 1) {
                    //总价 +=  每行cell加一次
                    allMoney += ([GoodsNum intValue] * [model.danjia intValue]);
                }else if ([model.status intValue] == 2) {
                    allMoney += [model.zhigoujia intValue] * [GoodsNum intValue];
                }else if ([model.status intValue] == 3) {
                    allMoney += [model.makeup_price intValue] * [GoodsNum intValue];
                    allJiFen = [model.score_price intValue] * [GoodsNum intValue];
                }
                [self.dataModelArray addObject:model];
            }
            if (allJiFen == 0) {
                _payLabel.text = [NSString stringWithFormat:@"应付总金额:%d元",allMoney];
            }else if (allJiFen != 0) {
                _payLabel.text = [NSString stringWithFormat:@"应付总金额:%d元 + %d积分",allMoney,allJiFen];
            }
            [self.tabelView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LDLog(@"error = %@",error);
        }];
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
