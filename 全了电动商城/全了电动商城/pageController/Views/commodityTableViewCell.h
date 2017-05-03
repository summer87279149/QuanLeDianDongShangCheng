//
//  commodityTableViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commodityModel.h"
@interface commodityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userAdress;
@property (weak, nonatomic) IBOutlet UILabel *userJionNum;
@property (weak, nonatomic) IBOutlet UILabel *userJionTime;




















@property (nonatomic , strong)commodityModel *model;
@end
