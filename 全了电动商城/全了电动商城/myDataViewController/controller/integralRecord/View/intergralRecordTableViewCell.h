//
//  intergralRecordTableViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/16.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "intergralModel.h"
@interface intergralRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *JiFen;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (nonatomic , strong)intergralModel *model;
@end
