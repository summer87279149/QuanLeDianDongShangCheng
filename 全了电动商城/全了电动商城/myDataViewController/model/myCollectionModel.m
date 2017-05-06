//
//  myCollectionModel.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/30.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "myCollectionModel.h"

@implementation myCollectionModel
/** collectionView */
-(NSArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSArray array];
        _imagesArray = @[@"未标题-1",@"未标题-2",@"未标题-3"];
    }
    return _imagesArray;
}
-(NSArray *)labelsArray {
    if (!_labelsArray) {
        _labelsArray = [NSArray array];
        _labelsArray = @[@"充值",@"充值记录",@"晒单"];
    }
    return _labelsArray;
}
/** tabelView第一组 */
- (NSArray *)functionLabel {
    if (!_functionLabel) {
        _functionLabel = [NSArray array];
        _functionLabel = @[@"夺宝记录",@"幸运记录",@"直购记录"];
    }
    return _functionLabel;
}
- (NSArray *)functionImage {
    if (!_functionImage) {
        _functionImage = [NSArray array];
        _functionImage = @[@"夺宝记录1",@"幸运",@"直购"];
    }
    return _functionImage;
}
/** tabelView第二组 */
- (NSArray *)functionLabels {
    if (!_functionLabels) {
        _functionLabels = [NSArray array];
        _functionLabels = @[@"晒单记录",@"积分记录",@"地址管理",@"分享赚钱"];
    }
    return _functionLabels;
}
- (NSArray *)functionImages {
    if (!_functionImages) {
        _functionImages = [NSArray array];
        _functionImages = @[@"晒单",@"充值",@"地址",@"QQ"];
    }
    return _functionImages;
}












@end
