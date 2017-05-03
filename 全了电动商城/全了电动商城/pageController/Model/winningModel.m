//
//  winningModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/18.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "winningModel.h"

@implementation winningModel
+ (instancetype)setWinningDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = dic[@"id"];
        self.name = dic[@"name"];
        self.miaoshu = dic[@"miaoshu"];
        self.suoluetu = dic[@"suoluetu"];
        self.uid = dic[@"uid"];
        self.zhonghao = dic[@"zhonghao"];
        self.type = dic[@"type"];
        self.atime = dic[@"atime"];
        self.cp_name = dic[@"cp_name"];
        self.cp_suoluetu = dic[@"cp_suoluetu"];
        self.username = dic[@"username"];
        self.touxiang = dic[@"touxiang"];
        self.cpid = dic[@"cpid"];
        self.qihao = dic[@"qihao"];
        self.yigou = dic[@"yigou"];
        self.zhongtime = dic[@"zhongtime"];
    }
    return self;
}
@end
