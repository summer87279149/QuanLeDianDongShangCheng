//
//  DBShowDetailViewController.h
//  LFAutoListCell
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 baixinxueche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBChildModel.h"

@interface DBShowDetailViewController : UIViewController
@property (strong,nonatomic) NSString *naviTitle;

@property (strong,nonatomic) DBChildModel *childModel;

@end
