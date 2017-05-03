//
//  redTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/8.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "redTableViewCell.h"

@implementation redTableViewCell






- (void)setModel:(redBagModel *)model {
    self.redBagMoney.text = [NSString stringWithFormat:@"%@元  红包",model.haobaojine];
    self.redBagPrice.text = [NSString stringWithFormat:@"余额: %@筹币",model.shengyujine];
    self.beginDate.text = [NSString stringWithFormat:@"生产日期: %@",model.atime];
    self.endDate.text = [NSString stringWithFormat:@"截止日期: %@",model.gtime];
    self.useCondition.text = [NSString stringWithFormat:@"订单金额: 满 %@ 可用",model.dayukeyong];
    self.redBagStatu.text = [NSString stringWithFormat:@"%@",model.syzt];
    self.useDate.text = [NSString stringWithFormat:@"使用日期: %@",model.stime];

}










- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
