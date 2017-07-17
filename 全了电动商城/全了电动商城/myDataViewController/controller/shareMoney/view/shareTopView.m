//
//  shareTopView.m
//  全了电动商城
//
//  Created by 懒洋洋 on 2017/4/22.
//  Copyright © 2017年 亮点网络. All rights reserved.
//

#import "shareTopView.h"

#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>
@implementation shareTopView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}


- (IBAction)shareBtn:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *WeiXinAction = [UIAlertAction actionWithTitle:@"微信分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shareImageToPlatformType:UMSocialPlatformType_WechatSession];
    }];
    UIAlertAction *WeiChartAction = [UIAlertAction actionWithTitle:@"微信朋友圈分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine];
        }];
    UIAlertAction *QQAction = [UIAlertAction actionWithTitle:@"QQ分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shareImageToPlatformType:UMSocialPlatformType_QQ];
    }];
    UIAlertAction *Qzone = [UIAlertAction actionWithTitle:@"QQ空间分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shareImageToPlatformType:UMSocialPlatformType_Qzone];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:WeiXinAction];
    [alertController addAction:WeiChartAction];
    [alertController addAction:QQAction];
    [alertController addAction:Qzone];
    [alertController addAction:cancleAction];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
}
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"全了电动商城是一种很有意思的新型购物模式，1元就可能夺到价值2000多元的电动车，快来试试吧！";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
//分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
  
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = @"全了电动商城,1元就可能夺到价值2000多元的电动车，快来试试吧！";
    //创建图片内容对象
    
    UMShareWebpageObject*webObject = [UMShareWebpageObject shareObjectWithTitle:@"全了电动商城,1元就可能夺到价值2000多元的电动车，快来试试吧！" descr:@"全了电动商城,1元就可能夺到价值2000多元的电动车，快来试试吧！" thumImage:[UIImage imageNamed:@"60.png"]];
    webObject.webpageUrl = self.imgURL;
//    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:@"全了电动商城" descr:@"全了电动商城是一种很有意思的新型购物模式，1元就可能夺到价值2000多元的电动车，快来试试吧！" thumImage:nil];
    //如果有缩略图，则设置缩略图
//    shareObject.thumbImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgURL]]];
//    if (self.imgURL) {
//         [shareObject setShareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgURL]]]];
//    }else{
//        self.imgURL = @"http://www.all-360.com/attachment/image/201705/qrcode_1494307726.png";
//        [shareObject setShareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgURL]]]];
//    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = webObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
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

@end
