//
//  LDUserInfo.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/24.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface LDUserInfo : NSObject
singleton_interface(LDUserInfo)

/** 用户名 */
@property (nonatomic , copy)NSString *userName;
/** 密码 */
@property (nonatomic , copy)NSString *userPassword;
/** 登录方式 */
@property (nonatomic , strong)NSString *loginType;
/** 判断是否登录 */
@property (nonatomic , assign)BOOL isLogin;
/** 判断以前是否登录过 */
@property (nonatomic , assign)BOOL oldIsLogin;
/** 用户ID */
@property (nonatomic , strong)NSString *ID;
/** 是否是微信登录 */
@property (nonatomic , strong)NSString *IsWeiRegister;
/** 是否为匿名登录 */
@property (nonatomic , strong)NSString  *IsAnonymous;
/** 用户的积分 */
@property (nonatomic , strong)NSString *userIntegral;

/** 保存用户信息 */
- (void)saveUsrtInfo;
/** 读取用户信息 */
- (void)readUserInfo;
@end
