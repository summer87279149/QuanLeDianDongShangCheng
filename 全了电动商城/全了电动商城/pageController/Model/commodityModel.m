//
//  commodityModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/18.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "commodityModel.h"

@implementation commodityModel
+ (instancetype)getGoodsDetailsDataWithDic:(NSDictionary *)dic {
    return [[self alloc]initGoodsDataWithDic:dic];
}
- (instancetype)initGoodsDataWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID           = dic[@"id"];
        self.name         = dic[@"name"];
        self.zname        = dic[@"zname"];
        self.zhigoujia    = dic[@"zhigoujia"];
        self.off          = dic[@"off"];
        self.type         = dic[@"type"];
        self.danjia       = dic[@"danjia"];
        self.dangqishu    = dic[@"dangqishu"];
        self.suoluetu     = dic[@"suoluetu"];
        self.tupianji     = dic[@"tupianji"];
        self.neirong      = dic[@"neirong"];
        self.qianggou     = dic[@"qianggou"];
        self.yigou        = dic[@"yigou"];
        self.yungouxymdan = dic[@"yungouxymdan"];
        self.remain       = dic[@"remain"];
        self.makeup_price       = dic[@"makeup_price"];
        self.score_price       = dic[@"score_price"];
        
        /** 本期参与的用户信息 */
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
    }
    return self;
}
@end

