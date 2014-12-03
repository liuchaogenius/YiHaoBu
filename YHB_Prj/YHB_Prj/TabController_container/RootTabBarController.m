//
//  RootTabBarController.m
//  Hubanghu
//
//  Created by  striveliu on 14-10-9.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "RootTabBarController.h"
#import "FBKVOController.h"
#import "ViewInteraction.h"
#import "FactoryModel.h"
#import "LSNavigationController.h"

@interface RootTabBarController ()
{
    LSNavigationController *firstNav;
    LSNavigationController *secondNav;
    LSNavigationController *thirdNav;
    LSNavigationController *fourthNav;
    LSNavigationController *fifthNav;
    
    NSInteger newSelectIndex;
    NSInteger oldSelectIndex;
    FBKVOController *loginObserver;
    FBKVOController *leftViewObserver;
    
    BOOL isGoBack;
}
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
}

- (void)initNotifyRegister
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLeftView) name:kLeftViewPushMessage object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popLeftView) name:kLeftViewPopMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginViewController:) name:kLoginForUserMessage object:nil];
}

- (void)initTabViewController
{
    UIViewController* firstVC = [[FactoryModel shareFactoryModel] getFirstViewController];
    firstNav = [[LSNavigationController alloc] initWithRootViewController:firstVC];
    
    UIViewController* secondVC = [[FactoryModel shareFactoryModel] getSecondViewController];
    secondNav = [[LSNavigationController alloc] initWithRootViewController:secondVC];
    
    UIViewController* thirdVC = [[FactoryModel shareFactoryModel] getThirdViewController];
    thirdNav = [[LSNavigationController alloc] initWithRootViewController:thirdVC];
    
    UIViewController* fourthVC = [[FactoryModel shareFactoryModel] getFourthViewController];
    fourthNav = [[LSNavigationController alloc] initWithRootViewController:fourthVC];

    self.viewControllers = @[firstNav,secondNav,thirdNav,fourthNav];
}

- (void)initTabBarItem
{
    //[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBarItem_sel"]]];
    if(kSystemVersion<7.0)
    {
        UIImage *img = [[UIImage imageNamed:@"tabbarBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [[UITabBar appearance] setBackgroundImage:img];
    }
    for(int i=0; i<4;i++)
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
    MLOG(@"shouldtabsel = %lu", (unsigned long)tabBarController.selectedIndex);
    oldSelectIndex = tabBarController.selectedIndex;
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    MLOG(@"tabsel = %ld", (unsigned long)tabBarController.selectedIndex);
    newSelectIndex = tabBarController.selectedIndex;
}


#pragma mark show login
- (void)showLoginViewController:(NSNotification *)aNotification
{
    
//    if(aNotification.object)
//    {
//        isGoBack = [[aNotification object] boolValue]; ///yes为goback  其他的不处理
//    }
//    __weak RootTabBarController *weakself = self;
//    if (![HbhUser sharedHbhUser].isLogin)
//    {
//        if(!self.loginVC)
//        {
//            self.loginVC = [[HbhLoginViewController alloc] init];
//        }
//        if(!self.loginNav)
//        {
//            self.loginNav = [[UINavigationController alloc] initWithRootViewController:self.loginVC];
//            
//        }
//
//        [self presentViewController:self.loginNav animated:YES completion:^{
//            
//        }];
//        if(!loginObserver)
//        {
//            loginObserver = [[FBKVOController alloc] initWithObserver:self];
//        }
//        [loginObserver observe:self.loginVC keyPath:@"type" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
//            int type = [[change objectForKey:@"new"] intValue];
//            if(type == eLoginSucc)
//            {
//
//            }
//            else if(type == eLoginBack)
//            {
//                if(isGoBack)
//                {
//                    weakself.selectedIndex = oldSelectIndex;
//                    isGoBack = NO;
//                }
//            }
//            [weakself.loginNav dismissViewControllerAnimated:YES completion:^{
//                
//            }];
//        }];
//    }
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
