//
//  CollectionViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsDataModel.h"
typedef void(^deleteBlock)(UIButton *btn , goodsDataModel *model);
@interface CollectionViewCell : UICollectionViewCell
/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
/** 删除这行数据(Cell)的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
/** 总需 */
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
/** 剩余 */
@property (weak, nonatomic) IBOutlet UILabel *ShenYuLabel;
/** 单价 */
@property (weak, nonatomic) IBOutlet UILabel *DanJiaLabel;


@property (nonatomic , copy)deleteBlock block;
//显示总价和积分够约束线改变
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AllMoneytopLine;
//
@property (nonatomic , assign)long row;
/** 减号 */
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
/** 加号 */
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
/** 显示的文本 */
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
/** 最小值, default is 1 */
@property (nonatomic, assign ) NSInteger minValue;
/** 最大值 */
@property (nonatomic, assign ) NSInteger maxValue;
/** 放入文本框中的值 */
@property (nonatomic, assign ) NSInteger textFieldNumber;
/** 商品的单价 */
@property (weak, nonatomic) IBOutlet UILabel *onecePrice;
@property (nonatomic , strong)goodsDataModel *model;
@end
