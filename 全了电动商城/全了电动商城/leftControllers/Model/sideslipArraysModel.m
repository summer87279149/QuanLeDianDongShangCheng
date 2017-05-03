//
//  sideslipArraysModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/25.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "sideslipArraysModel.h"

@implementation sideslipArraysModel
+ (instancetype)getLoadDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithLoadWithDic:dic];
}
- (instancetype)initWithLoadWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = dic[@"id"];
        self.name = dic[@"name"];
        self.type = dic[@"type"];
        self.icon = dic[@"icon"];
        self.child = dic[@"child"];
    }
    return self;
}
@end
