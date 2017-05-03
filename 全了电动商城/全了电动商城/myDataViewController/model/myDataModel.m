//
//  myDataModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/6.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "myDataModel.h"

@implementation myDataModel
+ (instancetype)setMyDatasWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.shouji = dic[@"shouji"];
        self.jine = dic[@"jine"];
        self.uid = dic[@"uid"];
        self.jifen = dic[@"jifen"];
        self.touxiang = dic[@"touxiang"];
        self.tuid = dic[@"tuid"];
    }
    return self;
}


@end
