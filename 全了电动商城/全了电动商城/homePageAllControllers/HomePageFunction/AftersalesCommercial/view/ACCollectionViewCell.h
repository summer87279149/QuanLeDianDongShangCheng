//
//  ACCollectionViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/31.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AftersalesModel.h"
@interface ACCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *GSName;
@property (weak, nonatomic) IBOutlet UILabel *GSAdress;
@property (nonatomic , strong)AftersalesModel *model;


@property (weak, nonatomic) IBOutlet UILabel *GongSiName;
@property (weak, nonatomic) IBOutlet UILabel *GongSiAdress;




@end
