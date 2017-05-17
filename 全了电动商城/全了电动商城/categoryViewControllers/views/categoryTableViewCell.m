//
//  categoryTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/27.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "categoryTableViewCell.h"

@implementation categoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
- (void)setModel:(pageGoodsModel *)model {
    self.labels.text = model.name;
    self.numberLabel.text = model.qianggou;
    self.surplusLabel.text = [NSString stringWithFormat:@"%@",model.remain];
    CGFloat strOne = [model.remain floatValue];
    CGFloat strTwo = [model.qianggou floatValue];
    self.progress.progress = strOne / strTwo;
    self.ID = model.ID;
    
    NSString *imageStr = [NSString stringWithFormat:@"%@%@" , ImageUrl , model.suoluetu];
    [self.images sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}


@end
