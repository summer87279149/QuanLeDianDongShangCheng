//
//  AftersalesCommercial.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/30.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "AftersalesCommercial.h"
#import "loginViewController.h"
@interface AftersalesCommercial ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic , strong)NSString *userID;

@property (nonatomic , strong)UITextField *DianMianField;
@property (nonatomic , strong)UITextField *DianMianAdressField;
@property (nonatomic , strong)UITextField *FaRenNameField;
@property (nonatomic , strong)UITextField *FaRenPhoneField;
@property (nonatomic , strong)UITextField *FaRenIDCardField;

@property (nonatomic , strong)UIImageView *oneImage;
@property (nonatomic , strong)UIImageView *twoImage;

@end
int imageNumber;
@implementation AftersalesCommercial

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setAftersalesCommercial];
    [self configNavigation];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.statuNum intValue] == 1) {
        self.title = @"代理商";
    } else {
    self.title = @"售后商";
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
        make.top.mas_equalTo(20);
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
    
    UILabel *FaRenPhoneLabel = [UILabel new];
    FaRenPhoneLabel.text = @"法人手机号:";
    FaRenPhoneLabel.textColor = [UIColor grayColor];
    FaRenPhoneLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:FaRenPhoneLabel];
    
    UILabel *FaRenIDCardLabel = [UILabel new];
    FaRenIDCardLabel.text = @"法人身份证号:";
    FaRenIDCardLabel.textColor = [UIColor grayColor];
    FaRenIDCardLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:FaRenIDCardLabel];
    
    UILabel *YINYELabel = [UILabel new];
    YINYELabel.text = @"营业执照:";
    YINYELabel.textColor = [UIColor grayColor];
    YINYELabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:YINYELabel];
    
    UILabel *DianMianImageLabel = [UILabel new];
    DianMianImageLabel.text = @"店面照片:";
    DianMianImageLabel.textColor = [UIColor grayColor];
    DianMianImageLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:DianMianImageLabel];
    
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
    [FaRenPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FaRenNameLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [FaRenIDCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FaRenPhoneLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [YINYELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FaRenIDCardLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [DianMianImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(YINYELabel.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    _DianMianField = [UITextField new];
    _DianMianField.placeholder = @"请输入店面名称";
    _DianMianField.borderStyle = UITextBorderStyleNone;
    _DianMianField.font = [UIFont systemFontOfSize:13];
    _DianMianField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_DianMianField];
    
    _DianMianAdressField = [UITextField new];
    _DianMianAdressField.placeholder = @"请输入店面地址";
    _DianMianAdressField.borderStyle = UITextBorderStyleNone;
    _DianMianAdressField.font = [UIFont systemFontOfSize:13];
    _DianMianAdressField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_DianMianAdressField];
    
    _FaRenNameField = [UITextField new];
    _FaRenNameField.placeholder = @"请输入法人姓名";
    _FaRenNameField.borderStyle = UITextBorderStyleNone;
    _FaRenNameField.font = [UIFont systemFontOfSize:13];
    _FaRenNameField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_FaRenNameField];
    
    _FaRenPhoneField = [UITextField new];
    _FaRenPhoneField.placeholder = @"请输法人手机号";
    _FaRenPhoneField.borderStyle = UITextBorderStyleNone;
    _FaRenPhoneField.font = [UIFont systemFontOfSize:13];
    _FaRenPhoneField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_FaRenPhoneField];
    
    _FaRenIDCardField = [UITextField new];
    _FaRenIDCardField.placeholder = @"请输入法人身份证号码";
    _FaRenIDCardField.borderStyle = UITextBorderStyleNone;
    _FaRenIDCardField.font = [UIFont systemFontOfSize:13];
    _FaRenIDCardField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_FaRenIDCardField];
    
    [_DianMianField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LogoImage.mas_bottom).offset(50);
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_DianMianAdressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_DianMianField.mas_bottom).offset(15);
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_FaRenNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_DianMianAdressField.mas_bottom).offset(15);
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_FaRenPhoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_FaRenNameField.mas_bottom).offset(15);
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_FaRenIDCardField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_FaRenPhoneField.mas_bottom).offset(15);
        make.left.mas_equalTo(120);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    _oneImage = [UIImageView new];
    [self.view addSubview:_oneImage];
    
    [_oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_FaRenIDCardField.mas_bottom).offset(15);
        make.left.mas_equalTo(YINYELabel.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _twoImage = [UIImageView new];
    [self.view addSubview:_twoImage];
    
    [_twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(YINYELabel.mas_bottom).offset(15);
        make.left.mas_equalTo(DianMianImageLabel.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UIButton *oneBtn = [UIButton new];
    [oneBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [oneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [oneBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    oneBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [oneBtn addTarget:self action:@selector(setOneImages) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneBtn];
    
    UIButton *twoBtn = [UIButton new];
    [twoBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [twoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [twoBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    twoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [twoBtn addTarget:self action:@selector(setTwoImages) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twoBtn];
    
    [oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_FaRenIDCardField.mas_bottom).offset(15);
        make.right.mas_equalTo(-25);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(YINYELabel.mas_bottom).offset(15);
        make.right.mas_equalTo(-25);
        make.size.mas_equalTo(CGSizeMake(80, 20));
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

- (void)setOneImages {
    imageNumber = 1;
    [self setImageChange];
}
- (void)setTwoImages {
    imageNumber = 2;
    [self setImageChange];
}
#pragma mark ----- 按钮功能选项
/** 图片选择 点击按钮弹出底部视图选择相机或者相册 */
- (void)setImageChange {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 添加判断，防止模拟器崩溃
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.delegate = self;
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.allowsEditing = YES;
        // 可以设置手势
        [self presentViewController:pickerController animated:YES completion:nil];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:photoAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
//选取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (imageNumber == 1) {
        //获取图片
        UIImage *image = info[UIImagePickerControllerEditedImage];
        _oneImage.image = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }else if (imageNumber == 2){
        //获取图片
        UIImage *image = info[UIImagePickerControllerEditedImage];
        _twoImage.image = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

//提交订单
- (void)setTiJiaoBtn {
    if (_DianMianField.text.length != 0 || _DianMianAdressField.text.length != 0 || _FaRenNameField.text.length != 0 || _FaRenPhoneField.text.length != 0 || _FaRenIDCardField.text.length != 0) {
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
            NSData *imageData = UIImagePNGRepresentation(self.oneImage.image);
            NSData *imageIDCard = UIImagePNGRepresentation(self.twoImage.image);
            CGFloat length = [imageData length]/1000;
            NSLog(@"PNG image data = %f kb", length);
            NSString *imageStrOne = [MD5Str base64EncodingWithData:imageData];
            NSString *imageStrTwo = [MD5Str base64EncodingWithData:imageIDCard];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:12];
            parameters[@"name"] = _DianMianField.text;
            parameters[@"tel"] = @"";
            parameters[@"address"] = _DianMianAdressField.text;
            parameters[@"linkman"] = @"";
            parameters[@"type"] = self.statuNum;
            parameters[@"uid"] = self.userID;
            parameters[@"legal_name"] = _FaRenNameField.text;
            parameters[@"legal_tel"] = _FaRenPhoneField.text;
            parameters[@"legal_id"] = _FaRenIDCardField.text;
            parameters[@"business_license"] = imageStrOne;
            parameters[@"legal_img"] = imageStrTwo;
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
    // Dispose of any resources that can be recreated.
}



@end
