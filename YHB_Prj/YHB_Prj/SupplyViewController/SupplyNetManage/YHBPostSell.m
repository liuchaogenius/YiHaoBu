//
//  YHBPostSell.m
//  YHB_Prj
//
//  Created by Johnny's on 15/2/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPostSell.h"
#import "YHBUser.h"
#import "NetManager.h"

@implementation YHBPostSell

- (void)postItemid:(int)aItemid action:(NSString *)aAction typeid:(int)aTypeid succBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(NSString *aStr))aFailBlock
{
    NSString *supplyUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict;
    if ([aAction isEqualToString:@"type"])
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSString stringWithFormat:@"%d", aItemid],@"itemid",[NSString stringWithFormat:@"%d", aTypeid],@"typeid",aAction,@"action",nil];
        kYHBRequestUrl(@"postBuy.php", supplyUrl);
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSString stringWithFormat:@"%d", aItemid],@"itemid",aAction,@"action",nil];
        kYHBRequestUrl(@"postSell.php", supplyUrl);
    }
    
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            aSuccBlock();
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];
    
}

- (void)deleteItemWithItemid:(int)aItemid andIsSupply:(BOOL)aBool succBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(NSString *aStr))aFailBlock
{
    NSString *supplyUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSString stringWithFormat:@"%d", aItemid],@"itemid",nil];
    if (aBool==YES)
    {
        kYHBRequestUrl(@"delSell.php", supplyUrl);
    }
    else
    {
        kYHBRequestUrl(@"delBuy.php", supplyUrl);
    }
    
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            aSuccBlock();
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];
}

@end
