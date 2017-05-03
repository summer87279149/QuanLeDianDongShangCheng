//
//  goodsDataModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/10.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "goodsDataModel.h"

@implementation goodsDataModel
+ (instancetype)setDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.zhigoujia = dic[@"zhigoujia"];
        self.danjia = dic[@"danjia"];
        self.qianggou = dic[@"qianggou"];
        self.yigou = dic[@"yigou"];
        self.suoluetu = dic[@"suoluetu"];
        self.ID = dic[@"id"];
        self.dangqishu = dic[@"dangqishu"];
        self.makeup_price  = dic[@"makeup_price"];
        self.score_price  = dic[@"score_price"];
    }
    return self;
}
@end
