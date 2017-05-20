//
//  AppDelegate.m
//  全了电动商城
//
//  Created by 懒洋洋 on 16/12/20.
//  Copyright © 2016年 亮点网络. All rights reserved.
//
#import "UMMobClick/MobClick.h"
#import "AppDelegate.h"
#import "sideslipViewController.h"
#import "homePageViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>
//@property(nonatomic,strong) MMDrawerController * drawerController;
@end
//全局变量保存点击的商品ID  初始化
extern NSMutableDictionary *GoodsIDs;
//字典放在数组内
extern NSMutableArray *ShopsIDs;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /** 一: 微信支付 注册APPID */
    [WXApi registerApp:@"wx874aa0c3f4f58619"];
    //写这句话是为了打开含有textview的界面不卡顿
//    UITextView *textView  = [[UITextView alloc] init];
    //初始化
    //GoodsIDs = [NSMutableDictionary dictionary];
    ShopsIDs = [NSMutableArray array];
    
    sideslipViewController *sideslip = [[sideslipViewController alloc]init];
    /**
     主视图 ---> 左侧 ---> 右侧
     */
    UIStoryboard *boadr = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UITabBarController *tabbarController = [boadr instantiateViewControllerWithIdentifier:@"tabbar"];
    tabbarController.tabBar.tintColor = kColor_RGB(215, 59, 100);
    tabbarController.tabBar.backgroundColor = [UIColor whiteColor];
    tabbarController.tabBar.barTintColor = [UIColor whiteColor];
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:tabbarController leftDrawerViewController:sideslip rightDrawerViewController:nil];
    
    self.window.backgroundColor = [UIColor whiteColor];
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = 200.0;
    self.drawerController.maximumRightDrawerWidth = 200.0;
    
    //6、初始化窗口、设置根控制器、显示窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
    
    /** 友盟 */
    UMConfigInstance.appKey = @"587ef9a45312dd60e5001d75";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.bCrashReportEnabled = YES;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"587ef9a45312dd60e5001d75"];
    [self configUSharePlatforms];
    
    
    
    //Required 极光推送
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"831058e0968a0f1415864b70"
                          channel:@"Publish channel"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    
    return YES;
}
//分享的方法
- (void)configUSharePlatforms
{

    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105879883"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置微信的appKey和appSecret UMSocialPlatformType_WechatTimeLine*/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx874aa0c3f4f58619" appSecret:@"ca09bd2ee812a1e6eccb1ccd41c6c0e1" redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wx874aa0c3f4f58619" appSecret:@"ca09bd2ee812a1e6eccb1ccd41c6c0e1" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    //UMSocialPlatformType_Qzone
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1105879883"/*设置QQ平台的appID*/  appSecret:@"rxAKsF8hlY8YX1Gw" redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105879883"/*设置QQ平台的appID*/  appSecret:@"rxAKsF8hlY8YX1Gw" redirectURL:@"http://mobile.umeng.com/social"];
    
//    /* 设置新浪的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1251309632"  appSecret:@"16275dea52f50ae61b7ed10faf68dc74" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    /* 支付宝的appKey */
    // [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
}

/** 激光推送 ---回调方法并添加回调方法中的代码 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
/** 实现注册APNs失败接口（可选）*/
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate
/** 添加处理APNs通知回调方法 */
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark - 微信支付回调

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        [WXApi handleOpenURL:url delegate:self];
    }
    return  result;
}
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
    }else{
        //微信支付回调
        [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}


#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
   // [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    if([resp isKindOfClass:[PayResp class]]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"listenWXpayResults" object:self userInfo:@{@"resultDic":resp}];
        
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    if ([url.host isEqualToString:@"safepay"]) {
    }else{
        [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //当APP启动或者APP从后台进入前台都会调用这个方法
    [JPUSHService setBadge:0];
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
