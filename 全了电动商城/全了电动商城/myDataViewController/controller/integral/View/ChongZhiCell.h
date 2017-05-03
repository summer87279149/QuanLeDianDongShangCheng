//
//  ChongZhiCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChongZhiModel.h"
@interface ChongZhiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic , strong)ChongZhiModel *model;
@end
