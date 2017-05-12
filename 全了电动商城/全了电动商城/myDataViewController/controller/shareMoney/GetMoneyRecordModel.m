//
//	GetMoneyRecordModel.m
//
//	Create by Admin on 9/5/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "GetMoneyRecordModel.h"

NSString *const kGetMoneyRecordModelAmount = @"amount";
NSString *const kGetMoneyRecordModelAtime = @"atime";
NSString *const kGetMoneyRecordModelXingming = @"xingming";

@interface GetMoneyRecordModel ()
@end
@implementation GetMoneyRecordModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kGetMoneyRecordModelAmount] isKindOfClass:[NSNull class]]){
		self.amount = dictionary[kGetMoneyRecordModelAmount];
	}	
	if(![dictionary[kGetMoneyRecordModelAtime] isKindOfClass:[NSNull class]]){
		self.atime = dictionary[kGetMoneyRecordModelAtime];
	}	
	if(![dictionary[kGetMoneyRecordModelXingming] isKindOfClass:[NSNull class]]){
		self.xingming = dictionary[kGetMoneyRecordModelXingming];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.amount != nil){
		dictionary[kGetMoneyRecordModelAmount] = self.amount;
	}
	if(self.atime != nil){
		dictionary[kGetMoneyRecordModelAtime] = self.atime;
	}
	if(self.xingming != nil){
		dictionary[kGetMoneyRecordModelXingming] = self.xingming;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.amount != nil){
		[aCoder encodeObject:self.amount forKey:kGetMoneyRecordModelAmount];
	}
	if(self.atime != nil){
		[aCoder encodeObject:self.atime forKey:kGetMoneyRecordModelAtime];
	}
	if(self.xingming != nil){
		[aCoder encodeObject:self.xingming forKey:kGetMoneyRecordModelXingming];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.amount = [aDecoder decodeObjectForKey:kGetMoneyRecordModelAmount];
	self.atime = [aDecoder decodeObjectForKey:kGetMoneyRecordModelAtime];
	self.xingming = [aDecoder decodeObjectForKey:kGetMoneyRecordModelXingming];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	GetMoneyRecordModel *copy = [GetMoneyRecordModel new];

	copy.amount = [self.amount copy];
	copy.atime = [self.atime copy];
	copy.xingming = [self.xingming copy];

	return copy;
}
@end