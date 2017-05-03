//
//  MD5Str.h
//  UIPickerView
//
//  Created by 懒洋洋 on 2017/3/15.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Str : NSObject

+(NSString *)md5String:(NSString *)sourceString;//md5字符串加密
+(NSString *)md5Data:(NSData *)sourceData;//md5data加密
+(NSString *)base64EncodingWithData:(NSData *)sourceData;//base64加密
+(id)base64EncodingWithString:(NSString *)sourceString;//base64解密

@end
