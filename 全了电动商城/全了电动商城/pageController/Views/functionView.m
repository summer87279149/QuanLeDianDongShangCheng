//
//  functionView.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/23.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "functionView.h"

#define itemInterval ((self.bounds.size.width -40*4)/5)
#define itemLabel ((self.bounds.size.width -50*4)/5)

@interface functionView()
/** 总分3层视图 合一 */
@property (nonatomic , strong)UIView *firstView;
@property (nonatomic , strong)UIView *secondView;
@property (nonatomic , strong)UIView *thirdView;
@end
@implementation functionView

-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)backGroundColor {
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = backGroundColor;
        [self setThreeViews];
    }
    return self;
}
- (void)setThreeViews {
    _firstView  = [UIView new];
    _secondView = [UIView new];
    _thirdView  = [UIView new];
    _firstView.backgroundColor  = [UIColor whiteColor];
    _secondView.backgroundColor = [UIColor grayColor];
    _thirdView.backgroundColor  = [UIColor grayColor];
    [self addSubview:_firstView];
    [self addSubview:_secondView];
    [self addSubview:_thirdView];
    [self setThirdView];
    [self setThreeViewsMasonry];
    
}
//三个视图之间的约束
- (void)setThreeViewsMasonry {
    [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstView.mas_top).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(_firstView.bounds.size.width, 1));
    }];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, 50));
        
    }];
    [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(_firstView.bounds.size.width, 1));
    }];
}

//第三层4个按钮刷新视图的按钮
- (void)setThirdView {
    _newsBtn = [UIButton new];
    [_newsBtn setTitle:@"人气" forState:UIControlStateNormal];
    _newsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _newsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_newsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_newsBtn addTarget:self action:@selector(setnewsBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _progressBtn = [UIButton new];
    [_progressBtn setTitle:@"最新" forState:UIControlStateNormal];
    _progressBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _progressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_progressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_progressBtn addTarget:self action:@selector(setprogressBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _allDemand = [UIButton new];
    [_allDemand setTitle:@"最贵" forState:UIControlStateNormal];
    _allDemand.titleLabel.font = [UIFont systemFontOfSize:14];
    _allDemand.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_allDemand setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_allDemand addTarget:self action:@selector(setallDemand) forControlEvents:UIControlEventTouchUpInside];

    _cheapBtn = [UIButton new];
    [_cheapBtn setTitle:@"最便宜" forState:UIControlStateNormal];
    _cheapBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _cheapBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cheapBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cheapBtn addTarget:self action:@selector(setCheapBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kColor_RGB(247, 247, 247);
    
    [_firstView addSubview:_newsBtn];
    [_firstView addSubview:_progressBtn];
    [_firstView addSubview:_allDemand];
    [_firstView addSubview:_cheapBtn];
    [_firstView addSubview:lineView];
    
    /** 约束 */

    [_newsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(0);
    }];
    [_progressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(_newsBtn.mas_right).offset(0);
    }];
    [_allDemand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(_progressBtn.mas_right).offset(0);
    }];
    [_cheapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(_allDemand.mas_right).offset(0);
        make.right.mas_equalTo(0);
    }];
    [@[_newsBtn,_progressBtn,_allDemand,_cheapBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 5, 50));
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
}



#pragma mark ------ 4个按钮方法 改变颜色

- (void)setnewsBtn {
    [_newsBtn setTitleColor:kColor_RGB(252, 78, 36) forState:UIControlStateNormal];
    [_progressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_allDemand setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cheapBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
- (void)setprogressBtn {
    [_newsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_progressBtn setTitleColor:kColor_RGB(252, 78, 36) forState:UIControlStateNormal];
    [_allDemand setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cheapBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
- (void)setallDemand {
    [_newsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_progressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_allDemand setTitleColor:kColor_RGB(252, 78, 36) forState:UIControlStateNormal];
    [_cheapBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

}
- (void)setCheapBtn {
    [_newsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_progressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_allDemand setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cheapBtn setTitleColor:kColor_RGB(252, 78, 36) forState:UIControlStateNormal];
}












@end
