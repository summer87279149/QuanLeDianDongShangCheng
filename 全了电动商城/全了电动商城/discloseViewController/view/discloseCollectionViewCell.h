//
//  discloseCollectionViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "discloseDataModel.h"
@interface discloseCollectionViewCell : UICollectionViewCell
/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *shopName;
/** 中奖期数 */
@property (weak, nonatomic) IBOutlet UILabel *dateNumber;
/** 中奖人名 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/** 购买次数 */
@property (weak, nonatomic) IBOutlet UILabel *userNumber;
/** 中奖幸运号码 */
@property (weak, nonatomic) IBOutlet UILabel *luckNumber;
/** 开奖揭晓时间 */
@property (weak, nonatomic) IBOutlet UILabel *yearOrTime;

@property (nonatomic, strong)discloseDataModel *model;































@end
