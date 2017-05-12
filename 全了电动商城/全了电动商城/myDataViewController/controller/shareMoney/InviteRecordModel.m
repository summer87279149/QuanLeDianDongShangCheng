//
//	InviteRecordModel.m
//
//	Create by Admin on 9/5/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "InviteRecordModel.h"

NSString *const kInviteRecordModelAtime = @"atime";
NSString *const kInviteRecordModelLevel = @"level";
NSString *const kInviteRecordModelName = @"name";
NSString *const kInviteRecordModelResult = @"result";
NSString *const kInviteRecordModelUid = @"uid";

@interface InviteRecordModel ()
@end
@implementation InviteRecordModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kInviteRecordModelAtime] isKindOfClass:[NSNull class]]){
		self.atime = dictionary[kInviteRecordModelAtime];
	}	
	if(![dictionary[kInviteRecordModelLevel] isKindOfClass:[NSNull class]]){
		self.level = [dictionary[kInviteRecordModelLevel] integerValue];
	}

	if(![dictionary[kInviteRecordModelName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kInviteRecordModelName];
	}	
	if(![dictionary[kInviteRecordModelResult] isKindOfClass:[NSNull class]]){
		self.result = dictionary[kInviteRecordModelResult];
	}	
	if(![dictionary[kInviteRecordModelUid] isKindOfClass:[NSNull class]]){
		self.uid = dictionary[kInviteRecordModelUid];
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
		dictionary[kInviteRecordModelAtime] = self.atime;
	}
	dictionary[kInviteRecordModelLevel] = @(self.level);
	if(self.name != nil){
		dictionary[kInviteRecordModelName] = self.name;
	}
	if(self.result != nil){
		dictionary[kInviteRecordModelResult] = self.result;
	}
	if(self.uid != nil){
		dictionary[kInviteRecordModelUid] = self.uid;
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
		[aCoder encodeObject:self.atime forKey:kInviteRecordModelAtime];
	}
	[aCoder encodeObject:@(self.level) forKey:kInviteRecordModelLevel];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kInviteRecordModelName];
	}
	if(self.result != nil){
		[aCoder encodeObject:self.result forKey:kInviteRecordModelResult];
	}
	if(self.uid != nil){
		[aCoder encodeObject:self.uid forKey:kInviteRecordModelUid];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.atime = [aDecoder decodeObjectForKey:kInviteRecordModelAtime];
	self.level = [[aDecoder decodeObjectForKey:kInviteRecordModelLevel] integerValue];
	self.name = [aDecoder decodeObjectForKey:kInviteRecordModelName];
	self.result = [aDecoder decodeObjectForKey:kInviteRecordModelResult];
	self.uid = [aDecoder decodeObjectForKey:kInviteRecordModelUid];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	InviteRecordModel *copy = [InviteRecordModel new];

	copy.atime = [self.atime copy];
	copy.level = self.level;
	copy.name = [self.name copy];
	copy.result = [self.result copy];
	copy.uid = [self.uid copy];

	return copy;
}
@end