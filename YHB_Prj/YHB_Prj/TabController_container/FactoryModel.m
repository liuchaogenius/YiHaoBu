//
//  FactoryModel.m
//  YHB_Prj
//
//  Created by  striveliu on 14/12/3.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "FactoryModel.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
@interface FactoryModel()
{
    UIViewController *vc1;
    UIViewController *vc2;
    UIViewController *vc3;
    UIViewController *vc4;
}
@end
@implementation FactoryModel
+ (FactoryModel *)shareFactoryModel
{
    static FactoryModel *factoryModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(factoryModel == nil)
        {
            factoryModel = [[FactoryModel alloc] init];
        }
    });
    return factoryModel;
}

- (NSArray *)getTabbarArrys
{
    vc1 = [self getFirstViewController];
    vc2 = [self getSecondViewController];
    vc3 = [self getThirdViewController];
    vc4 = [self getFourthViewController];
    NSArray *arry = @[vc1,vc2,vc3,vc4];
    return arry;
}

- (UIViewController *)getFirstViewController
{
    if(!vc1)
    {
        vc1 = [[FirstViewController alloc] init];
    }
    return vc1;
}

- (UIViewController *)getSecondViewController
{
    if(!vc2)
    {
        vc2 = [[SecondViewController alloc] init];
    }
    return vc2;
}
- (UIViewController *)getThirdViewController
{
    if(!vc3)
    {
        vc3 = [[ThirdViewController alloc] init];
    }
    return vc3;
}

- (UIViewController *)getFourthViewController
{
    if(!vc4)
    {
        vc4 = [[FourthViewController alloc] init];
    }
    return vc4;
}

- (UIViewController *)getloginViewController
{
    return nil;
}
@end
