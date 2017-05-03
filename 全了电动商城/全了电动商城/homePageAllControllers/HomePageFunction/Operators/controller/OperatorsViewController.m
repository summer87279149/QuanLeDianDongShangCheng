//
//  OperatorsViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/30.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "OperatorsViewController.h"
#import "loginViewController.h"
#import "MD5Str.h"

@interface OperatorsViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//图片的宽和高
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHightLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthLine;
//公司名称
@property (weak, nonatomic) IBOutlet UITextField *userCorporationName;
//公司地址
@property (weak, nonatomic) IBOutlet UITextField *userAdress;
//法人身份证
@property (weak, nonatomic) IBOutlet UITextField *userIDCard;
//法人手机号码
@property (weak, nonatomic) IBOutlet UITextField *userPhoneNum;
//联系人姓名
@property (weak, nonatomic) IBOutlet UITextField *userName;
//联系人电话
@property (weak, nonatomic) IBOutlet UITextField *userPhone;

@property (nonatomic , strong)NSString *userID;


@property (weak, nonatomic) IBOutlet UIImageView *YingYeImage;
@property (weak, nonatomic) IBOutlet UIImageView *IDCardImage;




@end
//
int imageNum;

@implementation OperatorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavigation];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (IS_IPHONE_5 || IS_IPHONE_6) {
        self.imageHightLine.constant = 80;
        self.imageWidthLine.constant = 80;
    }
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 创建导航栏
- (void)configNavigation {
    self.title = @"运营商";
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
//营业执照
- (IBAction)BusinessLicenseImage:(UIButton *)sender {
    imageNum = 1;
    [self setImageChange];
}
//身份证
- (IBAction)SelectionIDCardImgae:(UIButton *)sender {
    imageNum = 2;
    [self setImageChange];
}

- (IBAction)SubmitRegistration:(UIButton *)sender {
    if (_userCorporationName.text.length != 0 || _userAdress.text.length != 0 || _userIDCard.text.length != 0 || _userPhoneNum.text.length != 0 || _userName.text.length != 0 || _userPhone.text.length != 0) {
        //取本地信息
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *isLogin = [user objectForKey:@"isLogin"];
        if ([isLogin intValue] == 0) {
            if ([LDUserInfo sharedLDUserInfo].isLogin == YES) {
                //读取本地数据 获取用户ID
                [[LDUserInfo sharedLDUserInfo] readUserInfo];
                self.userID = [LDUserInfo sharedLDUserInfo].ID ;
                NSData *imageData = UIImagePNGRepresentation(self.YingYeImage.image);
                NSData *imageIDCard = UIImagePNGRepresentation(self.IDCardImage.image);
                CGFloat length = [imageData length]/1000;
                NSLog(@"PNG image data = %f kb", length);
                NSString *imageStrOne = [MD5Str base64EncodingWithData:imageData];
                NSString *imageStrTwo = [MD5Str base64EncodingWithData:imageIDCard];
                NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:12];
                parameters[@"name"] = _userCorporationName.text;
                parameters[@"tel"] = _userPhone.text;
                parameters[@"address"] = _userAdress.text;
                parameters[@"linkman"] = _userName.text;
                parameters[@"type"] = self.statuNum;
                parameters[@"uid"] = self.userID;
                parameters[@"legal_name"] = @"";
                parameters[@"legal_tel"] = _userPhoneNum.text;
                parameters[@"legal_id"] = _userIDCard.text;
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
            } else {
                //如果没登录就跳转
                [self.navigationController pushViewController:[loginViewController new] animated:YES];
            }
        }else if ([isLogin intValue] != 0) {
            self.userID = [user objectForKey:@"userID"];
            NSData *imageData = UIImagePNGRepresentation(self.YingYeImage.image);
            NSData *imageIDCard = UIImagePNGRepresentation(self.IDCardImage.image);
            CGFloat length = [imageData length]/1000;
            NSLog(@"PNG image data = %f kb", length);
            NSString *imageStrOne = [MD5Str base64EncodingWithData:imageData];
            NSString *imageStrTwo = [MD5Str base64EncodingWithData:imageIDCard];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:12];
            parameters[@"name"] = _userCorporationName.text;
            parameters[@"tel"] = _userPhone.text;
            parameters[@"address"] = _userAdress.text;
            parameters[@"linkman"] = _userName.text;
            parameters[@"type"] = self.statuNum;
            parameters[@"uid"] = self.userID;
            parameters[@"legal_name"] = @"";
            parameters[@"legal_tel"] = _userPhoneNum.text;
            parameters[@"legal_id"] = _userIDCard.text;
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
    if (imageNum == 1) {
        //获取图片
        UIImage *image = info[UIImagePickerControllerEditedImage];
        _YingYeImage.image = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }else if (imageNum == 2){
        //获取图片
        UIImage *image = info[UIImagePickerControllerEditedImage];
            _IDCardImage.image = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}







@end
