//
//  adressViewController.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^callBack)(NSString *addid,NSString *addressDetail);

@interface adressViewController : UIViewController
@property (nonatomic , strong)NSString *userId;
@property (nonatomic, copy) callBack callback;
@end
