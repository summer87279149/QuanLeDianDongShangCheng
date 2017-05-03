//
//  WinningCollectionViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/28.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "WinningCollectionViewCell.h"

@implementation WinningCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(winningModel *)model {
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.touxiang]]];

    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.username];
    self.yearLabel.text = model.atime;
    self.shopTitleLabel.text = model.cp_name;
    self.dateLabel.text = [NSString stringWithFormat:@"中奖期号:%@",model.qihao];
    self.CommentLabel.text = model.miaoshu;
    NSString *imageStr = [NSString stringWithFormat:@"%@%@",ImageUrl,model.cp_suoluetu];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}
@end
