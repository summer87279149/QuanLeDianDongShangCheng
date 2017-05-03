//
//  myCollectionModel.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/30.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myCollectionModel : NSObject
/** collectionViewModel */
@property (nonatomic , strong)NSArray *imagesArray;
@property (nonatomic , strong)NSArray *labelsArray;
/** tabelViewModel */
@property (nonatomic , strong)NSArray *functionLabel;
@property (nonatomic , strong)NSArray *functionImage;
@property (nonatomic , strong)NSArray *functionLabels;
@property (nonatomic , strong)NSArray *functionImages;

@end
