//
//  topCollectionView.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/3/28.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "topCollectionView.h"
#import "homePageTopCell.h"
#import "homePageFunction.h"
#import "WinningViewController.h"
@interface topCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong)UICollectionView *homeTopCollection;
@property (nonatomic , strong)NSArray *imageArray;
@property (nonatomic , strong)NSArray *labelArray;

@end
#define ItemSize ((SCREEN_WIDTH -1) /2)
static NSString *indentifier = @"HomeCell";
@implementation topCollectionView
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
        _imageArray = @[@"运营",@"代理",@"售后",@"合作",@"附近",@"最新资讯XX",@"客服",@"常见",@"1",@"2",@"3",@"4",@"5",@"6",@"77",@"8"];
    }
    return _imageArray;
}
- (NSArray *)labelArray {
    if (!_labelArray) {
        _labelArray = @[@"运营商",@"代理商",@"售后商",@"合作商",@"附近商家",@"最新资讯",@"客服中心",@"常见问题",@"晒单分享",@"我的红包",@"充值抢现金",@"积分大转盘",@"一键生成海报",@"分享红包领取",@"营销老虎机",@"十元专区"];
    }
    return _labelArray;
}
- (void)setCollectionView {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = (SCREEN_WIDTH - 320)/6;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, (SCREEN_WIDTH - 320)/6+12, 10, (SCREEN_WIDTH - 320)/6 + 12);
    _homeTopCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,181) collectionViewLayout:flowLayout];
    _homeTopCollection.delegate   = self;
    _homeTopCollection.dataSource = self;
    _homeTopCollection.backgroundColor = [UIColor whiteColor];
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
    
    return 16;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    homePageTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.Images.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    [cell.Labels setTitle:[NSString stringWithFormat:@"%@",self.labelArray[indexPath.row]] forState:UIControlStateNormal];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            OperatorsViewController *OperatorsVC = [[OperatorsViewController alloc]init];
            OperatorsVC.statuNum = @"4";
            [[self viewController].navigationController pushViewController:OperatorsVC animated:YES];
        }
            break;
        case 1:
        {
            aftersalesCollectionView *OperatorsVC = [[aftersalesCollectionView alloc]init];
            OperatorsVC.statuNumber = @"1";
            [[self viewController].navigationController pushViewController:OperatorsVC animated:YES];
        }
            break;
        case 2:
        {
            aftersalesCollectionView *OperatorsVC = [[aftersalesCollectionView alloc]init];
            OperatorsVC.statuNumber = @"3";
            [[self viewController].navigationController pushViewController:OperatorsVC animated:YES];
        }
            break;
        case 3:
        {
            [[self viewController].navigationController pushViewController:[PartnersViewController new] animated:YES];
        }
            break;
        case 4:
        {
            [[self viewController].navigationController pushViewController:[nearbyViewController new] animated:YES];
        }
            break;
        case 5:
        {
            [[self viewController].navigationController pushViewController:[SearchViewController new] animated:YES];
        }
            break;
        case 6:
        {
            [[self viewController].navigationController pushViewController:[CustomerServices new] animated:YES];
        }
            break;
        case 7:
        {
            [[self viewController].navigationController pushViewController:[freshmanHelpViewController new] animated:YES];
        }
            break;
        case 8:
        {
            [[self viewController].navigationController pushViewController:[WinningViewController new] animated:YES];
        }
            break;
        case 9:
        {
            [[self viewController].navigationController pushViewController:[redEnvelopeViewController new] animated:YES];
        }
            break;
        case 10:
        {
            [[self viewController].navigationController pushViewController:[RechargeViewController new] animated:YES];
        }
            break;
        case 11:
        {
            [[self viewController].navigationController pushViewController:[integralTurntable new] animated:YES];
        }
            break;
        case 12:
        {
            [[self viewController].navigationController pushViewController:[posterViewController new] animated:YES];
        }
            break;
        case 13:
        {
            [[self viewController].navigationController pushViewController:[shareRedEnvelope new] animated:YES];
        }
            break;
        case 14:
        {
            [[self viewController].navigationController pushViewController:[slotsViewController new] animated:YES];
        }
            break;
        case 15:
        {
            [[self viewController].navigationController pushViewController:[tenYuanViewController new] animated:YES];
        }
            break;
        default:
            break;
    }
    NSLog(@"点中了第%ld个",(long)indexPath.row);

}
//获取View所在的Viewcontroller方法  上面调用这个方法实现在view视图里 跳转
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
