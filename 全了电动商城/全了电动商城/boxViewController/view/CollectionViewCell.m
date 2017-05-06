//
//  CollectionViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "CollectionViewCell.h"
@interface CollectionViewCell()<UITextFieldDelegate>

@end
//商品的ID
extern NSMutableArray *ShopsIDs;
@implementation CollectionViewCell
- (void)setModel:(goodsDataModel *)model {
    _model = model;
    self.shopNameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    //把传进来的值赋值给当前变量  给block外面使用
    _model = model;
    self.dataLabel.text = [NSString stringWithFormat:@"总需:%@",model.qianggou];
    
    self.ShenYuLabel.text = [NSString stringWithFormat:@"已售出:%@",model.yigou];
    
    self.DanJiaLabel.text = [NSString stringWithFormat:@"单价:%@元",model.danjia];
    NSString *str = [NSString stringWithFormat:@"%@",model.suoluetu];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:str]];
    _textFieldNumber = [model.shopsNum intValue];
    _numberTextField.text = model.shopsNum;
}


- (void)awakeFromNib {
    [super awakeFromNib];

    //最小值为
    _minValue = 1;
    //最大值
    _maxValue = 999999;
    //在textField放入最小值
    _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_textFieldNumber];
    _numberTextField.delegate = self;
    
}
//不可输入
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}
- (IBAction)MinusBtn:(UIButton *)sender {
    //如果数值小于或者等于1 不允许做--操作 并且减号按钮失效  反之如果大于1 小于99 则可以进行--操作 并且按钮不失效
    if (_textFieldNumber <= _minValue) {
        _minusBtn.userInteractionEnabled = NO;
    }else if(_textFieldNumber > _minValue | _minValue < _maxValue) {
        self.jianBlock(sender,_model);
        _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_textFieldNumber];
        _minusBtn.userInteractionEnabled = YES;
        _plusBtn.userInteractionEnabled = YES;
    }
    
    
}

- (IBAction)PlusBtn:(UIButton *)sender {
     self.jiaBlock(sender,_model);
    _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_textFieldNumber];
    if(_textFieldNumber >= _minValue){
        _minusBtn.userInteractionEnabled = YES;
    } if (_textFieldNumber >= _maxValue) {
        //大于99 则不可以点击++ 操作
        _plusBtn.userInteractionEnabled = NO;
    }
   
 
}
- (IBAction)deleteBtn:(UIButton *)sender {
    //回调按钮  回调按钮 和模型
    self.block(sender , _model);
}






















@end
