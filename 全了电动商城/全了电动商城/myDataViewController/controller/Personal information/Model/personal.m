//
//  personal.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/2.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "personal.h"

@implementation personal
+ (instancetype)setPersonalDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.uid = dic[@"uid"];
        self.name = dic[@"name"];
        self.shouji = dic[@"shouji"];
        self.jine = dic[@"jine"];
        self.jifen = dic[@"jifen"];
        self.touxiang = dic[@"touxiang"];
        self.tuid = dic[@"tuid"];
    }
    return self;
}
@end
