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
+(void)shareSuccess:(Success)xt_success error:(Error)xt_error{
   LDUserInfo* user = [LDUserInfo sharedLDUserInfo];
    [user readUserInfo];
    if (user.ID) {
        [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/qrCode") parameters:@{@"uid":user.ID} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
            xt_success(responseObject);
        } failure:^(NSError *error) {
            xt_error(error);
        }]; 
    }
    
}
+(void)submitOrder:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/shopCart") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)queryCarList:(NSString*)uid success:(Success)xt_success error:(Error)xt_error{
    NSString *str = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/shopCartList/uid/%@",uid];
    [XTRequestManager GET:str parameters:nil responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)deleteCarItem:(NSString*)uid carID:(NSString*)carid success:(Success)xt_success error:(Error)xt_error{
    NSString *str = XT_REQUEST_URL(@"/Admin/AppApi/shopCartDel");
    NSString *paraStr = [NSString stringWithFormat:@"/uid/%@/id/%@",uid,carid];
    NSString *URLString = [str stringByAppendingString:paraStr];
    [XTRequestManager GET:URLString parameters:nil responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
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
+(void)inviteRecordSuccess:(Success)xt_success error:(Error)xt_error{
    LDUserInfo* user = [LDUserInfo sharedLDUserInfo];
    [user readUserInfo];
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/invitation") parameters:@{@"uid":user.ID} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)getMoneyRecordSuccess:(Success)xt_success error:(Error)xt_error{
    LDUserInfo* user = [LDUserInfo sharedLDUserInfo];
    [user readUserInfo];
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/tiXian") parameters:@{@"uid":user.ID} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)yongjinRecordSuccess:(Success)xt_success error:(Error)xt_error{
    LDUserInfo* user = [LDUserInfo sharedLDUserInfo];
    [user readUserInfo];
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/commission") parameters:@{@"uid":user.ID} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)getMyListMoneySuccess:(Success)xt_success error:(Error)xt_error{
    LDUserInfo* user = [LDUserInfo sharedLDUserInfo];
    [user readUserInfo];
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/tiXianTotal") parameters:@{@"uid":user.ID} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)getMoneyTypeSuccess:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/Admin/AppApi/payMethod") parameters:nil responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)submitGetMoneyWithPara:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager POSTJSON:XT_REQUEST_URL(@"/Admin/AppApi/monetOut") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
@end
