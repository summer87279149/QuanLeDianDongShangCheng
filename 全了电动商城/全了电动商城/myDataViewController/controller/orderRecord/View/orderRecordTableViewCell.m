//
//  orderRecordTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "orderRecordTableViewCell.h"

@implementation orderRecordTableViewCell


- (void)setModel:(orderReadModel *)model {
    self.name.text = [NSString stringWithFormat:@"%@",model.cp_name];
    self.sayLabel.text = [NSString stringWithFormat:@"%@",model.miaoshu];
    self.year.text = [NSString stringWithFormat:@"%@",model.atime];
    NSString *imageStr = [NSString stringWithFormat:@"%@%@",ImageUrl,model.cp_suoluetu];
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    
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
