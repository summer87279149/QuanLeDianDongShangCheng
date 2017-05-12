


//
//  XTPickerView.m
//  全了电动商城
//
//  Created by Admin on 2017/5/9.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "XTPickerView.h"
@interface XTPickerView()
{
    NSUInteger arrayDeepCounts;
}
@end
@implementation XTPickerView
- (instancetype)initWithArr:(NSArray*)arr
{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.arr = arr;
        arrayDeepCounts = 1;
        
    }
    return self;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return [[UIScreen mainScreen] bounds].size.width/arrayDeepCounts;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    [self caculateComponentsNumber:self.arr];
    return arrayDeepCounts;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger a = 0;
    switch (component) {
        case 0:
            a = self.arr.count;
            break;
        case 1:
            for (NSArray *arr in self.arr) {
                a++;
            }
            break;
        case 2:
            for (NSArray *arr in self.arr) {
                for (NSArray *arr2 in arr) {
                    a++;
                }
            }
            break;
        default:
            a = 0;
            break;
    }
    return a;
}
-(void)caculateComponentsNumber:(NSArray*)arr{
    for (id child in arr) {
        if ([child isKindOfClass:[NSArray class]]) {
            arrayDeepCounts++;
            [self caculateComponentsNumber:child];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
