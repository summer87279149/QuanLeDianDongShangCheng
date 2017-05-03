//
//  commodityHeadView.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commodityModel.h"

@interface commodityHeadView : UIView
/** 状态标示 */
@property (nonatomic , assign)int statusNum;
/** 接收图片集信息 滚动视图几张图片 */
@property (nonatomic , strong)NSString *allImages;
/** 商品的当前期数 */
@property (nonatomic , strong)NSString *dangQiShu;
/** 进行中 or 已揭晓 */
@property (weak, nonatomic) IBOutlet UILabel *statusImage;
/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *shopName;
/** 进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressBtn;
/** 总需人次 */
@property (weak, nonatomic) IBOutlet UILabel *allNumber;
/** 剩余人次 */
@property (weak, nonatomic) IBOutlet UILabel *surplusNumber;

#pragma mark ----- 3种购物方式

/** 方式一 :   ----- 加入购物车 */
@property (weak, nonatomic) IBOutlet UIButton *jionBoxOne;
/** 立即购买 */
@property (weak, nonatomic) IBOutlet UIButton *jionBoxNowOne;
/** 单价 */
@property (weak, nonatomic) IBOutlet UILabel *DanJiaLabel;
/** 5人次 */
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;
/** 10人次 */
@property (weak, nonatomic) IBOutlet UIButton *tenBtn;
/** 20人次 */
@property (weak, nonatomic) IBOutlet UIButton *twentyBtn;
/** 包尾 */
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
/** 总共需要多少人 */
@property (weak, nonatomic) IBOutlet UILabel *allCountLabel;
/** 剩余的人数 */
@property (weak, nonatomic) IBOutlet UILabel *SurplusNum;
//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressTwo;
//当前期数
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//用户选择购买的次数
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;






/** 方式二 :  */
//积分价格
@property (weak, nonatomic) IBOutlet UILabel *JiFenBuy;
//已经有多少积分
@property (weak, nonatomic) IBOutlet UILabel *haveIntegral;
//加入购物车
@property (weak, nonatomic) IBOutlet UIButton *jionBoxTwo;
//立即加入购物车
@property (weak, nonatomic) IBOutlet UIButton *jionBoxNowTwo;


/** 方式三: */
//商品总价
@property (weak, nonatomic) IBOutlet UILabel *shopsAllMoney;
//加入购物车
@property (weak, nonatomic) IBOutlet UIButton *jionBoxThree;
//立即加入
@property (weak, nonatomic) IBOutlet UIButton *jionBoxNowThree;
/** 获取用户的ID */
@property (nonatomic , strong)NSString *userNum;
/** 接受用户的积分 */
@property (nonatomic , strong)NSString *jiFen;






























@property (nonatomic , strong)commodityModel *goodsModel;
@end
