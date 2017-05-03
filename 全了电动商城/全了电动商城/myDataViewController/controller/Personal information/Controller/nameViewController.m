//
//  nameViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "nameViewController.h"
#import "changeView.h"
@interface nameViewController ()
@property (nonatomic , strong)changeView *changeView;
@end

@implementation nameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_RGB(241, 238, 238);
    [self configNavigation];
    [self setChangeView];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    self.title = @"资料修改";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 15);
    [backButton setBackgroundImage:[UIImage imageNamed:@"箭头白"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(setDismissBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    UIBarButtonItem *conserveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(setConserveBtn)];
    [conserveItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = conserveItem;
    
}
//保存地址
- (void)setDismissBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setConserveBtn {

    if (_changeView.nameChangeField.text.length > 0 & _changeView.numberChangeField.text.length == 11) {
        [self changePersonalData];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (_changeView.nameChangeField.text.length > 0 & _changeView.numberChangeField.text.length != 11) {
        [ProgressHUD showError:@"手机号码不正确"];
    } else  
        [ProgressHUD showError:@"姓名和手机账号不能为空!"];

}
#pragma mark ----- setChangeView 
- (void)setChangeView {
    _changeView = [[NSBundle mainBundle]loadNibNamed:@"changeView" owner:nil options:nil].lastObject;
    _changeView.frame = CGRectMake(0, 100, SCREEN_WIDTH, 200);
    _changeView.nameChangeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _changeView.numberChangeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_changeView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark ----- 修改名称和手机号码
- (void)changePersonalData {
    
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
    parameters[@"name"] = _changeView.nameChangeField.text;
    parameters[@"mobil"] = _changeView.numberChangeField.text;
    NSString *idStr = [NSString stringWithFormat:@"%d",self.userID];
    parameters[@"uid"] = idStr;
    // 1.创建请求管理对象
    [manager POST:@"http://myadmin.all-360.com:8080/Admin/AppApi/userInfoHandle" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = responseObject[@"code"];
        if ([code intValue] == 6200) {
            [ProgressHUD showSuccess:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else if ([code intValue] != 6200 ) {
            [ProgressHUD showError:@"修改失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"修改失败 = %@",error);
        [ProgressHUD showError:@"修改失败"];
    }];
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
