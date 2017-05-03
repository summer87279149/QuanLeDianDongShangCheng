//
//  WinningCollectionViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/28.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "winningModel.h"
@interface WinningCollectionViewCell : UICollectionViewCell
/** 晒单人头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
/** 晒单人名字 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 晒单的日期 */
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
/** 晒单的时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** 中奖商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
/** 中奖期数 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
/** 中奖感言 */
@property (weak, nonatomic) IBOutlet UILabel *CommentLabel;
/** 中得奖品的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
/** 下半区3个文本距离左边的约束线 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dataLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelLine;
/** 下半区 2个图片距离边缘的约束线 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopImageLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLine;
/** 晒单人头像距离左边缘约束线 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headLine;

@property (nonatomic , strong)winningModel *model;

















@end
