//
//  headlineView.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/23.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface headlineView : UIView
//侧滑
@property (nonatomic , strong)UIButton *leftBtn;
//搜索
@property (nonatomic , strong)UIButton *searchBtn;
//文本
@property (nonatomic , strong)UILabel *titleLabel;
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)backGroundColor;
@end
