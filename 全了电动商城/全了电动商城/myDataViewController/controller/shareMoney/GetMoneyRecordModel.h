//
//	GetMoneyRecordModel.h
//
//	Create by Admin on 9/5/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface GetMoneyRecordModel : NSObject

@property (nonatomic, strong) NSString * amount;
@property (nonatomic, strong) NSString * atime;
@property (nonatomic, strong) NSString * xingming;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end