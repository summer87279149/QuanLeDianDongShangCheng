//
//  pageGoodsModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pageGoodsModel : NSObject
/** 产品的ID */
@property (nonatomic , strong)NSString *ID;
/** 产品的名称 */
@property (nonatomic , strong)NSString *name;
/** 产品的状态 3种 */
@property (nonatomic , strong)NSString *off;
/** 单价 */
@property (nonatomic , strong)NSString *danjia;
/** 已经购买的人数 */
@property (nonatomic , strong)NSString *yigou;
/** 剩余人数 */
@property (nonatomic , strong)NSNumber *remain;
/** 缩略图片 */
@property (nonatomic , strong)NSString *suoluetu;
/** 排序 */
@property (nonatomic , strong)NSString *renqi;
/** 商品分类 */
@property (nonatomic , strong)NSString *type;
/** 直购价 */
@property (nonatomic, strong)NSString *zhigoujia;
/** 总的数量 */
@property (nonatomic, strong)NSString *qianggou;
/** 积分现金价格 */
@property (nonatomic , strong)NSString *makeup_price;
/** 所需要的积分 */
@property (nonatomic , strong)NSString *score_price;

+ (instancetype)getLoadDataWithDic:(NSDictionary *)dic;

// 最贵
- (NSComparisonResult)compareZhigoujiaDa:(pageGoodsModel *)other;
//最便宜
- (NSComparisonResult)compareZhigoujiaXiao:(pageGoodsModel *)other;
// 最新
- (NSComparisonResult)compareID:(pageGoodsModel *)other;
//人气
- (NSComparisonResult)compareReQi:(pageGoodsModel *)other;
@end
