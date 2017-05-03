//
//  DBSourceDataModel.h
//  LFAutoListCell
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 baixinxueche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBSourceDataModel : NSObject

/** section title */
@property (strong,nonatomic) NSString *name;
/** type */
@property (strong,nonatomic) NSString *type;
/** ID */
@property (strong,nonatomic) NSString *myID;
/** child */
@property (strong,nonatomic) NSArray *child;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
