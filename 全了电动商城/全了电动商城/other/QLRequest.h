//
//  QLRequest.h
//  全了电动商城
//
//  Created by Admin on 2017/5/4.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "BaseRequestManager.h"

@interface QLRequest : BaseRequestManager

//提交订单，订单入库
+(void)orderRuKuWithPara:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error;
// 订单加入购物车
+(void)submitOrder:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error;
//查询购物车
+(void)queryCarList:(NSString*)uid success:(Success)xt_success error:(Error)xt_error;
//删除购物车项目
+(void)deleteCarItem:(NSString*)uid carID:(NSString*)carid success:(Success)xt_success error:(Error)xt_error;
//查询总价
+(void)totalPrice:(NSString*)uid success:(Success)xt_success error:(Error)xt_error;

/**
    购物车数量编辑
 @param carid 购物车id
 @param type +代表增，-代表减
 */
+(void)carNumbersEdit:(NSString*)carid type:(NSString*)type success:(Success)xt_success error:(Error)xt_error;
@end
