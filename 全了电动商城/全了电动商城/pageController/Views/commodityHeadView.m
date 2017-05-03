//
//  commodityHeadView.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "commodityHeadView.h"

@implementation commodityHeadView

- (void)setGoodsModel:(commodityModel *)goodsModel {
    //状态
    int stateNum = [goodsModel.off intValue];
    self.statusNum = stateNum;
    
    self.shopName.text = goodsModel.name;
    float buyNowNum = [goodsModel.yigou floatValue];
    float AllNum = [goodsModel.qianggou floatValue];
    self.progressBtn.progress = buyNowNum / AllNum;
    self.allNumber.text = [NSString stringWithFormat:@"总需%@",goodsModel.qianggou];
    int Surplus = AllNum - buyNowNum;
    self.surplusNumber.text = [NSString stringWithFormat:@"剩余%d",Surplus];
    //滚动视的图片
    self.allImages = [NSString stringWithFormat:@"%@",goodsModel.tupianji];
    //当前期数
    self.dangQiShu = [NSString stringWithFormat:@"%@",goodsModel.dangqishu];
    
    /** 方式一 */
    self.DanJiaLabel.text = [NSString stringWithFormat:@"%@",goodsModel.danjia];
    self.progressTwo.progress = buyNowNum / AllNum;
    self.allCountLabel.text = [NSString stringWithFormat:@"满%@人开奖",goodsModel.qianggou];
    int surplusNumber = [goodsModel.qianggou intValue] - [goodsModel.yigou intValue];
    self.SurplusNum.text = [NSString stringWithFormat:@"剩余%d人次",surplusNumber];
    self.dateLabel.text = [NSString stringWithFormat:@"第%@期",goodsModel.dangqishu];
    
    /** 方式二 */
    self.JiFenBuy.text = [NSString stringWithFormat:@"%@积分+%@元",goodsModel.score_price,goodsModel.makeup_price];

    self.haveIntegral.hidden = YES;
    
        /** 方式三 */
    self.shopsAllMoney.text = [NSString stringWithFormat:@"%@元",goodsModel.zhigoujia];
    
    
    
    
    
    
    
    
    
}
///** 获取个人信息 */
//- (void)loadPersonalModel {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSString *urlStr = [NSString stringWithFormat:@"http://myadmin.all-360.com:8080/Admin/AppApi/userInfo/uid/%@",self.userNum];
//    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dataDic = responseObject;
//        self.jiFen = dataDic[@"data"][@"jifen"];
////        self.jiFen = [NSString stringWithFormat:@"%@",dataDic[@"data"][@"jifen"]];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error = %@",error);
//    }];
//}
@end
















