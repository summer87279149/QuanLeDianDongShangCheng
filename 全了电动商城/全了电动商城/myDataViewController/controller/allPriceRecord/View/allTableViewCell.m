//
//  allTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "allTableViewCell.h"

@implementation allTableViewCell

- (void)setModel:(allModel *)model {
    self.orderid.text = [NSString stringWithFormat:@"订单号:%@",model.orderid];
    self.zongjia.text = [NSString stringWithFormat:@"订单号:%@",model.zongjia];
    self.off.text = [NSString stringWithFormat:@"订单号:%@",model.off];
    self.fahuooff.text = [NSString stringWithFormat:@"订单号:%@",model.fahuooff];
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
