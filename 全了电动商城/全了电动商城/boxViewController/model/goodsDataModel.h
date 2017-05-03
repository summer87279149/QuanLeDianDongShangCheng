//
//  goodsDataModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/10.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodsDataModel : NSObject

/** 商品的ID */
@property (nonatomic , strong)NSString *ID;
/** 商品名称 */
@property (nonatomic , strong)NSString *name;
/** 第一次 在加入清单里用户选择的 商品的数量 */
@property (nonatomic , strong)NSString *shopsNum;
/** 全价 */
@property (nonatomic , strong)NSString *zhigoujia;
/** 夺宝单价 */
@property (nonatomic , strong)NSString *danjia;
/** 总需 */
@property (nonatomic , strong)NSString *qianggou;
/** 已经购买的 */
@property (nonatomic , strong)NSString *yigou;
/** 商品图片 */
@property (nonatomic , strong)NSString *suoluetu;
//状态值
@property (nonatomic , strong)NSString *status;
/** 产品期号 */
@property (nonatomic , strong)NSString *dangqishu;
/** 积分现金价格 */
@property (nonatomic , strong)NSString *makeup_price;
/** 所需要的积分 */
@property (nonatomic , strong)NSString *score_price;

+ (instancetype)setDataWithDic:(NSDictionary *)dic;

@end
