//
//  LDSeystemInfoModel.h
//  全了电动商城
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDSeystemInfoModel : NSObject
/** 标题 */
@property (strong,nonatomic) NSString *name;
/** 时间 */
@property (strong,nonatomic) NSString *atime;
/** ID */
@property (strong,nonatomic) NSString *myID;
/** 详情*/
@property (strong,nonatomic) NSString *neirong;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
