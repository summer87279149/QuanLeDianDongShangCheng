//
//  discloseDataModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/1.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "discloseDataModel.h"

@implementation discloseDataModel
+ (instancetype)setDiscloseDataModel:(NSDictionary *)dic {
    return [[self alloc]initWithDataDic:dic];
}
- (instancetype)initWithDataDic:(NSDictionary *)dic {
    if (self = [super init]) {
         self.uid = dic[@"uid"];
         self.uname = dic[@"uname"];
         self.zhongtime = dic[@"zhongtime"];
         self.zhonghao = dic[@"zhonghao"];
         self.cpqs = dic[@"cpqs"];
         self.suoluetu = dic[@"suoluetu"];
         self.cpid = dic[@"cpid"];
         self.cpname = dic[@"cpname"];
         self.yigou = dic[@"yigou"];
    }
    return self;
}

@end
