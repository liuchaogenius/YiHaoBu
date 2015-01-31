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

- (void)saveBuyList:(NSMutableArray *)aArray
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    NSMutableArray *buylist = [self getBuylist];
    [buylist addObjectsFromArray:aArray];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"buylist%d",(int)user.userInfo.userid]:@"buylist";
    [ud setObject:buylist forKey:key];
}

- (NSMutableArray *)getBuylist
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"buylist%d",(int)user.userInfo.userid]:@"buylist";
    return [ud objectForKey:key];
}

- (void)saveSysList:(NSMutableArray *)aArray
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    NSMutableArray *syslist = [self getSyslist];
    [syslist addObjectsFromArray:aArray];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"syslist%d",(int)user.userInfo.userid]:@"syslist";
    [ud setObject:syslist forKey:key];
}

- (NSMutableArray *)getSyslist
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *key = user.isLogin?[NSString stringWithFormat:@"syslist%d",(int)user.userInfo.userid]:@"syslist";
    return [ud objectForKey:key];
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
