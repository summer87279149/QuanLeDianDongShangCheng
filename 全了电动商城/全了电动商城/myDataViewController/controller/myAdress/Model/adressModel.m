//
//  adressModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/9.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "adressModel.h"

@implementation adressModel
+ (instancetype)setAdressDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDataDic:dic];
}
- (instancetype)initWithDataDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.uid = dic[@"uid"];
        self.beizhu = dic[@"beizhu"];
        self.xingming = dic[@"xingming"];
        self.shouji = dic[@"shouji"];
        self.addressID = dic[@"id"];
    }
    return self;
}
@end
