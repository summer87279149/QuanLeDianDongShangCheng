//
//  commodityTableViewCell.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/1/5.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "commodityTableViewCell.h"

@implementation commodityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(commodityModel *)model {
    NSString *imageStr = [NSString stringWithFormat:@"%@" , model.touxiang];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    self.userName.text = [NSString stringWithFormat:@"%@",model.uname];
    self.userAdress.text = [NSString stringWithFormat:@"%@",model.ip];
    self.userJionNum.text = [NSString stringWithFormat:@"参与了%@人次",model.shuliang];
    /** 时间戳的转换 */
    NSTimeInterval time=[model.stime doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSLog(@"date:%@",[detaildate description]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    self.userJionTime.text = [NSString stringWithFormat:@"%@",currentDateStr];
}


#pragma mark 时间戳转换

-(NSString *)TimeStamp:(NSString *)strTime

{
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //用[NSDate date]可以获取系统当前时间
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //输出格式为：2010-10-27 10:22:13
    
    NSLog(@"%@",currentDateStr);
    
    //alloc后对不使用的对象别忘了release
    
    //  [dateFormatter release];
    
    return currentDateStr;
    
}









- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
