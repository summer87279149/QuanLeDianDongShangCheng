//
//  DBSourceDataModel.m
//  LFAutoListCell
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 baixinxueche. All rights reserved.
//

#import "DBSourceDataModel.h"
#import "DBChildModel.h"

@implementation DBSourceDataModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    DBSourceDataModel *model=[[DBSourceDataModel alloc]init];
    model.name = dict[@"name"];
    model.type = dict[@"type"];
    model.myID = dict[@"id"];
    NSMutableArray *MArr = [NSMutableArray array];
    for (NSDictionary* dic in dict[@"child"]) {
        DBSourceDataModel* model = [[DBSourceDataModel alloc] initWithDictionary:dic];
        [MArr addObject:model];
    }
    model.child = [MArr mutableCopy];
    
    
    return model;
}
//-(void)setValue:(id)value forKey:(NSString *)key
//{
//    [super setValue:value forKey:key];
//    if ([key isEqualToString:@"id"]) {
//        [self setValue:value forKey:@"myID"];
//    }
//}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

@end
