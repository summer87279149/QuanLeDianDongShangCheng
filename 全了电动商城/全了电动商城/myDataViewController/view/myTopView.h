//
//  myTopView.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/30.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myDataModel.h"
@interface myTopView : UIView
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
/** 用户名称 */
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
/** 用户余额 */
@property (weak, nonatomic) IBOutlet UILabel *userBalance;
/** 充值按钮 */
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
/** 设置按钮 */
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
/** 充值按钮距离底部的约束线 负数 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine;
/** 登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (nonatomic , strong)myDataModel *model;

@end
