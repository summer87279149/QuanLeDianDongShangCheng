//
//  luckTableViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "luckModel.h"
@interface luckTableViewCell : UITableViewCell
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
//商品名称
@property (weak, nonatomic) IBOutlet UILabel *shopName;
//购买次数
@property (weak, nonatomic) IBOutlet UILabel *partakeNumber;
//中奖状态
@property (weak, nonatomic) IBOutlet UILabel *winStatus;
//购买年月时间
@property (weak, nonatomic) IBOutlet UILabel *yearOrTime;
@property (nonatomic , strong)luckModel *model;
@end
