//
//  allModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "allModel.h"

@implementation allModel
+ (instancetype)setAllDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDataDic:(NSDictionary *)dic];
}
- (instancetype)initWithDataDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.orderid = dic[@"orderid"];
        self.zongjia = dic[@"zongjia"];
        self.off = dic[@"off"];
        self.fahuooff = dic[@"fahuooff"];
    }
    return self;
}
@end
