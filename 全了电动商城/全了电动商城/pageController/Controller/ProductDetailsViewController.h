//
//  ProductDetailsViewController.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/29.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "winningModel.h"
@interface ProductDetailsViewController : UIViewController
@property (nonatomic , strong)NSString *ID;
/** 用户留言 */
@property (weak, nonatomic) IBOutlet UILabel *userSayLabel;
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
/** 用户姓名 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/** 晒单日期 */
@property (weak, nonatomic) IBOutlet UILabel *userYear;
/** 中奖商品名字 */
@property (weak, nonatomic) IBOutlet UILabel *shopName;
/** 购买的总次数 */
@property (weak, nonatomic) IBOutlet UILabel *allNumber;
/** 中奖号码 */
@property (weak, nonatomic) IBOutlet UILabel *shopNumber;
/** 揭晓的时间 */
@property (weak, nonatomic) IBOutlet UILabel *yearOrTime;
/** 中奖的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (nonatomic , strong)winningModel *model;




























@end
