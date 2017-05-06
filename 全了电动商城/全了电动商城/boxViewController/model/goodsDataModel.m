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
        self.ID = dic[@"id"];
        self.cpid = dic[@"cpid"];
        self.name = dic[@"name"];
        self.shopsNum = dic[@"num"];
        self.danjia = dic[@"danjia"];
        self.status = dic[@"chutype"];
        self.totalPrice = dic[@"zongjia"];
        self.suoluetu = dic[@"suoluetu"];
        self.dangqishu = dic[@"dangqishu"];
        self.yigou = dic[@"yigou"];
        self.score_price  = dic[@"jifen"];
        self.qianggou = dic[@"qianggou"];
        self.zhigoujia = dic[@"zongjia"];
//        self.makeup_price  = dic[@"makeup_price"];
        
    }
    return self;
}
@end
