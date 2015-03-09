//
//  RootTabBarController.m
//  Hubanghu
//
//  Created by  striveliu on 14-10-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "RootTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FBKVOController.h"
#import "ViewInteraction.h"
#import "FifthViewController.h"
#import "YHBUser.h"
#import "YHBLoginViewController.h"
#import "ChatListViewController.h"
#import "YHBGetPushManage.h"
#import "YHBDataService.h"
#import "YHBGetPushBuylist.h"
#import "SVProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "LSNavigationController.h"
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface RootTabBarController ()<IChatManagerDelegate>
{
    LSNavigationController *firstNav;
    LSNavigationController *secondNav;
    LSNavigationController *thirdNav;
    LSNavigationController *fourthNav;
    LSNavigationController *fifthNav;
    LSNavigationController *chatListNav;
    
    FirstViewController *firstVC;
    SecondViewController *secondVC;
    ThirdViewController *thirdVC;
    FourthViewController *fourthVC;
    FifthViewController *fifthVC;
    ChatListViewController *_chatListVC;
    
    NSInteger newSelectIndex;
    NSInteger oldSelectIndex;
    FBKVOController *loginObserver;
    FBKVOController *leftViewObserver;
    
    BOOL isGoBack;
    BOOL isLogin;
}
@property (nonatomic, strong)  YHBLoginViewController *loginVC;
@property (nonatomic, strong) LSNavigationController *loginNav;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property(strong, nonatomic) YHBGetPushManage *netManage;
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    self.delegate = self;
    isGoBack = NO;
    [self initTabViewController];
    [self initTabBarItem];
    [self initNotifyRegister];
//    [self registerEaseMob];
}

- (void)initNotifyRegister
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLeftView) name:kLeftViewPushMessage object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popLeftView) name:kLeftViewPopMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginViewController:) name:kLoginForUserMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearLoginVCInfo) name:kLogoutMessage object:nil];
}

- (void)initTabViewController
{
    firstVC = [[FirstViewController alloc] init];
    firstNav = [[LSNavigationController alloc] initWithRootViewController:firstVC];
    
    secondVC = [[SecondViewController alloc] init];
    secondNav = [[LSNavigationController alloc] initWithRootViewController:secondVC];
    
    thirdVC = [[ThirdViewController alloc] init];
    thirdNav = [[LSNavigationController alloc] initWithRootViewController:thirdVC];
    
    _chatListVC = [[ChatListViewController alloc] init];
    chatListNav = [[LSNavigationController alloc] initWithRootViewController:_chatListVC];
    
    fifthVC = [[FifthViewController alloc] init];
    fourthNav = [[LSNavigationController alloc] initWithRootViewController:fifthVC];
    
    fourthVC = [[FourthViewController alloc] init];
    fifthNav = [[LSNavigationController alloc] initWithRootViewController:fourthVC];
    self.viewControllers = @[firstNav,secondNav,chatListNav,fourthNav,fifthNav];
}

