//
//  winningModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/18.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface winningModel : NSObject
/** 无用序号 */
@property (nonatomic, strong)NSString *ID;
/** 标题 */
@property (nonatomic, strong)NSString *name;
/** 用户的晒带语言 */
@property (nonatomic, strong)NSString *miaoshu;
/** 晒单的图片 */
@property (nonatomic, strong)NSString *suoluetu;
/** 用户的ID */
@property (nonatomic, strong)NSString *uid;
/** 中奖号码 */
@property (nonatomic, strong)NSString *zhonghao;
/** 分类ID 不懂? */
@property (nonatomic, strong)NSString *type;
/** 晒单时间 */
@property (nonatomic, strong)NSString *atime;
/** 商品的名字 */
@property (nonatomic, strong)NSString *cp_name;
/** 商品的缩略图 */
@property (nonatomic, strong)NSString *cp_suoluetu;
/** 用户的名称 */
@property (nonatomic, strong)NSString *username;
/** 用户的头像 */
@property (nonatomic, strong)NSString *touxiang;
/** 产品的ID */
@property (nonatomic, strong)NSString *cpid;
/** 期号 */
@property (nonatomic, strong)NSString *qihao;
/** 已购 */
@property (nonatomic, strong)NSString *yigou;
/** 中奖的时间 */
@property (nonatomic, strong)NSString *zhongtime;
+ (instancetype)setWinningDataWithDic:(NSDictionary *)dic;
@end

