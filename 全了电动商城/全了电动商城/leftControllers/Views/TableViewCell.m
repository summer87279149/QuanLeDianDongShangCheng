//
//  TableViewCell.m
//  扔掉发
//
//  Created by 懒洋洋 on 2016/12/26.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)setDataModel:(sideslipArraysModel *)dataModel {
    if (dataModel) {
        self.label.text = dataModel.name;
        [self.imagesViews sd_setImageWithURL:[NSURL URLWithString:dataModel.icon] placeholderImage:[UIImage imageNamed:@"苹果7p"]];
    }
}








- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
