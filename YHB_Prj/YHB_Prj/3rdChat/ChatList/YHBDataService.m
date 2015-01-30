//
//  YHBDataService.m
//  Quansoso
//
//  Created by qf on 14/10/2.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "YHBDataService.h"
#import "SynthesizeSingleton.h"
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
    [ud setObject:buylist forKey:@"buylist"];
}

- (NSMutableArray *)getBuylist
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    return [ud objectForKey:@"buylist"];
}

- (void)saveSysList:(NSMutableArray *)aArray
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    NSMutableArray *syslist = [self getSyslist];
    [syslist addObjectsFromArray:aArray];
    [ud setObject:syslist forKey:@"syslist"];
}

- (NSMutableArray *)getSyslist
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    return [ud objectForKey:@"syslist"];
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
