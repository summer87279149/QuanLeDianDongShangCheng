//
//  topView.m
//  collectionView
//
//  Created by 懒洋洋 on 2017/3/28.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "topView.h"
#import "homePageTopCell.h"
@interface topView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong)UICollectionView *homeTopCollection;
@property (nonatomic , strong)NSArray *imageArray;
@property (nonatomic , strong)NSArray *labelArray;



@end
#define kColor_RGB(x, y, z) [UIColor colorWithRed:(x)/255.0 green:(y)/255.0 blue:(z)/255.0 alpha:1]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define ItemSize ((SCREEN_WIDTH -1) /2)
static NSString *indentifier = @"HomeCell";
@implementation topView
-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)backGroundColor {
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = backGroundColor;
        [self setCollectionView];
    }
    return self;
}
- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"170",@"180",@"190",@"180",@"170",@"180",@"190",@"180"];
    }
    return _imageArray;
}
- (NSArray *)labelArray {
    if (!_labelArray) {
        _labelArray = @[@"光头强",@"西瓜强",@"菊花强",@"张永强",@"机械强",@"蛋蛋强",@"强中强",@"我最强"];
    }
    return _labelArray;
}
- (void)setCollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = (SCREEN_WIDTH - 320)/6;
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, (SCREEN_WIDTH - 320)/6, 10, (SCREEN_WIDTH - 320)/6);
    
    _homeTopCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,181) collectionViewLayout:flowLayout];
    _homeTopCollection.delegate   = self;
    _homeTopCollection.dataSource = self;
    _homeTopCollection.backgroundColor = kColor_RGB(244, 242, 242);
    /** 注册collectionView cell 的重用池*/
    [_homeTopCollection registerNib:[UINib nibWithNibName:@"homePageTopCell" bundle:nil] forCellWithReuseIdentifier:indentifier];
    _homeTopCollection.showsVerticalScrollIndicator = NO;
    _homeTopCollection.showsHorizontalScrollIndicator = NO;
    [self addSubview:_homeTopCollection];
}
#pragma mark ----- <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    homePageTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
//    NSString *imageStr = [NSString stringWithFormat:@"%@",self.imageArray[indexPath.row]];
    cell.Images.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.Labels = self.labelArray[indexPath.row];
    return cell;
}

@end