- (void)initTabBarItem
{
    //[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_sel"]]];
    if(kSystemVersion<7.0)
    {
        UIImage *img = [[UIImage imageNamed:@"tabbarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [[UITabBar appearance] setBackgroundImage:img];
    }
    for(int i=0; i<5;i++)
    {
        UITabBarItem *tabBarItem = self.tabBar.items[i];
        UIImage *norimg = [UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_nor_%d",i+1]];
        UIImage *selimg = [UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_sel_%d",i+1]];

        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        tabBarItem.title = @" ";
        if(kSystemVersion>=7.0)
        {
            norimg = [norimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selimg = [selimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarItem.image = norimg;
            tabBarItem.selectedImage = selimg;
            tabBarItem.tag = i;
        }
        else
        {
            [tabBarItem setFinishedSelectedImage:selimg withFinishedUnselectedImage:norimg];
        }
    }
    
    MLOG(@"tabbarHeight=%f",self.tabBar.frame.size.height);

}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    tabBar.selectedItem.title = @" ";
//}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    MLOG(@"shouldtabsel = %ld", tabBarController.selectedIndex);
    oldSelectIndex = tabBarController.selectedIndex;
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    MLOG(@"tabsel = %ld", tabBarController.selectedIndex);
    newSelectIndex = tabBarController.selectedIndex;
}


#pragma mark show login
- (void)showLoginViewController:(NSNotification *)aNotification
{
    
    if(aNotification.object)
    {
        isGoBack = [[aNotification object] boolValue]; ///yes为goback  其他的不处理
    }
    __weak RootTabBarController *weakself = self;
    if (![YHBUser sharedYHBUser].isLogin)
    {
        if(!self.loginVC)
        {
            self.loginVC = [[YHBLoginViewController alloc] init];
        }
        if(!self.loginNav)
        {
            self.loginNav = [[LSNavigationController alloc] initWithRootViewController:self.loginVC];
            
        }

        [self presentViewController:self.loginNav animated:YES completion:^{
            
        }];
        if(!loginObserver)
        {
            loginObserver = [[FBKVOController alloc] initWithObserver:self];
        }
        [loginObserver observe:self.loginVC keyPath:@"type" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            int type = [[change objectForKey:@"new"] intValue];
            if(type == eLoginSucc)
            {

            }
            else if(type == eLoginBack)
            {
                if(isGoBack)
                {
                    weakself.selectedIndex = oldSelectIndex;
                    isGoBack = NO;
                }
            }
            [weakself.loginNav dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
    }
}

- (void)clearLoginVCInfo
{
    if (_loginVC) {
        [_loginVC clearText];
    }
}

- (void)registerEaseMob
{
    [self registerNotifications];
    [self didUnreadMessagesCountChanged];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    isLogin=YES;
    [self setupUnreadMessageCount];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnread" object:nil];
//    [self setupUntreatedApplyCount];
}

- (void)dealloc
{
    [self unregisterNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    //    [[EMSDKFull sharedInstance].callManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    //    [[EMSDKFull sharedInstance].callManager removeDelegate:self];
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14],
                                        UITextAttributeFont,[UIColor colorWithRed:0.393 green:0.553 blue:1.000 alpha:1.000],UITextAttributeTextColor,
                                        nil] forState:UIControlStateSelected];
}

- (YHBGetPushManage *)netManage
{
    if (!_netManage) {
        _netManage = [[YHBGetPushManage alloc] init];
    }
    return _netManage;
}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }

    if (isLogin==YES)
    {
        [self.netManage getPushSucc:^(NSMutableArray *aArray) {
            NSMutableArray *pushArray = [NSMutableArray new];
            pushArray = aArray;
            NSMutableArray *buylist = [pushArray objectAtIndex:0];
            NSMutableArray *syslist = [pushArray objectAtIndex:1];
            if (buylist.count>0)
            {
                NSString *str = [[YHBDataService sharedYHBDataSevice] getunreadBuy];
                if (!str)
                {
                    str = @"0";
                }
                int count = (int)buylist.count+[str intValue];
                [[YHBDataService sharedYHBDataSevice] saveunreadBuy:[NSString stringWithFormat:@"%d", count]];
            }
            if (syslist.count>0)
            {
                NSString *str = [[YHBDataService sharedYHBDataSevice] getunreadSys];
                if (!str)
                {
                    str = @"0";
                }
                int count = (int)syslist.count+[str intValue];
                [[YHBDataService sharedYHBDataSevice] saveunreadSys:[NSString stringWithFormat:@"%d", count]];
            }
            if (buylist)
            {
                NSMutableArray *newBuyList = [NSMutableArray new];
                for (YHBGetPushBuylist *model in buylist)
                {
                    model.isread = @"NO";
                    [newBuyList addObject:model];
                }
                [[YHBDataService sharedYHBDataSevice] saveBuyList:newBuyList];
            }
            if (syslist)
            {
                [[YHBDataService sharedYHBDataSevice] saveSysList:syslist];
            }
            NSString *str1 = [[YHBDataService sharedYHBDataSevice] getunreadBuy];
            NSString *str2 = [[YHBDataService sharedYHBDataSevice] getunreadSys];
            if (!str1)
            {
                str1 = @"0";
            }
            if (!str2)
            {
                str2 = @"0";
            }
            int count1 = [str1 intValue];
            int count2 = [str2 intValue];
            
            int allcount = count1+count2+(int)unreadCount;
            if (_chatListVC) {
                if (allcount > 0) {
                    //            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",(int)unreadCount];
                    [[self.tabBar.items objectAtIndex:2] setBadgeValue:[NSString stringWithFormat:@"%d",(int)allcount]];
                    [self playSoundAndVibration];
                }else{
                    [[self.tabBar.items objectAtIndex:2] setBadgeValue:nil];
                }
            }
            UIApplication *application = [UIApplication sharedApplication];
            [application setApplicationIconBadgeNumber:allcount];
        } andFail:^(NSString *aStr) {
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        }];
    }
    else
    {
        int allcount = (int)unreadCount;
        if (_chatListVC) {
            if (allcount > 0) {
                //            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",(int)unreadCount];
                [[self.tabBar.items objectAtIndex:2] setBadgeValue:[NSString stringWithFormat:@"%d",(int)allcount]];
                [self playSoundAndVibration];
            }else{
                [[self.tabBar.items objectAtIndex:2] setBadgeValue:nil];
            }
        }
        UIApplication *application = [UIApplication sharedApplication];
        [application setApplicationIconBadgeNumber:allcount];
    }
    
    
    

}

//- (void)setupUntreatedApplyCount
//{
//    NSInteger unreadCount = [[[ApplyViewController shareController] dataSource] count];
//    if (_contactsVC) {
//        if (unreadCount > 0) {
//            _contactsVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadCount];
//        }else{
//            _contactsVC.tabBarItem.badgeValue = nil;
//        }
//    }
//}

- (void)networkChanged:(EMConnectionState)connectionState
{
    [_chatListVC networkChanged:connectionState];
}

//- (void)callOutWithChatter:(NSNotification *)notification
//{
//    id object = notification.object;
//    if ([object isKindOfClass:[NSString class]]) {
//        NSString *chatter = (NSString *)object;
//
//        if (_callController == nil) {
//            [[EMSDKFull sharedInstance].callManager removeDelegate:self];
//
//            _callController = [[CallSessionViewController alloc] initCallOutWithChatter:chatter];
//            [self presentViewController:_callController animated:YES completion:nil];
//        }
//        else{
//            [self showHint:@"正在通话中"];
//        }
//    }
//}
//
//- (void)callControllerClose:(NSNotification *)notification
//{
//    [[EMSDKFull sharedInstance].callManager addDelegate:self delegateQueue:nil];
//    _callController = nil;
//}

#pragma mark - IChatManagerDelegate 消息变化

- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [_chatListVC refreshDataSource];
}

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineCmdMessages:(NSArray *)offlineCmdMessages
{
    //    NSString *str = [NSString stringWithFormat:@"接收离线透传消息完毕，一共%d条", [offlineCmdMessages count]];
    //    [self showHint:str];
}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    if (ret) {
        EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
        
        do {
            if (options.noDisturbing) {
                NSDate *now = [NSDate date];
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute
                                                                               fromDate:now];
                
                NSInteger hour = [components hour];
                //        NSInteger minute= [components minute];
                
                NSUInteger startH = options.noDisturbingStartH;
                NSUInteger endH = options.noDisturbingEndH;
                if (startH>endH) {
                    endH += 24;
                }
                
                if (hour>=startH && hour<=endH) {
                    ret = NO;
                    break;
                }
            }
        } while (0);
    }
    
    return ret;
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = message.isGroup ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            [self showNotificationWithMessage:message];
        }else {
            [self playSoundAndVibration];
        }
