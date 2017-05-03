//
//  LDUserInfo.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/24.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "LDUserInfo.h"
#import "Singleton.h"

@implementation LDUserInfo
singleton_implementation(LDUserInfo)

/** 保存用户信息 */
- (void)saveUsrtInfo {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    [defaults setObject:self.userName forKey:@"userName"];
    [defaults setObject:self.userPassword forKey:@"userPassword"];
    [defaults setBool:self.isLogin forKey:@"isLogin"];
    [defaults setBool:self.isLogin forKey:@"oldIsLogin"];
    [defaults setObject:self.ID forKey:@"userID"];
    [defaults synchronize];
}
/** 读取用户信息 */
- (void)readUserInfo {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    self.userName = [defaults objectForKey:@"userName"];
    self.userPassword = [defaults objectForKey:@"userPassword"];
    self.isLogin = [defaults boolForKey:@"isLogin"];
    self.isLogin = [defaults boolForKey:@"oldIsLogin"];
    self.ID = [defaults objectForKey:@"userID"];
    self.userIntegral = [defaults objectForKey:@"userID"];
}
@end
