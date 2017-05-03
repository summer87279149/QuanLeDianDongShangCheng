//
//  QLPrefix.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/23.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#ifndef QLPrefix_h
#define QLPrefix_h




//屏幕尺寸的判断
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCALE_WIDTH ([UIScreen mainScreen].bounds.size.width/375.0)
#define SCALE_HEIGHT ([UIScreen mainScreen].bounds.size.height/667.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
//#define IS_IPHONE_4  (IS_IPHONE && SCREEN_MAX_LENGTH == )
#define IS_IPHONE_5  (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6  (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IOS_7 (NSFoundationVersionNumber>=NSFoundationVersionNumber_iOS_7_0? YES : NO)
#define kColor_RGB(x, y, z) [UIColor colorWithRed:(x)/255.0 green:(y)/255.0 blue:(z)/255.0 alpha:1]
#define LightGreyColor kColor_RGB(224, 224, 224)
#define LDWeakSelf(type)  __weak typeof(type) weak##type = type;
//NavBar高度
#define NavigationBar_HEIGHT 44
#define Top_HEIGHT 64
#define Bottom_HEIGHT 59
#define LDWeakSelf(type)  __weak typeof(type) weak##type = type;
//每页加载
#define LoadingNumber 10

#define HTTPHOST @"http://myadmin.all-360.com:8080/Admin/AppApi/"
#define ImageUrl @"http://www.all-360.com"

#ifdef DEBUG
#define LDLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LDLog(...)
#endif

#endif /* QLPrefix_h */
