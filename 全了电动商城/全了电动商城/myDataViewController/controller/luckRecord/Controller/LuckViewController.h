//
//  LuckViewController.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock)(NSString *shopName,NSString *cpid,NSString *qihao,NSString *zhonghao);

@interface LuckViewController : UIViewController

@property (nonatomic , strong)NSString *userID;

@property(nonatomic , copy) myBlock block;

@end
