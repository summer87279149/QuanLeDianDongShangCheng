//
//  redTableViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/8.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "redBagModel.h"
@interface redTableViewCell : UITableViewCell
//红包金额
@property (weak, nonatomic) IBOutlet UILabel *redBagMoney;
//红包剩余金额
@property (weak, nonatomic) IBOutlet UILabel *redBagPrice;
//红包发送的时间
@property (weak, nonatomic) IBOutlet UILabel *beginDate;
//红包结束的时间
@property (weak, nonatomic) IBOutlet UILabel *endDate;
//红包使用的规则  -> 金钱数额度
@property (weak, nonatomic) IBOutlet UILabel *useCondition;
//红包的状态
@property (weak, nonatomic) IBOutlet UILabel *redBagStatu;
//红包使用的时间
@property (weak, nonatomic) IBOutlet UILabel *useDate;
@property (nonatomic , strong)redBagModel *model;
@end
