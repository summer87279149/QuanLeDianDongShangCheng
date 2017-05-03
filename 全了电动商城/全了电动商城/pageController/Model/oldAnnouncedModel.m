//
//  oldAnnouncedModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/22.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "oldAnnouncedModel.h"

@implementation oldAnnouncedModel
+ (instancetype)setOldDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.uid = dic[@"uid"];
        self.shuliang = dic[@"shuliang"];
        self.stime = dic[@"stime"];
        self.cpqs = dic[@"cpqs"];
        self.ip = dic[@"ip"];
        self.zhongtime = dic[@"zhongtime"];
        self.zhonghao = dic[@"zhonghao"];
        self.cpid = dic[@"cpid"];
        self.uname = dic[@"uname"];
        self.touxiang = dic[@"touxiang"];
        self.yigou = dic[@"yigou"];
    }
    return self;
}
@end
