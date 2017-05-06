//
//  QLRequest.m
//  全了电动商城
//
//  Created by Admin on 2017/5/4.
//  Copyright © 2017年 亮点网络. All rights reserved.
//
#import "XTRequestManager.h"
#import "QLRequest.h"

@implementation QLRequest
+(void)orderRuKuWithPara:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager POSTJSON:XT_REQUEST_URL(@"/Admin/AppApi/orderHandle") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
         xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)submitOrder:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/shopCart") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)queryCarList:(NSString*)uid success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/shopCartList") parameters:@{@"uid":uid} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)deleteCarItem:(NSString*)uid carID:(NSString*)carid success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/shopCartDel") parameters:@{@"uid":uid,@"id":carid} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)totalPrice:(NSString*)uid success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/shopCartTotal") parameters:@{@"uid":uid} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)carNumbersEdit:(NSString*)carid type:(NSString*)type success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/shopCartEdit") parameters:@{@"id":carid,@"type":type} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
@end
