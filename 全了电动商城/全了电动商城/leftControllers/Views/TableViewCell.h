//
//  TableViewCell.h
//  扔掉发
//
//  Created by 懒洋洋 on 2016/12/26.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sideslipArraysModel.h"
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagesViews;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic)sideslipArraysModel *dataModel;

@end
