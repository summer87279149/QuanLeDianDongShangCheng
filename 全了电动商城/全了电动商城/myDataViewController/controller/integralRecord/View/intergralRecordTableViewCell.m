//
//  intergralRecordTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "intergralRecordTableViewCell.h"

@implementation intergralRecordTableViewCell


- (void)setModel:(intergralModel *)model {
    self.JiFen.text = model.jifen;
    self.Time.text  = model.atime;
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
