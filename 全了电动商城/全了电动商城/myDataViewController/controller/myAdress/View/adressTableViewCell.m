//
//  adressTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "adressTableViewCell.h"

@implementation adressTableViewCell


- (void)setModel:(adressModel *)model {
    self.name.text = [NSString stringWithFormat:@"%@",model.xingming];
    self.phone.text = [NSString stringWithFormat:@"%@",model.shouji];
    self.adress.text = [NSString stringWithFormat:@"%@",model.beizhu];
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
