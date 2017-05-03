//
//  baskOrderViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/14.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "baskOrderViewController.h"
#import "AllMyController.pch"
@interface baskOrderViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//用户输入的获奖感言
@property (nonatomic , strong)UITextField *winTextField;
//晒单图片的按钮
@property (nonatomic , strong)UIButton *imageChangeBtn;
//确认晒单
@property (nonatomic , strong)UIButton *confirmBtn;
//查看晒单
@property (nonatomic , strong)UIButton *lookOrderBtn;
/** 晒单图片 */
@property (nonatomic , strong)UIImageView *orderImageView;
/** 中奖产品名称 */
@property (nonatomic , strong)UILabel *nameLabel;
@end

@implementation baskOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(242, 242, 242);
    [self configNavigation];
    [self setViewController];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"晒单";
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
#pragma mark ----- setViewController 晒单视图主要内容
- (void)setViewController {
    /** 获奖 信息 名称 */
    UIButton *titleBtn = [UIButton new];
    [titleBtn setTitle:@"我要晒单" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [titleBtn addTarget:self action:@selector(setZhongJiangVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:titleBtn];
    
   

    _nameLabel = [UILabel new];
    _nameLabel.text = @"您还未中奖";
    _nameLabel.textColor = [UIColor redColor];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_nameLabel];
    
    [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (20);
        make.left.mas_equalTo(titleBtn.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    /** 获奖感言 */
    _winTextField = [UITextField new];
    _winTextField.placeholder = @"请输入获奖感言!";
    _winTextField.borderStyle = UITextBorderStyleRoundedRect;
    _winTextField.font = [UIFont systemFontOfSize:13];
    _winTextField.clearsOnInsertion = YES;
    _winTextField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_winTextField];
    [_winTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 30));
    }];
    /** 图片选择按钮 */
    _imageChangeBtn = [UIButton new];
    [_imageChangeBtn setBackgroundImage:[UIImage imageNamed:@"加入宝箱"] forState:UIControlStateNormal];
    [_imageChangeBtn setTitle:@"点击选择图片" forState:UIControlStateNormal];
    [_imageChangeBtn setTitleColor:kColor_RGB(217, 57, 84) forState:UIControlStateNormal];
    [_imageChangeBtn addTarget:self action:@selector(setImageChange) forControlEvents:UIControlEventTouchUpInside];
    _imageChangeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_imageChangeBtn];
    [_imageChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_winTextField.mas_bottom).offset(20);
        make.left.mas_equalTo((SCREEN_WIDTH - 100)/2);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    /** 用户晒单的图片 */
    _orderImageView = [UIImageView new];
    _orderImageView.image = [UIImage imageNamed:@"晒单1"];
    [self.view addSubview:_orderImageView];
    [_orderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageChangeBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-60);
    }];
    /** 确认晒单 - > 查看晒单 */
    _confirmBtn = [UIButton new];
    [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_confirmBtn setTitle:@"确认晒单" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(setSaveImage) forControlEvents:UIControlEventTouchUpInside];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_confirmBtn];
    
    _lookOrderBtn = [UIButton new];
    [_lookOrderBtn setBackgroundImage:[UIImage imageNamed:@"提交订单"] forState:UIControlStateNormal];
    [_lookOrderBtn setTitle:@"查看晒单" forState:UIControlStateNormal];
    [_lookOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _lookOrderBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_lookOrderBtn addTarget:self action:@selector(gotoLookOrderViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lookOrderBtn];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo((SCREEN_WIDTH - 200)/3);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [_lookOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-(SCREEN_WIDTH - 200)/3);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
/** 保存图片成功上传服务器 并且返回上个界面 */
- (void)setSaveImage {
    BXHttpManager *manager = [BXHttpManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/saiDan/uid/%@/cpid/%@/qihao/%@/zhongh/%@/miaoshu/%@",self.uid,self.cpid,self.qihao,self.zhongh,_winTextField];

    /** 调用方法上传图片 */
    [manager PostImagesToServer:urlStr dicPostParams:nil imageArray:@[_orderImageView.image] file:@[@"file"] imageName:@[@"miaoshu"] Success:^(id responseObject) {
        LDLog(@"%@====",responseObject);
        [ProgressHUD showSuccess:@"上传成功"];
    } andFailure:^(NSError *error) {
        [ProgressHUD showError:@"上传失败"];
        LDLog(@"error  ====%@ ",error);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}
/** 跳转到我的晒单详情界面 */
- (void)gotoLookOrderViewController {

    [self.navigationController pushViewController:[orderRecordViewController new] animated:YES];
}

- (void)setZhongJiangVC {
    /** block回调  */
    LuckViewController *luckVC = [[LuckViewController alloc]init];
    luckVC.block = ^(NSString *shopName,NSString *cpid,NSString *qihao,NSString *zhonghao){
        LDLog(@"%@-%@-%@-%@",shopName,cpid,qihao,zhonghao);
        self.shopName = shopName;
        self.cpid = cpid;
        self.qihao = qihao;
        self.zhongh = zhonghao;
        _nameLabel.text = shopName;
    };
    [self.navigationController pushViewController:luckVC animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _orderImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
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
