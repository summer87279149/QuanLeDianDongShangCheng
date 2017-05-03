//
//  allTableViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/7.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "allModel.h"
@interface allTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderid;
@property (weak, nonatomic) IBOutlet UILabel *zongjia;
@property (weak, nonatomic) IBOutlet UILabel *off;
@property (weak, nonatomic) IBOutlet UILabel *fahuooff;
@property (nonatomic , strong)allModel *model;
@end
