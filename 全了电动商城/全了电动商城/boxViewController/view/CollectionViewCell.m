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
    self.shopNameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    //把传进来的值赋值给当前变量  给block外面使用
    _model = model;
    self.dataLabel.text = [NSString stringWithFormat:@"总需:%@",model.qianggou];
    
    self.ShenYuLabel.text = [NSString stringWithFormat:@"已购:%@",model.yigou];
    
    self.DanJiaLabel.text = [NSString stringWithFormat:@"单价:%@",model.danjia];
    NSString *str = [NSString stringWithFormat:@"%@%@",ImageUrl,model.suoluetu];
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
        _textFieldNumber--;
        _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_textFieldNumber];
        _minusBtn.userInteractionEnabled = YES;
        _plusBtn.userInteractionEnabled = YES;
    }
    //取出对应行的数组里对应字典的数据
    NSDictionary *dic = ShopsIDs[_row];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.textFieldNumber] forKey:@"jionNum"];
}
- (IBAction)PlusBtn:(UIButton *)sender {
    _textFieldNumber++;
    _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_textFieldNumber];
    if(_textFieldNumber >= _minValue){
        _minusBtn.userInteractionEnabled = YES;
    } if (_textFieldNumber >= _maxValue) {
        //大于99 则不可以点击++ 操作
        _plusBtn.userInteractionEnabled = NO;
    }
    NSDictionary *dic = ShopsIDs[_row];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.textFieldNumber] forKey:@"jionNum"];
}
- (IBAction)deleteBtn:(UIButton *)sender {
    //取出全局ID 放在字典里
    for (NSDictionary *dic in ShopsIDs) {
        NSString *str = [NSString stringWithFormat:@"%@",_model.ID];
        //进行比较 (字符串 比较 字符串)
        if ([dic[@"goodsID"] isEqualToString:str]) {
            //不知道为什么可变数组变为不可能  然后转换可变数组
            NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:ShopsIDs];
            //把字典里的ID 删除
            [mutableArray removeObject:dic];
            //删除完毕后 把值放回去  数组还是不可变 注意哦
            ShopsIDs = mutableArray;
        }
        LDLog(@"%@",_model.ID);
    }
    //回调按钮  回调按钮 和模型
    self.block(sender , _model);
}






















@end
