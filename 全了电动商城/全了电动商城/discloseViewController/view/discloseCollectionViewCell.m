//
//  discloseCollectionViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "discloseCollectionViewCell.h"

@implementation discloseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(discloseDataModel *)model {
    self.shopName.text = [NSString stringWithFormat:@"%@",model.cpname];
    self.dateNumber.text = [NSString stringWithFormat:@"%@",model.cpqs];
    self.userName.text = [NSString stringWithFormat:@"%@",model.uname];
    self.userNumber.text = [NSString stringWithFormat:@"%@",model.yigou];
    self.luckNumber.text = [NSString stringWithFormat:@"%@",model.zhonghao];
    self.yearOrTime.text = [NSString stringWithFormat:@"%@",model.zhongtime];
    NSString *imageStr = [NSString stringWithFormat:@"%@%@",ImageUrl,model.suoluetu];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}
@end
