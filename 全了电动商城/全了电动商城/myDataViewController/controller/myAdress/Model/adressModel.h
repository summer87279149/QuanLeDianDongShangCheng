//
//  adressModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/9.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adressModel : NSObject
/** 用户ID */
@property (nonatomic, strong)NSString *uid;
/** 详细地址 */
@property (nonatomic, strong)NSString *beizhu;
/** 手机号码 */
@property (nonatomic, strong)NSString *shouji;
/** 名字 */
@property (nonatomic, strong)NSString *xingming;
//地址id
@property (nonatomic, strong)NSString *addressID;

+ (instancetype)setAdressDataWithDic:(NSDictionary *)dic;

@end
