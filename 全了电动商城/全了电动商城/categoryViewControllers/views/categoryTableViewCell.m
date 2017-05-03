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
    
    
    

    /** 压缩 */
    [SSJKitImageManager compressImage:self.images.image limitSize:512*1024*8 maxSide:100 completion:^(NSData *data) {
        NSLog(@"In: %f", data.length/1024/8.0);
    }];
    NSString *imageStr = [NSString stringWithFormat:@"%@%@" , ImageUrl , model.suoluetu];
    [self.images sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}


@end
