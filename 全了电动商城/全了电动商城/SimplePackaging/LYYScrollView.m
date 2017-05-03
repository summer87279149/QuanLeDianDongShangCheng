//
//  LYYScrollView.m
//  联系布局
//
//  Created by 懒洋洋 on 16/12/7.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "LYYScrollView.h"

@interface LYYScrollView ()<UIScrollViewDelegate>
/** 定时器 */
@property (nonatomic , strong)NSTimer *timer;
/** 存储图片的数组 */
@property (nonatomic , strong)NSArray *imagsArray;
@end

@implementation LYYScrollView
-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)imageArray {
    if (self = [super init]) {
        self.frame = frame;
        self.imagsArray = imageArray;
        //在这里创建滚动视图 (带个参数进方法:图片数组)
        [self setScrollViewWithImages:imageArray];
        //创建page4个小圆点视图
        [self setPageControlView];
        NSLog(@"%lu",(unsigned long)imageArray.count);
    }
    return self;
}
#pragma mark ------  配置滚动视图
- (void)setScrollViewWithImages:(NSArray *)array {
    //设置滚动视图的大小
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    self.scrollView.delegate = self;
    //设置滚动视图的内容区域
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * array.count, self.frame.size.height);
    //向滚动视图种添加内容
    for (int i = 0; i < array.count ; i++) {
        //循环依次把数组中的图片放在scrollView的屏幕上
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:array[i]]];
        UIImageView *imageView = [[UIImageView alloc]init];
        //网络请求地址版本
        [imageView sd_setImageWithURL:array[i]];
        imageView.frame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        [self.scrollView addSubview:imageView];
    }
    //设置滚动视图是否整页滑动
    self.scrollView.pagingEnabled = YES;
    //关闭拖拽到边缘的时候 可以拉出视图 显示空白区域
    self.scrollView.bounces = NO;
    //关闭水平的滑动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    //创建定时器
    [self setTimer];
}

#pragma mark ------  配置小圆点视图
- (void)setPageControlView {
    self.pageControl = [[UIPageControl alloc]init];
    //设置点的位置大小
    self.pageControl.frame = CGRectMake(SCREEN_WIDTH - 210, self.frame.size.height - 40, 300, 40);
    //设置有多少个点  等同于图片数组的图片数量
    self.pageControl.numberOfPages = self.imagsArray.count;
    //当前 选中的时第几个点  默认不设置是0
    self.pageControl.currentPage = 0;
    //每个点的颜色是什么
    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    //当前选中的点是什么颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    //关闭用户的交互功能
    self.pageControl.userInteractionEnabled = NO;
    [self addSubview:self.pageControl];
    
    
}

#pragma mark ------  创建定时器
- (void)setTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(setVerificationTime:) userInfo:nil repeats:YES];
}
//计时器开始做什么
- (void)setVerificationTime:(NSTimer *)countDownTimer {
    //当小圆点在图片最后一个的时候
    if (self.pageControl.currentPage == self.imagsArray.count - 1) {
        //滚动视图回到第一张图的初始位置
        self.scrollView.contentOffset = CGPointMake(0 * self.frame.size.width, 0);
        //小圆点 默认选中第一个  回到初始位置
        self.pageControl.currentPage = 0;
    } else {
        //否则小圆点++
        self.pageControl.currentPage++;
        //滚动视图的偏移量 等于第一个小圆点*一页图片的距离
        self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * self.frame.size.width, 0);
    }
}

//当滚动视图呗拨动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //释放定时器
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //当拨动结束启动定时器
    [self setTimer];
}
/*scrollView的代理方法  已经滑动时调用
会在视图滚动时收到通知。包括一个指向被滚动视图的指针，从中可以读取contentOffset属性以确定其滚动到的位置。*/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    round  返回的是参数中浮点数 四舍五入后 的值
    //当前在 第几页上
    int currentPageNum = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = currentPageNum;
}

//释放定时器
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)dealloc {
    //释放定时器 (跳转界面的时候也要释放定时器)
    [self.timer invalidate];
    self.timer = nil;
}








































@end
