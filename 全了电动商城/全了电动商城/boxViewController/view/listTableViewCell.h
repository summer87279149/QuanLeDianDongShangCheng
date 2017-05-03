//
//  listTableViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/11.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsDataModel.h"
@interface listTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *shopsName;
@property (weak, nonatomic) IBOutlet UILabel *jionNum;
@property (weak, nonatomic) IBOutlet UILabel *allMoney;
@property (nonatomic , strong)goodsDataModel *model;
@end
