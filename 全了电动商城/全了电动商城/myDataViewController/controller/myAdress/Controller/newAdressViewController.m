//
//  newAdressViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "newAdressViewController.h"
#import "cityModel.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface newAdressViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic , strong)NSMutableArray *cityArray;
@property (nonatomic , strong)NSMutableArray *secondCityArr;
@property (strong,nonatomic) NSMutableArray *thirdArray;
@property (strong,nonatomic) UIPickerView *pickerView;
/** 用户输入的信息 */
//姓名
@property (nonatomic , strong)UITextField *nameField;
//手机
@property (nonatomic , strong)UITextField *phoneField;
//详细地址
@property (nonatomic , strong)UITextField *DetailedAdress;
//省市区
@property (nonatomic , strong)UILabel *AdressLabel;
/** 接受省市区 */
@property (nonatomic , strong)NSString *shenStr;
@property (nonatomic , strong)NSString *shiStr;
@property (nonatomic , strong)NSString *quStr;
//地区编码
@property (nonatomic , strong)NSString *RegionStr;
//用户的IP
@property (nonatomic , strong)NSString *IPAdress;

@end

@implementation newAdressViewController
- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
- (NSMutableArray *)secondCityArr {
    if (!_secondCityArr) {
        _secondCityArr = [NSMutableArray array];
    }
    return _secondCityArr;
}

- (NSMutableArray *)thirdArray{
    if (!_thirdArray) {
        _thirdArray = [NSMutableArray array];
    }
    return _thirdArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(242, 242, 242);
    [self setAdressView];
    [self configNavigation];
    [self setMainView];
    [self getIPAddress];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"新增地址";
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
#pragma mark ----- setMainView 创建地址主要的视图
//主视图显示
- (void)setAdressView {
    //省市区显示的Label
    _AdressLabel = [UILabel new];
    _AdressLabel.text = [NSString stringWithFormat:@"请选择省市区 !"];
    _AdressLabel.textColor = [UIColor grayColor];
    _AdressLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_AdressLabel];
    UILabel *dataAdress = [UILabel new];
    dataAdress.text = @"省市区:";
    dataAdress.textColor = [UIColor grayColor];
    dataAdress.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:dataAdress];
    
    //姓名
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"姓名:";
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:nameLabel];
    _nameField = [UITextField new];
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    _nameField.placeholder = @"请输入收货人姓名:";
    _nameField.font = [UIFont systemFontOfSize:13];
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_nameField];
    
    //电话
    UILabel *phoneLabel = [UILabel new];
    phoneLabel.text = @"电话:";
    phoneLabel.textColor = [UIColor grayColor];
    phoneLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:phoneLabel];
    _phoneField = [UITextField new];
    _phoneField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneField.placeholder = @"请输入收货人电话:";
    _phoneField.font = [UIFont systemFontOfSize:13];
    _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneField];
    
    //详细地址
    UILabel *DetailedAdressLabel = [UILabel new];
    DetailedAdressLabel.text = @"详细地址:";
    DetailedAdressLabel.textColor = [UIColor grayColor];
    DetailedAdressLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:DetailedAdressLabel];
    _DetailedAdress = [UITextField new];
    _DetailedAdress.borderStyle = UITextBorderStyleRoundedRect;
    _DetailedAdress.placeholder = @"请输入详细地址:";
    _DetailedAdress.font = [UIFont systemFontOfSize:13];
    _DetailedAdress.clearButtonMode = UITextFieldViewModeWhileEditing;
    _DetailedAdress.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_DetailedAdress];
    
    /** Masonry */
    [dataAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dataAdress.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [DetailedAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [_AdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(dataAdress.mas_right).offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_AdressLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(nameLabel.mas_right).offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameField.mas_bottom).offset(20);
        make.left.mas_equalTo(phoneLabel.mas_right).offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_DetailedAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneField.mas_bottom).offset(20);
        make.left.mas_equalTo(DetailedAdressLabel.mas_right).offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    //保存按钮
    UIButton *dismissBtn = [UIButton new];
    [dismissBtn setTitle:@"保 存 地 址" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dismissBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    dismissBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [dismissBtn addTarget:self action:@selector(setDismissBtnVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.bottom.mas_equalTo(-50);
        make.height.mas_equalTo(40);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
//保存数据 并且返回
- (void)setDismissBtnVC {
    if (self.nameField.text.length == 0|| self.phoneField.text.length == 0 || self.DetailedAdress.text.length == 0) {
        [ProgressHUD showError:@"用户名、电话、详细地址\n不能为空"];
        return;
    }
    //时间戳
    NSDate* date1 = [NSDate date];
    NSTimeInterval time1 =[date1 timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",time1];
    //发送数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //把参数写到字典里
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:11];
    parameters[@"uid"] = self.userId;
    parameters[@"xingming"] = _nameField.text;
    parameters[@"shouji"] = _phoneField.text;
    parameters[@"diqu"] = _RegionStr;
    parameters[@"dizhi"] = _DetailedAdress.text;
    parameters[@"off"] = @"2";
    parameters[@"atime"] = timeString;
    parameters[@"ip"] = _IPAdress;
    NSString *MD5str = [NSString stringWithFormat:@"%@%@%@%@%@",self.userId,_nameField.text,_phoneField.text,_RegionStr,_DetailedAdress.text];
    parameters[@"token"] = [MD5Str md5String:MD5str];
    LDLog(@"加密后====%@",[MD5Str md5String:MD5str]);
    NSString *dizhiStr= [NSString stringWithFormat:@"%@%@",_AdressLabel.text,_DetailedAdress.text];
    LDLog(@"%@",dizhiStr);
    parameters[@"beizhu"] = dizhiStr;
    parameters[@"id"] = [NSString stringWithFormat:@""];
    // 1.创建请求管理对象
    [manager POST:@"http://myadmin.all-360.com:8080/Admin/AppApi/addressHandle" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSString *code = responseObject[@"code"];
        LDLog(@"%@",parameters);
        if ([code intValue] == 7200) {
            [ProgressHUD showSuccess:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else if ([code intValue] != 7200 ) {
            NSLog(@"code = %@",code);
            [ProgressHUD showError:@"注册失败"];
        }else
            [ProgressHUD showError:@"注册失败"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"注册失败 = %@",error);
        [ProgressHUD showError:@"注册失败"];
    }];
}
//setPickView
- (void)setMainView {
    // 选择框
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 200)];
    _pickerView.backgroundColor = kColor_RGB(242, 242, 242);
    // 显示选中框
    _pickerView.showsSelectionIndicator=YES;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
    [self loadCollectionCellData];
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.cityArray count];
    }else if (component == 1) {
        return [self.secondCityArr count];
    }else
        return [self.thirdArray count];
    
    
}
#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return self.view.bounds.size.width/3;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        cityModel *goodsModel = self.cityArray[row];
//        NSLog(@"%@",goodsModel.cityName);
        self.shenStr = [NSString stringWithFormat:@"%@",goodsModel.cityName];
        [self loadSecondArrayDatabySID:goodsModel.diqu];
    } else if (component == 1) {
        cityModel *goodsModel = self.secondCityArr[row];
        self.shiStr = [NSString stringWithFormat:@"%@",goodsModel.cityName];
        [self loadThirdArrayDatabySID:goodsModel.diqu];
    }else {
        cityModel *goodsModel = self.thirdArray[row];
        self.quStr = [NSString stringWithFormat:@"%@",goodsModel.cityName];
//        NSLog(@"最后获取到的地区编码=%@",goodsModel.diqu);
        _RegionStr = goodsModel.diqu;
        
    }
    _AdressLabel.text = [NSString stringWithFormat:@"%@%@%@",self.shenStr,self.shiStr,self.quStr];
        LDLog(@"%@%@%@",self.shenStr,self.shiStr,self.quStr);
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        cityModel *goodsModel = self.cityArray[row];
        NSLog(@"%@",goodsModel.cityName);
        return goodsModel.cityName;
    } else if (component == 1){
        cityModel *goodsModel = self.secondCityArr[row];
        return goodsModel.cityName;
    }else {
        cityModel *goodsModel = self.thirdArray[row];
        return goodsModel.cityName;
    }
}

