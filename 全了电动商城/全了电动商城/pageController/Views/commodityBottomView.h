//
//  commodityBottomView.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commodityBottomView : UIView
/** 参与夺宝 */
@property (nonatomic , strong)UIButton *partakeBtn;
/** 全价直购 */
@property (nonatomic , strong)UIButton *AllMoneyBtn;
/** 积分购 */
@property (nonatomic , strong)UIButton *integralBuy;

- (instancetype)initWithFrame:(CGRect)frame ;
@end
