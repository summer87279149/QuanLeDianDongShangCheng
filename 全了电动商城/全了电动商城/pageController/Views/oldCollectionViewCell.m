//
//  oldCollectionViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/6.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "oldCollectionViewCell.h"

@implementation oldCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setOldModel:(oldAnnouncedModel *)oldModel {
    self.qiHao.text = oldModel.cpqs;
    self.publishTime.text = oldModel.zhongtime;
    self.userName.text = oldModel.uname;
    self.userIp.text = oldModel.ip;
    self.userID.text = [NSString stringWithFormat:@"用户的ID:%@",oldModel.uid];
    self.luckNum.text = oldModel.zhonghao;
    self.userJionNum.text = oldModel.yigou;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:oldModel.touxiang]];

}
@end
