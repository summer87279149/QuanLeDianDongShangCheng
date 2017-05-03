//
//  oldAnnouncedViewController.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/6.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface oldAnnouncedViewController : UIViewController
/** 前一个商品传入的id */
@property (nonatomic , assign)int identi;
@property (nonatomic , strong)NSString *indentif;
/** 产品期号 */
@property (nonatomic, assign)int dateNum;
@property (nonatomic ,strong)NSString *date;
@end
