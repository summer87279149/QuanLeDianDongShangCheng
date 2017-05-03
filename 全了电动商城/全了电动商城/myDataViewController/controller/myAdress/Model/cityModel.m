//
//  cityModel.m
//  地址
//
//  Created by 懒洋洋 on 2017/3/13.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "cityModel.h"

@implementation cityModel
+ (instancetype)setCityDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = dic[@"id"];
        self.cityName = dic[@"name"];
        self.diqu = dic[@"diqu"];
        self.shangji = dic[@"shangji"];
    }
    return self;
}
@end
