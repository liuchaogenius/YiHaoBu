//
//  AppDelegate.m
//  YHB_Prj
//
//  Created by  striveliu on 14-11-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "EaseMob.h"
#import "YHBUser.h"
#import <AlipaySDK/AlipaySDK.h>
 
@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize rootvc;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //延迟2秒
    [NSThread sleepForTimeInterval:2];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    rootvc = [[RootTabBarController alloc] init];
    rootvc.view.frame = self.window.bounds;
    
    self.window.rootViewController = rootvc;
    [self.window makeKeyAndVisible];
    [self registerRemoteNotification];
    
    //注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = @"chatdemo";
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"yibu2015#kuaibu" apnsCertName:apnsCertName];
    // 需要在注册sdk后写上该方法
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];

    return YES;
}

- (void)registerRemoteNotification
{
#if !TARGET_IPHONE_SIMULATOR
    UIApplication *application = [UIApplication sharedApplication];
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
#endif
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(){
        //程序在10分钟内未被系统关闭或者强制关闭，则程序会调用此代码块，可以在这里做一些保存或者清理工作
        if ([YHBUser sharedYHBUser].isLogin) {
            [[YHBUser sharedYHBUser] writeUserInfoToFile];
        }
    }];
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];

}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kAlipayOrderResultMessage object:resultDic];
        }];
        
    }
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    MLOG(@"error -- %@",error);
}

//系统方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

//系统方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
}

@end
