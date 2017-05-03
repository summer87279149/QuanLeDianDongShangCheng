//
//  cityModel.h
//  地址
//
//  Created by 懒洋洋 on 2017/3/13.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cityModel : NSObject
@property (nonatomic , strong)NSString *ID;
@property (nonatomic , strong)NSString *cityName;
@property (nonatomic , strong)NSString *diqu;
@property (nonatomic , strong)NSString *shangji;
+ (instancetype)setCityDataWithDic:(NSDictionary *)dic;
@end
