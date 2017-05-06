//
//  BaseRequestManager.h
//  全了电动商城
//
//  Created by Admin on 2017/5/4.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id response);
typedef void(^Error) (id response);
#define XT_BASEURL @"http://myadmin.all-360.com:8080%@"
#define XT_REQUEST_URL(url)  [NSString stringWithFormat:XT_BASEURL,url]

@interface BaseRequestManager : NSObject

@end
