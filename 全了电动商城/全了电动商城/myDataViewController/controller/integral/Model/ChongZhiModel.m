//
//  ChongZhiModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "ChongZhiModel.h"

@implementation ChongZhiModel
+ (instancetype)setIntergralWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.amount = dic[@"amount"];
        self.atime = dic[@"atime"];
    }
    return self;
}
@end
