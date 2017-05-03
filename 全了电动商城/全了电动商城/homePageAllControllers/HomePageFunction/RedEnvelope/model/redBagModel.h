//
//  redBagModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/8.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface redBagModel : NSObject
@property (nonatomic , strong)NSString *haobaojine;//红包金额
@property (nonatomic , strong)NSString *shengyujine;//红包剩余金额
@property (nonatomic , strong)NSString *dayukeyong;//红包大于多少消耗可用
@property (nonatomic , strong)NSString *atime;//红包生成时间
@property (nonatomic , strong)NSString *gtime;//过期时间备用
@property (nonatomic , strong)NSString *syzt;//使用状态
@property (nonatomic , strong)NSString *stime;//红包使用时间

+ (instancetype)setRedBagDataWithDic:(NSDictionary *)dic;
@end
