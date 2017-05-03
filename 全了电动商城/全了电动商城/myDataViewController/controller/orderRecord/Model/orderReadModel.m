//
//  orderReadModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "orderReadModel.h"

@implementation orderReadModel
+ (instancetype)setDataWithDic:(NSDictionary *)dic {
    return  [[self alloc]initWithDic:(NSDictionary *)dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.miaoshu = dic[@"miaoshu"];
        self.suoluetu = dic[@"suoluetu"];
        self.zhonghao = dic[@"zhonghao"];
        self.atime = dic[@"atime"];
        self.type = dic[@"type"];
        self.uid = dic[@"uid"];
        self.touxiang = dic[@"touxiang"];
        self.cpid = dic[@"cpid"];
        self.qihao = dic[@"qihao"];
        self.cp_name = dic[@"cp_name"];
        self.cp_suoluetu = dic[@"cp_suoluetu"];
    }
    return self;
}

@end

