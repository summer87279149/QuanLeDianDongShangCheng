//
//  redBagModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/8.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "redBagModel.h"

@implementation redBagModel
+ (instancetype)setRedBagDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.haobaojine = dic[@"haobaojine"];
        self.shengyujine = dic[@"shengyujine"];
        self.dayukeyong = dic[@"dayukeyong"];
        self.atime = dic[@"atime"];
        self.gtime = dic[@"gtime"];
        self.syzt = dic[@"syzt"];
        self.stime = dic[@"stime"];
    }
    return self;
}
@end
