//
//  headlineView.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/23.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "headlineView.h"

@implementation headlineView
-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)backGroundColor {
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = backGroundColor;
        [self setHeadlineView];
    }
    return self;
}
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton new];
        [_leftBtn setImage:[UIImage imageNamed:@"3条线"] forState:UIControlStateNormal];
    }
    return _leftBtn;
}
- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton new];
        [_searchBtn setImage:[UIImage imageNamed:@"白铃铛"] forState:UIControlStateNormal];
    }
    return _searchBtn;
}
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"全了电动商场";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
- (void)setBtnMasonry {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(20);
    }];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(10);
    }];
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.mas_equalTo(28);
        make.right.mas_equalTo(-10);
    }];
}
- (void)setHeadlineView {
    
    [self addSubview:self.leftBtn];
    [self addSubview:self.searchBtn];
    [self addSubview:self.titleLabel];
    
    [self setBtnMasonry];
}






























@end
