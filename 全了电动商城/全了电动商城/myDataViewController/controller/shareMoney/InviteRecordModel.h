//
//	InviteRecordModel.h
//
//	Create by Admin on 9/5/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface InviteRecordModel : NSObject

@property (nonatomic, strong) NSString * atime;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * result;
@property (nonatomic, strong) NSString * uid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end