 //
//  HomePageCollectionViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/23.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "HomePageCollectionViewCell.h"

@implementation HomePageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setGoodsModel:(pageGoodsModel *)goodsModel {
    self.imageData.text = goodsModel.name;
    self.progressLabel.text = [NSString stringWithFormat:@"剩余:%@",goodsModel.remain];
    self.jionLabel.text = [NSString stringWithFormat:@"已参与:%@",goodsModel.yigou];
    self.DuoBaoLabel.text = [NSString stringWithFormat:@"众筹价:%@人次",goodsModel.danjia];
    self.allMoneyLabel.text = [NSString stringWithFormat:@"直购价:%@元",goodsModel.zhigoujia];
    self.JiFenLabel.text = [NSString stringWithFormat:@"积分购:%d元+%@积分",[goodsModel.makeup_price intValue] ,goodsModel.score_price];
    /** 压缩 */
//    [SSJKitImageManager compressImage:self.homeImage.image limitSize:512*1024*8 maxSide:60 completion:^(NSData *data) {
//        NSLog(@"In: %f", data.length/1024/8.0);
//    }];
    NSString *imageStr = [NSString stringWithFormat:@"%@%@" , ImageUrl , goodsModel.suoluetu];
    [self.homeImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    /** progress */
    float floatStrO = [goodsModel.yigou  floatValue];
    float floatStrT = [goodsModel.qianggou floatValue];
    self.progressView.progress = floatStrO / floatStrT;
    
    self.ID = goodsModel.ID;
}





@end
