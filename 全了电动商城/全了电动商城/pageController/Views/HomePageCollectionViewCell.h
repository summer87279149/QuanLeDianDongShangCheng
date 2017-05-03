//
//  HomePageCollectionViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/23.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pageGoodsModel.h"
@interface HomePageCollectionViewCell : UICollectionViewCell
/** 十元专区 标示符 */
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
/** item 主 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
/** 图片介绍信息 */
@property (weak, nonatomic) IBOutlet UILabel *imageData;
/** 剩余人数 */
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
/** 进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 宝箱按钮 */
@property (weak, nonatomic) IBOutlet UIButton *boxBtn;
/** 已经参与了多少人次 */
@property (weak, nonatomic) IBOutlet UILabel *jionLabel;
/** 商品的ID */
@property (nonatomic , strong)NSString *ID;
@property (nonatomic , strong)pageGoodsModel *goodsModel;

@property (weak, nonatomic) IBOutlet UILabel *DuoBaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *JiFenLabel;
    
    
    
    
    
    
    
    
@end
