//
//  sideslipArraysModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/25.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sideslipArraysModel : NSObject
@property (nonatomic , strong)NSString *ID;     //产品的ID
@property (nonatomic , strong)NSString *name;   //产品名称
@property (nonatomic , strong)NSNumber *type;   //产品分类?
@property (nonatomic , strong)NSString *icon;   //图片
@property (nonatomic , strong)NSArray  *child;  //2级分类
+ (instancetype)getLoadDataWithDic:(NSDictionary *)dic;
@end
