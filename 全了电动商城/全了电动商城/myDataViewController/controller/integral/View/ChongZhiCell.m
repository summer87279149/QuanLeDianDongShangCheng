//
//  ChongZhiCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "ChongZhiCell.h"

@implementation ChongZhiCell

- (void)setModel:(ChongZhiModel *)model {
    self.money.text = [NSString stringWithFormat:@"¥:%@",model.amount];
    self.time.text = model.atime;
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
