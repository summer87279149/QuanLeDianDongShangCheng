//
//  PartakeTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "PartakeTableViewCell.h"

@implementation PartakeTableViewCell




- (void)setModel:(DuoBaoModel *)model {
    self.shopName.text = [NSString stringWithFormat:@"%@",model.name];
    self.partakeNumber.text = [NSString stringWithFormat:@"%@",model.yigou];
    self.yearOrTime.text = [NSString stringWithFormat:@"%@",model.stime];
    self.winStatus.text = [NSString stringWithFormat:@"%@",model.ztmc];
    self.shopName.text = [NSString stringWithFormat:@"%@",model.name];
    NSString *imageStr = [NSString stringWithFormat:@"%@%@",ImageUrl,model.suoluetu];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    
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
