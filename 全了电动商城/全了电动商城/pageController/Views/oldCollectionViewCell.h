//
//  oldCollectionViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/6.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oldAnnouncedModel.h"
@interface oldCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *qiHao;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userIp;
@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UILabel *luckNum;
@property (weak, nonatomic) IBOutlet UILabel *userJionNum;
@property (nonatomic , strong)oldAnnouncedModel *oldModel;
@end
