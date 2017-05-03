//
//  functionView.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/23.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface functionView : UIView


/** 人气 - 热门 - 最新 - 最贵 - 易重 */
@property (nonatomic , strong)UIButton *newsBtn;
@property (nonatomic , strong)UIButton *progressBtn;
@property (nonatomic , strong)UIButton *allDemand;
@property (nonatomic , strong)UIButton *cheapBtn;

-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)backGroundColor;

@end
