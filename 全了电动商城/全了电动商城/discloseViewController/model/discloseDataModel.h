//
//  discloseDataModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/1.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface discloseDataModel : NSObject
/** 用户UID */
@property (nonatomic, strong)NSString *uid;
/** 用户的姓名 */
@property (nonatomic, strong)NSString *uname;
/** 中奖的时间 */
@property (nonatomic, strong)NSString *zhongtime;
/** 中奖的号码 */
@property (nonatomic, strong)NSString *zhonghao;
/** 产品期号 */
@property (nonatomic, strong)NSString *cpqs;
/** 产品的缩略图 */
@property (nonatomic, strong)NSString *suoluetu;
/** 产品的ID */
@property (nonatomic, strong)NSString *cpid;
/** 产品的名称 */
@property (nonatomic, strong)NSString *cpname;
/** 用户已经购买的数量 */
@property (nonatomic, strong)NSString *yigou;
+ (instancetype)setDiscloseDataModel:(NSDictionary *)dic;
@end
