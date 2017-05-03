//
//  allModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface allModel : NSObject
/** 单号 */
@property (nonatomic, strong)NSString *orderid;
/** 总价 */
@property (nonatomic, strong)NSString *zongjia;
/** 订单状态 */
@property (nonatomic, strong)NSString *off;
/** 发货状态 */
@property (nonatomic, strong)NSString *fahuooff;
+ (instancetype)setAllDataWithDic:(NSDictionary *)dic;
@end
