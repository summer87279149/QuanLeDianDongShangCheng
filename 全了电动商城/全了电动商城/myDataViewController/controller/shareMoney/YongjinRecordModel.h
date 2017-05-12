//
//	YongjinRecordModel.h
//
//	Create by Admin on 9/5/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface YongjinRecordModel : NSObject

@property (nonatomic, strong) NSString * atime;
@property (nonatomic, strong) NSString * data;
@property (nonatomic, strong) NSString * huobi;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * uid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end