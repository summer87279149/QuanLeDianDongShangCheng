//
//  shareTopView.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/22.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shareTopView : UIView
@property (nonatomic, copy) NSString *imgURL;
//用户的UID
@property (weak, nonatomic) IBOutlet UILabel *userUID;
//点击生成用户的二维码
@property (weak, nonatomic) IBOutlet UIButton *userQRCode;
//立即赚钱
@property (weak, nonatomic) IBOutlet UIButton *makepriceNow;
//左边的邀请人数
@property (weak, nonatomic) IBOutlet UILabel *leftNum;
//左边的邀请钱数
@property (weak, nonatomic) IBOutlet UILabel *leftMoney;
//右边的钱数
@property (weak, nonatomic) IBOutlet UILabel *rightMoney;
//右边邀请人的数量
@property (weak, nonatomic) IBOutlet UILabel *rightNum;

@end
