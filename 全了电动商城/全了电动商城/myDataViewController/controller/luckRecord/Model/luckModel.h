//
//  luckModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface luckModel : NSObject
/** 名称 */
@property (nonatomic, strong)NSString *name;
/** 图片 */
@property (nonatomic, strong)NSString *suoluetu;
/** 中奖号码 */
@property (nonatomic, strong)NSString *zhonghao;
/** 日期 */
@property (nonatomic, strong)NSString *zhongtime;
/** 产品期号 */
@property (nonatomic, strong)NSString *cpqs;
/** 产品ID */
@property (nonatomic, strong)NSString *ID;
+ (instancetype)setLuckDataWithDic:(NSDictionary *)dic;
@end
