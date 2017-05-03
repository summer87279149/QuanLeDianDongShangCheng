//
//  personal.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/2.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface personal : NSObject
/** ID */
@property (nonatomic, strong)NSString *uid;
/** 用户的昵称 */
@property (nonatomic, strong)NSString *name;
/** 用户的手机号码 */
@property (nonatomic, strong)NSString *shouji;
/** 用户的金额 */
@property (nonatomic, strong)NSString *jine;
/** 用户的积分 */
@property (nonatomic, strong)NSString *jifen;
/** 用户的头像 */
@property (nonatomic, strong)NSString *touxiang;
/** 用户的推存码 */
@property (nonatomic, strong)NSString *tuid;

+ (instancetype)setPersonalDataWithDic:(NSDictionary *)dic;
@end
