//
//  categoryTableViewCell.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/27.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pageGoodsModel.h"
@interface categoryTableViewCell : UITableViewCell
/** 商品的ID */
@property (nonatomic , strong)NSString *ID;
/** 种类 -> 十元专区图标 */
@property (weak, nonatomic) IBOutlet UIImageView *tenYuan;
/** 种类 -> 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *images;
/** 种类 -> 对应图片详情 */
@property (weak, nonatomic) IBOutlet UILabel *labels;
/** 种类 -> 进度条*/
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
/** 种类 -> 总需数量*/
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
/** 种类 -> 剩余数量*/
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;
/** 种类 -> 宝箱按钮*/
@property (weak, nonatomic) IBOutlet UIButton *boxBtn;

@property (strong , nonatomic)pageGoodsModel *model;

@end
