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
#import "NetManager.h"
 
@interface AppDelegate ()<UIAlertViewDelegate>

@property (strong, nonatomic) NSString *updateUrl;
@property (assign, nonatomic) int force;

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
    
    [self checkVersion];
    
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

- (void)checkVersion
{
    self.updateUrl = nil;
    NSString *url = nil;
    self.force = 0;
    kYHBRequestUrl(@"getVersion.php", url);
    NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [bundleDic objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:@"IOS",@"device",appVersion?:@"",@"version", nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        int result = [successDict[@"result"] intValue];
        if (result == 1) {
            NSDictionary *dataDict = [successDict objectForKey:@"data"];
            int force = [[dataDict objectForKey:@"force"] intValue];
            self.force = force;
            ////"force":0/*0不更新，1强制更新，2可选更新*/
            NSString *title = dataDict[@"title"];
            NSString *content = dataDict[@"content"];
            if (force == 1) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                self.updateUrl = dataDict[@"url"];
                [alertView show];
                
            }else if (force == 2){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"更新" otherButtonTitles:@"取消", nil];
                self.updateUrl = dataDict[@"url"];
                [alertView show];
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        MLOG(@"%@",self.updateUrl);
        //#if RELEASE
        NSString *str = self.updateUrl;//[NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d", 945963130];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        if(self.force == 1)
        {
            NSMutableArray *ary = [NSMutableArray array];
            [ary addObject:nil];
            
        }
        //#endif
    }
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
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
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
