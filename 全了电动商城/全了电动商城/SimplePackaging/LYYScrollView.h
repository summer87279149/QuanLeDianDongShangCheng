//
//  LYYScrollView.h
//  联系布局
//
//  Created by 懒洋洋 on 16/12/7.
//  Copyright © 2016年 亮点网络. All rights reserved.
//
#pragma mark ----------- 封装scrollView

#import <UIKit/UIKit.h>

@interface LYYScrollView : UIView
/** 滚动视图 */
@property (nonatomic , strong)UIScrollView *scrollView;
/** 可以在外面修改page小圆点的颜色属性等 */
@property (nonatomic , strong)UIPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)imageArray;














@end
