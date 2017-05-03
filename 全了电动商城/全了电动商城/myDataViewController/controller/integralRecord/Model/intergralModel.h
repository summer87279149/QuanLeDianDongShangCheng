//
//  intergralModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface intergralModel : NSObject

/** 返回的积分 */
@property (nonatomic, strong)NSString *jifen;
/** 时间 */
@property (nonatomic, strong)NSString *atime;
+ (instancetype)setIntergralDataWithDic:(NSDictionary *)dic;
@end
