//
//  commodityBottomView.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "commodityBottomView.h"

@implementation commodityBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self setThreeView];
    }
    return self;
}

- (void)setThreeView {
    
    _partakeBtn = [UIButton new];
    [_partakeBtn setTitle:@"参与夺宝" forState:UIControlStateNormal];
    [_partakeBtn setBackgroundColor:kColor_RGB(253, 119, 43)];
    [self addSubview:_partakeBtn];
    
    _AllMoneyBtn = [UIButton new];
    [_AllMoneyBtn setTitle:@"全价直购" forState:UIControlStateNormal];
    [_AllMoneyBtn setBackgroundColor:kColor_RGB(217, 57, 85)];
    [self addSubview:_AllMoneyBtn];
    
    _integralBuy = [UIButton new];
    [_integralBuy setTitle:@"积分购" forState:UIControlStateNormal];
    [_integralBuy setBackgroundColor:kColor_RGB(253, 119, 43)];
    [self addSubview:_integralBuy];
    
    /** 3个主约束 */
    [_partakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, self.bounds.size.height));
    }];
    [_AllMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_partakeBtn.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, self.bounds.size.height));
    }];
    [_integralBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_AllMoneyBtn.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, self.bounds.size.height));
    }];

}













@end
