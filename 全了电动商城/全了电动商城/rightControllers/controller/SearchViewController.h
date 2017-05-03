//
//  SearchViewController.h
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/27.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
//tabelViewHeadView
@property (nonatomic , strong)UITextField *searchField;
@property (nonatomic , strong)UIButton    *cancelBtn;
//tabelViewFootView
@property (nonatomic , strong)UIButton    *clearBtn;
@end
