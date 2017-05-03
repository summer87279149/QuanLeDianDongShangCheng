//
//  myDataModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/6.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myDataModel : NSObject
/** 姓名 */
@property (nonatomic, strong)NSString *name;
/** 手机号码 */
@property (nonatomic, strong)NSString *shouji;
/** 用户金额 */
@property (nonatomic, strong)NSString *jine;
/** ID */
@property (nonatomic, strong)NSString *uid;
/** 积分 */
@property (nonatomic, strong)NSString *jifen;
/** 头像 */
@property (nonatomic, strong)NSString *touxiang;
/** 推存码 */
@property (nonatomic, strong)NSString *tuid;
+ (instancetype)setMyDatasWithDic:(NSDictionary *)dic;
@end
