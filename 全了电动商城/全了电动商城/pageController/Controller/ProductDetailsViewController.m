//
//  ProductDetailsViewController.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "winningModel.h"
@interface ProductDetailsViewController ()

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigation];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDatas];
}
#pragma mark - 创建导航栏
- (void)configNavigation {
    
    self.title = @"内容详情";
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark ----- loadData
- (void)loadDatas {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/saiDanShare/id/%@",_ID];
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LDLog(@"%@",responseObject);
        NSDictionary *dataDic = responseObject;
        NSArray *dataArray = dataDic[@"data"];
        for (NSDictionary *tempDic in dataArray) {
            winningModel *model = [winningModel setWinningDataWithDic:tempDic];
            self.userName.text = [NSString stringWithFormat:@"%@", model.username];
            [self.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.touxiang]]];
            self.userSayLabel.text = [NSString stringWithFormat:@"%@",model.miaoshu];
            self.userYear.text = [NSString stringWithFormat:@"晒单时间:%@",model.atime];
            self.shopName.text = [NSString stringWithFormat:@"%@",model.cp_name];
            self.allNumber.text = [NSString stringWithFormat:@"%@",model.yigou];
            self.shopNumber.text = [NSString stringWithFormat:@"%@",model.zhonghao];
            self.yearOrTime.text = [NSString stringWithFormat:@"%@",model.zhongtime];
            NSString *imageStr = [NSString stringWithFormat:@"%@%@",ImageUrl,model.cp_suoluetu];
            [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LDLog(@"error = %@",error);
    }];
}

@end
