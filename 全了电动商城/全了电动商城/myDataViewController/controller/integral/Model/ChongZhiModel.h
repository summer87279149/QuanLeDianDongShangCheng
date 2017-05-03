//
//  ChongZhiModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChongZhiModel : NSObject
/** 金额 */
@property (nonatomic, strong)NSString *amount;
/** 时间 */
@property (nonatomic, strong)NSString *atime;
+ (instancetype)setIntergralWithDic:(NSDictionary *)dic;
@end
