//
//  XTPickerView.h
//  全了电动商城
//
//  Created by Admin on 2017/5/9.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTPickerView : UIPickerView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, copy) NSArray *arr;
- (instancetype)initWithArr:(NSArray*)arr;
@end
