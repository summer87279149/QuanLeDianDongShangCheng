//
//  luckModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "luckModel.h"

@implementation luckModel
+ (instancetype)setLuckDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDataDic:(NSDictionary *)dic];
}
- (instancetype)initWithDataDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.suoluetu = dic[@"suoluetu"];
        self.zhongtime = dic[@"zhongtime"];
        self.zhonghao = dic[@"zhonghao"];
        self.cpqs = dic[@"cpqs"];
        self.ID = dic[@"id"];
    }
    return self;
}
@end
