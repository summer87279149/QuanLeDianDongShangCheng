//
//	YongjinRecordModel.m
//
//	Create by Admin on 9/5/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "YongjinRecordModel.h"

NSString *const kYongjinRecordModelAtime = @"atime";
NSString *const kYongjinRecordModelData = @"data";
NSString *const kYongjinRecordModelHuobi = @"huobi";
NSString *const kYongjinRecordModelType = @"type";
NSString *const kYongjinRecordModelUid = @"uid";

@interface YongjinRecordModel ()
@end
@implementation YongjinRecordModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kYongjinRecordModelAtime] isKindOfClass:[NSNull class]]){
		self.atime = dictionary[kYongjinRecordModelAtime];
	}	
	if(![dictionary[kYongjinRecordModelData] isKindOfClass:[NSNull class]]){
		self.data = dictionary[kYongjinRecordModelData];
	}	
	if(![dictionary[kYongjinRecordModelHuobi] isKindOfClass:[NSNull class]]){
		self.huobi = dictionary[kYongjinRecordModelHuobi];
	}	
	if(![dictionary[kYongjinRecordModelType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kYongjinRecordModelType];
	}	
	if(![dictionary[kYongjinRecordModelUid] isKindOfClass:[NSNull class]]){
		self.uid = dictionary[kYongjinRecordModelUid];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.atime != nil){
		dictionary[kYongjinRecordModelAtime] = self.atime;
	}
	if(self.data != nil){
		dictionary[kYongjinRecordModelData] = self.data;
	}
	if(self.huobi != nil){
		dictionary[kYongjinRecordModelHuobi] = self.huobi;
	}
	if(self.type != nil){
		dictionary[kYongjinRecordModelType] = self.type;
	}
	if(self.uid != nil){
		dictionary[kYongjinRecordModelUid] = self.uid;
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
	if(self.atime != nil){
		[aCoder encodeObject:self.atime forKey:kYongjinRecordModelAtime];
	}
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kYongjinRecordModelData];
	}
	if(self.huobi != nil){
		[aCoder encodeObject:self.huobi forKey:kYongjinRecordModelHuobi];
	}
	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kYongjinRecordModelType];
	}
	if(self.uid != nil){
		[aCoder encodeObject:self.uid forKey:kYongjinRecordModelUid];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.atime = [aDecoder decodeObjectForKey:kYongjinRecordModelAtime];
	self.data = [aDecoder decodeObjectForKey:kYongjinRecordModelData];
	self.huobi = [aDecoder decodeObjectForKey:kYongjinRecordModelHuobi];
	self.type = [aDecoder decodeObjectForKey:kYongjinRecordModelType];
	self.uid = [aDecoder decodeObjectForKey:kYongjinRecordModelUid];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	YongjinRecordModel *copy = [YongjinRecordModel new];

	copy.atime = [self.atime copy];
	copy.data = [self.data copy];
	copy.huobi = [self.huobi copy];
	copy.type = [self.type copy];
	copy.uid = [self.uid copy];

	return copy;
}
@end