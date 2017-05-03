//
//  AftersalesModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/31.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AftersalesModel : NSObject
@property (nonatomic , strong)NSString *name;
@property (nonatomic , strong)NSString *address;
@property (nonatomic , strong)NSString *legal_name;
@property (nonatomic , strong)NSString *legal_tel;
@property (nonatomic , strong)NSString *shop_img;
@property (nonatomic , strong)NSString *business_license;
@property (nonatomic , strong)NSString *ID;

+ (instancetype)setDataModelWithDicL:(NSDictionary *)dic;
@end