#endif
    }
}

//-(void)didReceiveCmdMessage:(EMMessage *)message
//{
//    [self showHint:@"有透传消息"];
//}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    // 收到消息时，震动
    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = @"[图片]";
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = @"[位置]";
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = @"[音频]";
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = @"[视频]";
            }
                break;
            default:
                break;
        }
        
        NSString *title = message.from;
        if (message.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = @"您有一条新消息";
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = @"打开";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}

#pragma mark - IChatManagerDelegate 登陆回调（主要用于监听自动登录是否成功）

- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    if (error) {
        /*NSString *hintText = @"";
         if (error.errorCode != EMErrorServerMaxRetryCountExceeded) {
         if (![[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled]) {
         hintText = @"你的账号登录失败，请重新登陆";
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
         message:hintText
         delegate:self
         cancelButtonTitle:@"确定"
         otherButtonTitles:nil,
         nil];
         alertView.tag = 99;
         [alertView show];
         }
         } else {
         hintText = @"已达到最大登陆重试次数，请重新登陆";
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
         message:hintText
         delegate:self
         cancelButtonTitle:@"确定"
         otherButtonTitles:nil,
         nil];
         alertView.tag = 99;
         [alertView show];
         }*/
        NSString *hintText = @"你的账号登录失败，正在重试中... \n点击 '登出' 按钮跳转到登录页面 \n点击 '继续等待' 按钮等待重连成功";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"继续等待"
                                                  otherButtonTitles:@"登出",
                                  nil];
        alertView.tag = 99;
        [alertView show];
        [_chatListVC isConnect:NO];
    }
}

#pragma mark - IChatManagerDelegate 登录状态变化

- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"你的账号已在其他地方登录"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,
                                  nil];
        alertView.tag = 100;
        [alertView show];
    } onQueue:nil];
}

- (void)didRemovedFromServer {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"你的账号已被从服务器端移除"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,
                                  nil];
        alertView.tag = 101;
        [alertView show];
    } onQueue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