#pragma mark -- 加载数据
- (void)loadCollectionCellData{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/city"];
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"fanhui %@",responseObject);
        //如果数组 是NSArray  这里是字典就用字典接受responseObject 数据
        NSDictionary *dataDic = responseObject;
        //data 里面是数组  用数组接受
        NSArray *dataArray = dataDic[@"data"];
        [self loadSecondArrayDatabySID:dataArray[0][@"diqu"]];
        //里面是数组就用数组接受 现在是字典
        for (NSDictionary *tempDic in dataArray) {
            //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
            cityModel *goodsModel = [cityModel setCityDataWithDic:tempDic];
            //有一个可变数组   (转变成模型)把数据放在可变数组里
            [self.cityArray addObject:goodsModel];
        }
        [self.pickerView reloadAllComponents];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败 = %@",error);
    }];
}

/** 这是我第二级请求数据的方法  这样写对吗?    模型跟第一级一模一样*/
- (void)loadSecondArrayDatabySID:(NSString *)mysid{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/city/sid/%@",mysid];//这里跟上第一级数据对应的diqu编码
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = responseObject;
        [self.secondCityArr removeAllObjects];
        //data 里面是数组  用数组接受
        NSArray *dataArray = dataDic[@"data"];
        [self loadThirdArrayDatabySID:dataArray[0][@"diqu"]];
        //里面是数组就用数组接受 现在是字典
        for (NSDictionary *tempDic in dataArray) {
            //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
            cityModel *goodsModel = [cityModel setCityDataWithDic:tempDic];
            //有一个可变数组   (转变成模型)把数据放在可变数组里
            [self.secondCityArr addObject:goodsModel];
        }
        [self.pickerView reloadAllComponents];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败 = %@",error);
    }];
}

- (void)loadThirdArrayDatabySID:(NSString *)mysid{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/city/sid/%@",mysid];//这里跟上第一级数据对应的diqu编码
    [session GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //如果数组 是NSArray  这里是字典就用字典接受responseObject 数据
        NSDictionary *dataDic = responseObject;
        [self.thirdArray removeAllObjects];
        //data 里面是数组  用数组接受
        NSArray *dataArray = dataDic[@"data"];
        //里面是数组就用数组接受 现在是字典
        for (NSDictionary *tempDic in dataArray) {
            //取出数据 //调用初始化方法 把tempDic 字典 转换成模型  调用类方法
            cityModel *goodsModel = [cityModel setCityDataWithDic:tempDic];
            //有一个可变数组   (转变成模型)把数据放在可变数组里
            [self.thirdArray addObject:goodsModel];
        }
        [self.pickerView reloadAllComponents];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败 = %@",error);
    }];
}


- (NSString *)getIPAddress { 
    
    NSString *address = @"error";
    
    struct ifaddrs *interfaces = NULL;
    
    struct ifaddrs *temp_addr = NULL;
    
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        
        // Loop through linked list of interfaces
        
        temp_addr = interfaces;
        
        while(temp_addr != NULL) {
            
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                
                // Check if interface is en0 which is the wifi connection on the iPhone
                
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    
                    // Get NSString from C String
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
            
        }
        
    }
    
    // Free memory
    
    freeifaddrs(interfaces);
    _IPAdress = address;
    return address;
    
    
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
