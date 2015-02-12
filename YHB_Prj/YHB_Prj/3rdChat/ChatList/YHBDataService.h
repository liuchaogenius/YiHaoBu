//
//  YHBDataService.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBDataService : NSObject//<NSCoding>


@property (nonatomic,strong) NSMutableArray *searchHistoryArr;
@property (nonatomic,assign) BOOL pushIntroduceStatus;
+ (YHBDataService *)sharedYHBDataSevice;
- (void)saveData;

- (void)saveLastTime:(NSString *)aLastTime;
- (NSString *)getLastTime;

- (void)saveBuyList:(NSMutableArray *)aArray;
- (NSMutableArray *)getBuylist;
- (void)saveSysList:(NSMutableArray *)aArray;
- (NSMutableArray *)getSyslist;


- (void)saveunreadSys:(BOOL)aBool;

- (BOOL)getunreadSys;

- (void)saveunreadBuy:(BOOL)aBool;

- (BOOL)getunreadBuy;

@end
