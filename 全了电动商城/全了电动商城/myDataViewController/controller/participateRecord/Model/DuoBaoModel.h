//
//  DuoBaoModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DuoBaoModel : NSObject
/** 名称 */
@property (nonatomic, strong)NSString *name;
/** 图片 */
@property (nonatomic, strong)NSString *suoluetu;
/** 参与次数 */
@property (nonatomic, strong)NSString *yigou;
/** 中奖号码 */
@property (nonatomic, strong)NSString *zhonghao;
/** 已购状态(是否开奖 还是  进行中) */
@property (nonatomic, strong)NSString *ztmc;
/** 日期 */
@property (nonatomic, strong)NSString *stime;
+ (instancetype)setDuoBaoDataWithDic:(NSDictionary *)dic;
@end
