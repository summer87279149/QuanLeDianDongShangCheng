//
//  listTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/11.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "listTableViewCell.h"

@implementation listTableViewCell



- (void)setModel:(goodsDataModel *)model {
    self.shopsName.text = [NSString stringWithFormat:@"%@",model.name];
    //把传进来的值赋值给当前变量  给block外面使用
    _model = model;
    NSString *totalMoney = [NSString stringWithFormat:@"%d",[model.danjia intValue]*[model.shopsNum intValue]];
    self.allMoney.text = [NSString stringWithFormat:@"总金额:%@元",totalMoney];
    self.jionNum.text = [NSString stringWithFormat:@"参与的人次:%@次",model.shopsNum];
    LDLog(@"%@",model.shopsNum);
    NSString *str = [NSString stringWithFormat:@"%@%@",ImageUrl,model.suoluetu];
    [self.images sd_setImageWithURL:[NSURL URLWithString:str]];

    
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
