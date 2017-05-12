//
//  ExtractCash.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/22.
//  Copyright © 2017年 亮点网络. All rights reserved.
//
#import "UserTool.h"
#import "ExtractCash.h"

@interface ExtractCash ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIPickerView*view;
}
@property (weak, nonatomic) IBOutlet UILabel *listMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *jine;
@property (weak, nonatomic) IBOutlet UIButton *getMoneyTpye;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *zhanghao;
@property (weak, nonatomic) IBOutlet UITextField *beizhu;
@property (nonatomic, strong) NSString *listMoney;
@property (nonatomic, strong) NSArray *bankArr;
@end

@implementation ExtractCash

- (void)viewDidLoad {
    [super viewDidLoad];
    [QLRequest getMyListMoneySuccess:^(id response) {
        if ([response[@"code"]intValue]!=96030) {
            return ;
        }
        self.listMoney = response[@"data"];
        [self configNavigation];
    } error:^(id response) {
        
    }];
    [QLRequest getMoneyTypeSuccess:^(id response) {
        if ([response[@"code"]intValue]==97000) {
            self.bankArr = response[@"data"];
            view = [[UIPickerView alloc]init];
            view.delegate = self;
            view.dataSource  = self;
            view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200);
            [self.view addSubview:view];
        }
    } error:^(id response) {
        
    }];
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.bankArr.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 150;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}


- ( NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.bankArr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [UIView animateWithDuration:0.5f animations:^{
        view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200);
    } completion:^(BOOL finished) {
        if (finished) {
            [self.getMoneyTpye setTitle:self.bankArr[row] forState:UIControlStateNormal];
        }
    }];
}
-(NSArray*)bankArr{
    if(!_bankArr){
        _bankArr = @[@"支付宝",@"工商银行",@"中国银行",@"农业银行",@"交通银行"];
    }
    return _bankArr;
}
- (IBAction)typeBtnClicked:(UIButton *)sender {
    if (view) {
        [UIView animateWithDuration:0.5f animations:^{
            view.frame = CGRectMake(0, SCREEN_HEIGHT-250, SCREEN_WIDTH, 200);
        } completion:nil];
    }else{
        return;
    }
    
}


#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"佣金提现";
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
    self.listMoneyLabel.text = [NSString stringWithFormat:@"剩余可提现金额是:%@",self.listMoney];
}

- (IBAction)submit:(id)sender {
    
    if(self.name.text.length==0||self.zhanghao.text.length==0||self.beizhu.text.length==0){
        [ProgressHUD showError:@"请填写完整信息"];
        return;
    }
    if (![UserTool validateNumber: self.jine.text ]) {
        [ProgressHUD showError:@"请输入整数数字金额"];
        return;
    }
    
    LDUserInfo* user = [LDUserInfo sharedLDUserInfo];
    [user readUserInfo];
    NSUInteger typeint = [self.bankArr indexOfObject:self.getMoneyTpye.currentTitle];
    
    NSNumber *typeNumber = [NSNumber numberWithInteger:typeint];
    NSDictionary *para = @{@"uid":@"12756",
                           @"jine":self.jine.text,
                           @"fangshi":typeNumber,
                           @"xingming":self.name.text,
                           @"zhanghao":self.zhanghao.text,
                           @"beizhu":self.beizhu.text
                           };
    NSLog(@"请求参数%@",para);
    [QLRequest submitGetMoneyWithPara:para success:^(id response) {
        NSLog(@"response=  %@",response);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:response[@"message"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([response[@"code"]intValue]==96020) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } error:^(id response) {
        
    }];
}



- (void) dealBack {
    [self.navigationController popViewControllerAnimated:YES];
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
