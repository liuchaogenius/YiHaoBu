//
//  YHBGetPushManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBGetPushManage.h"
#import "YHBUser.h"
#import "YHBDataService.h"
#import "NetManager.h"
#import "YHBGetPushData.h"

@implementation YHBGetPushManage

- (void)getPushSucc:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock
{
    NSString *getPushUrl = nil;
    NSDictionary *dict = [NSDictionary new];
    YHBUser *user = [YHBUser sharedYHBUser];
    if (user.isLogin)
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:user.token,@"token", nil];
    }
    else
    {
        NSString *lastTime = [[YHBDataService sharedYHBDataSevice] getLastTime];
        if (lastTime)
        {
            dict = [NSDictionary dictionaryWithObjectsAndKeys:lastTime,@"lasttime", nil];
        }
        else
        {
            NSDate *localeDate=[NSDate date];
            lastTime = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
            dict = [NSDictionary dictionaryWithObjectsAndKeys:lastTime,@"lasttime", nil];
        }
    }
    kYHBRequestUrl(@"getPush.php", getPushUrl);
    [NetManager requestWith:dict url:getPushUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            NSDictionary *dataDict = [successDict objectForKey:@"data"];
            YHBGetPushData *data = [YHBGetPushData modelObjectWithDictionary:dataDict];
            [[YHBDataService sharedYHBDataSevice] saveLastTime:data.lasttime];
            NSMutableArray *resultArray = [[NSMutableArray alloc] initWithObjects:data.buylist,data.syslist, nil];
            aSuccBlock(resultArray);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];


}
@end
