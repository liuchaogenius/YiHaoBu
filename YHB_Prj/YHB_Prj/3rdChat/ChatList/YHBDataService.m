//
//  YHBDataService.m
//  Quansoso
//
//  Created by qf on 14/10/2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "YHBDataService.h"
#import "SynthesizeSingleton.h"
#import "YHBUser.h"
#import "YHBGetPushBuylist.h"
#import "YHBGetPushSyslist.h"

@interface YHBDataService ()
@property (nonatomic,strong) NSString *lastVersion;
@end

@implementation YHBDataService

+ (YHBDataService *)sharedYHBDataSevice
{
    static YHBDataService *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)saveData{
    [self saveSearchHistoryArr];
}

- (void)saveLastTime:(NSString *)aLastTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    [ud setValue:aLastTime forKey:@"time"];
}

- (NSString *)getLastTime
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    return [ud stringForKey:@"time"];
}


- (void)saveunreadSys:(BOOL)aBool
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    [ud setBool:aBool forKey:@"unreadSys"];
}

- (BOOL)getunreadSys
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    return [ud boolForKey:@"unreadSys"];
}

- (void)saveunreadBuy:(BOOL)aBool
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    [ud setBool:aBool forKey:@"unreadBuy"];
}

- (BOOL)getunreadBuy
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    return [ud boolForKey:@"unreadBuy"];
}

- (void)saveBuyList:(NSMutableArray *)aArray
{
    NSMutableArray *buylist = [self getBuylist];
    if (!buylist)
    {
        buylist = [NSMutableArray new];
    }
    for (int i=0; i<aArray.count; i++)
    {
        YHBGetPushBuylist *model = [aArray objectAtIndex:i];
        [buylist insertObject:model atIndex:i];
    }
    
    
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:buylist.count];
    for (YHBGetPushBuylist *model in buylist) {
        NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:model];
        [archiveArray addObject:personEncodedObject];
    }
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"buylist%d",(int)user.userInfo.userid]:@"buylist";
    [userData setObject:archiveArray forKey:key];
}

- (void)saveChangedBuyList:(NSMutableArray *)aArray
{
    NSMutableArray *buylist = [self getBuylist];
    if (!buylist)
    {
        buylist = [NSMutableArray new];
    }
    int length = (int)aArray.count;
    [buylist removeObjectsInRange:NSMakeRange(0, length)];
    for (int i=0; i<aArray.count; i++)
    {
        YHBGetPushBuylist *model = [aArray objectAtIndex:i];
        [buylist insertObject:model atIndex:i];
    }
    
    
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:buylist.count];
    for (YHBGetPushBuylist *model in buylist) {
        NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:model];
        [archiveArray addObject:personEncodedObject];
    }
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"buylist%d",(int)user.userInfo.userid]:@"buylist";
    [userData setObject:archiveArray forKey:key];
}

- (NSMutableArray *)getBuylist
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"buylist%d",(int)user.userInfo.userid]:@"buylist";
    NSArray *archiveArray = [ud objectForKey:key];
    
    NSMutableArray *oriArray = [NSMutableArray arrayWithCapacity:archiveArray.count];
    for (NSData *data in archiveArray)
    {
        YHBGetPushBuylist *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [oriArray addObject:model];
    }
    
    return oriArray;
}

- (void)saveSysList:(NSMutableArray *)aArray
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    NSMutableArray *syslist = [self getSyslist];
    if (!syslist) {
        syslist = [NSMutableArray new];
    }
    int syslistCount = (int)syslist.count;
    for (int i=0; i<aArray.count; i++)
    {
        YHBGetPushSyslist *model = [aArray objectAtIndex:aArray.count-i-1];
        [syslist insertObject:model atIndex:syslistCount+i];
    }
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:syslist.count];
    for (YHBGetPushSyslist *model in syslist) {
        NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:model];
        [archiveArray addObject:personEncodedObject];
    }
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"syslist%d",(int)user.userInfo.userid]:@"syslist";
    [userData setObject:archiveArray forKey:key];
}

- (NSMutableArray *)getSyslist
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"syslist%d",(int)user.userInfo.userid]:@"syslist";
    NSArray *archiveArray = [ud objectForKey:key];
    
    NSMutableArray *oriArray = [NSMutableArray arrayWithCapacity:archiveArray.count];
    for (NSData *data in archiveArray)
    {
        YHBGetPushSyslist *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [oriArray addObject:model];
    }
    
    return oriArray;
}

- (NSMutableArray *)searchHistoryArr{
    if (!_searchHistoryArr) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud synchronize];
        _searchHistoryArr = [ud mutableArrayValueForKey:@"SearchHistoryArr"];
    }
    return _searchHistoryArr;
}

- (void)saveSearchHistoryArr{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    NSInteger saveNum = 10;
    if(_searchHistoryArr.count > saveNum){
        [_searchHistoryArr removeObjectsInRange:NSMakeRange(saveNum, _searchHistoryArr.count-saveNum)];
    }
    [ud setValue:_searchHistoryArr forKey:@"SearchHistoryArr"];
}

@end
