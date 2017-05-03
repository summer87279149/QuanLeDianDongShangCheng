//
//  commodityModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/2/18.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commodityModel : NSObject
/** 剩余商品的数量 */
@property (nonatomic , strong)NSString *remain;
/** 商品的ID */
@property (nonatomic, strong)NSString *ID;
/** 商品的名字 */
@property (nonatomic, strong)NSString *name;
/** 商品的描述 */
@property (nonatomic, strong)NSString *zname;
/** 商品的直购价 */
@property (nonatomic, strong)NSString *zhigoujia;
/** 商品的状态 */
@property (nonatomic, strong)NSString *off;
/** 商品的分类ID? */
@property (nonatomic, strong)NSString *type;
/** 商品的夺宝单价 */
@property (nonatomic, strong)NSString *danjia;
/** 商品的当前期数 */
@property (nonatomic, strong)NSString *dangqishu;
/** 商品的缩略图 */
@property (nonatomic, strong)NSString *suoluetu;
/** 商品的滚动视图(多个合起来) */
@property (nonatomic, strong)NSString *tupianji;
/** 商品的内容 */
@property (nonatomic, strong)NSString *neirong;
/** 商品夺宝总共需要的人次 */
@property (nonatomic, strong)NSString *qianggou;
/** 商品夺宝已经购买的人次 */
@property (nonatomic, strong)NSString *yigou;
/** 此商品现阶段参与的人的参与详情 */
@property (nonatomic, strong)NSArray *yungouxymdan;
/** 积分现金价格 */
@property (nonatomic , strong)NSString *makeup_price;
/** 所需要的积分 */
@property (nonatomic , strong)NSString *score_price;



/** 参与样式显示的cell模型 */


/** 用户的ID */
@property (nonatomic, strong)NSString *uid;
/** 用户购买的数量 */
@property (nonatomic, strong)NSString *shuliang;
/** 开奖的日期 */
@property (nonatomic, strong)NSString *stime;
/** 产品期数 */
@property (nonatomic, strong)NSString *cpqs;
/** 用户的IP */
@property (nonatomic, strong)NSString *ip;
/** 用户中奖的时间 */
@property (nonatomic, strong)NSString *zhongtime;
/** 用户中奖的号码 */
@property (nonatomic, strong)NSString *zhonghao;
/** 商品的ID */
@property (nonatomic, strong)NSString *cpid;
/** 用户的名字 */
@property (nonatomic, strong)NSString *uname;
/** 用户的头像 */
@property (nonatomic, strong)NSString *touxiang;

+ (instancetype)getGoodsDetailsDataWithDic:(NSDictionary *)dic;

@end
