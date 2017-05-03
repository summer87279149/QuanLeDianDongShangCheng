//
//  orderReadModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderReadModel : NSObject
/** 描述 */
@property (nonatomic, strong)NSString *miaoshu;
/** 晒单图片 */
@property (nonatomic, strong)NSString *suoluetu;
/** 中奖号码 */
@property (nonatomic, strong)NSString *zhonghao;
/** 晒单时间 */
@property (nonatomic, strong)NSString *atime;
/** 分类 */
@property (nonatomic, strong)NSString *type;
/** 用户UID */
@property (nonatomic, strong)NSString *uid;
/** 用户昵称 */
@property (nonatomic, strong)NSString *username;
/** 用户头像 */
@property (nonatomic, strong)NSString *touxiang;
/** 商品ID */
@property (nonatomic, strong)NSString *cpid;
/** 产品期号 */
@property (nonatomic, strong)NSString *qihao;
/** 商品名称 */
@property (nonatomic, strong)NSString *cp_name;
/** 商品缩略图 */
@property (nonatomic, strong)NSString *cp_suoluetu;

+ (instancetype)setDataWithDic:(NSDictionary *)dic;
@end
