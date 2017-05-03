//
//  pageGoodsModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "pageGoodsModel.h"

@implementation pageGoodsModel

+ (instancetype)getLoadDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID        = dic[@"id"];
        self.name      = dic[@"name"];
        self.off       = dic[@"off"];
        self.danjia    = dic[@"danjia"];
        self.yigou     = dic[@"yigou"];
        self.remain    = dic[@"remain"];
        self.suoluetu  = dic[@"suoluetu"];
        self.renqi     = dic[@"renqi"];
        self.type      = dic[@"type"];
        self.zhigoujia = dic[@"zhigoujia"];
        self.qianggou  = dic[@"qianggou"];
        self.makeup_price  = dic[@"makeup_price"];
        self.score_price  = dic[@"score_price"];
    }
    return self;
}

- (NSComparisonResult)compareZhigoujiaDa:(pageGoodsModel *)other {
    //前面小于后面 返回降序
    if([self.zhigoujia integerValue] < [other.zhigoujia integerValue]) {
        return NSOrderedDescending;
        //返回降序
    } else if([self.zhigoujia integerValue] > [other.zhigoujia integerValue]) {
        return NSOrderedAscending;
    } else {
        //相等就不变
        return NSOrderedSame;
    }
}
- (NSComparisonResult)compareZhigoujiaXiao:(pageGoodsModel *)other {
    //前面小于后面 返回升序
    if([self.zhigoujia integerValue] < [other.zhigoujia integerValue]) {
        return NSOrderedAscending;
        //返回降序
    } else if([self.zhigoujia integerValue] > [other.zhigoujia integerValue]) {
        return NSOrderedDescending;
    } else {
        //相等就不变
        return NSOrderedSame;
    }
}
// 最新
- (NSComparisonResult)compareID:(pageGoodsModel *)other {
    //前面小于后面 返回降序
    if([self.ID integerValue] < [other.ID integerValue]) {
        return NSOrderedDescending;
        //返回降序
    } else if([self.ID integerValue] > [other.ID integerValue]) {
        return NSOrderedAscending;
    } else {
        //相等就不变
        return NSOrderedSame;
    }
}
//人气
- (NSComparisonResult)compareReQi:(pageGoodsModel *)other {
    //前面小于后面 返回降序
    if([self.renqi integerValue] < [other.renqi integerValue]) {
        return NSOrderedDescending;
        //返回降序
    } else if([self.renqi integerValue] > [other.renqi integerValue]) {
        return NSOrderedAscending;
    } else {
        //相等就不变
        return NSOrderedSame;
    }
}














@end
