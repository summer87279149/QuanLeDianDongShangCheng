//
//  myTopView.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2016/12/30.
//  Copyright © 2016年 亮点网络. All rights reserved.
//

#import "myTopView.h"

@implementation myTopView

- (void)setModel:(myDataModel *)model {
    
    self.userLabel.text = model.name;
    self.userBalance.text = model.jine;
    
    /** 如果包含HTTP  or 不包含 */
    if ([model.touxiang containsString:@"http"]) {
        NSString *imageStr = [NSString stringWithFormat:@"%@",model.touxiang];
        [self.userImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        
    }else{
        NSString *imageStr = [NSString stringWithFormat:@"%@%@",ImageUrl ,model.touxiang];
        [self.userImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    }
}

@end
