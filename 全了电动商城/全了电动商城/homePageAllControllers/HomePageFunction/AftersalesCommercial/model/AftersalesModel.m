//
//  AftersalesModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/31.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "AftersalesModel.h"

@implementation AftersalesModel
+ (instancetype)setDataModelWithDicL:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name        = dic[@"name"];
        self.address      = dic[@"address"];
        self.legal_name       = dic[@"legal_name"];
        self.legal_tel    = dic[@"legal_tel"];
        self.shop_img     = dic[@"shop_img"];
        self.business_license    = dic[@"business_license"];
        self.ID  = dic[@"id"];
       
    }
    return self;
}










@end
