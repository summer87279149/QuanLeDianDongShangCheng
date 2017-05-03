//
//  oldAnnouncedModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/22.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface oldAnnouncedModel : NSObject
/** 用户的ID */
@property (nonatomic, strong)NSString *uid;
/** 购买的数量 */
@property (nonatomic, strong)NSString *shuliang;
/** 提交的时间 */
@property (nonatomic, strong)NSString *stime;
/** 产品期号 */
@property (nonatomic, strong)NSString *cpqs;
/** 用户的IP */
@property (nonatomic, strong)NSString *ip;
/** 中奖的时间 */
@property (nonatomic, strong)NSString *zhongtime;
/** 中奖的号码 */
@property (nonatomic, strong)NSString *zhonghao;
/** 商品的ID */
@property (nonatomic, strong)NSString *cpid;
/** 用户昵称 */
@property (nonatomic, strong)NSString *uname;
/** 用户头像 */
@property (nonatomic, strong)NSString *touxiang;
/** 参与的人次 */
@property (nonatomic, strong)NSString *yigou;
+ (instancetype)setOldDataWithDic:(NSDictionary *)dic;
@end
