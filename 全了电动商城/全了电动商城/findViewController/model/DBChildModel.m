//
//  DBChildModel.m
//  LFAutoListCell
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 baixinxueche. All rights reserved.
//

#import "DBChildModel.h"

@implementation DBChildModel
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    DBChildModel *model=[[DBChildModel alloc]init];
    model.name    = dict[@"name"];
    model.type    = dict[@"type"];
    model.myID    = dict[@"id"];
    model.child   = dict[@"child"];
    return model;
}
@end
