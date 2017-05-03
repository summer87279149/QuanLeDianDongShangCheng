//
//  ACCollectionViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/31.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "ACCollectionViewCell.h"

@implementation ACCollectionViewCell

- (void)setModel:(AftersalesModel *)model {
    self.userName.text = [NSString stringWithFormat:@"联系人:%@",model.legal_name];
    self.userPhone.text = [NSString stringWithFormat:@"联系电话:%@",model.legal_tel];
    self.GSName.text = [NSString stringWithFormat:@"公司名称:%@",model.name];
    self.GSAdress.text = [NSString stringWithFormat:@"公司地址:%@",model.address];
    NSString *imageStr = [NSString stringWithFormat:@"%@%@" , ImageUrl , model.shop_img];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
