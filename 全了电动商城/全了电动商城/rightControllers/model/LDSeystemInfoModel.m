//
//  LDSeystemInfoModel.m
//  全了电动商城
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "LDSeystemInfoModel.h"

@implementation LDSeystemInfoModel
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    LDSeystemInfoModel *model=[[LDSeystemInfoModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"myID"];
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
@end
