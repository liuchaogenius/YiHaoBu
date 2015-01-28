//
//  YHBPublishSupplyManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPublishSupplyManage.h"
#import "NetManager.h"

@implementation YHBPublishSupplyManage

- (void)publishSupplyWithItemid:(int)aItemId title:(NSString *)aTitle price:(NSString *)aPrice catid:(NSString *)aCatId typeid:(NSString *)aTypeid today:(NSString *)aToday content:(NSString *)aContent truename:(NSString *)aName mobile:(NSString *)aMobile andSuccBlock:(void(^)(int aItemId))aSuccBlock failBlock:(void (^)(NSString *aStr))aFailBlock
{
    NSString *supplyUrl = nil;
    NSDictionary *dict;
    if (aItemId)
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:aTitle,@"title",aPrice,@"price",aCatId,@"catid",aTypeid,@"typeid",aToday,@"today",aContent,@"content",aName,@"truename",aMobile,@"mobile",aItemId,@"itemid",nil];
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:aTitle,@"title",aPrice,@"price",aCatId,@"catid",aTypeid,@"typeid",aToday,@"today",aContent,@"content",aName,@"truename",aMobile,@"mobile",nil];
    }
    kYHBRequestUrl(@"postSell.php", supplyUrl);
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            NSDictionary *dict = [successDict objectForKey:@"data"];
            int itemid = [[dict objectForKey:@"itemid"] intValue];
            aSuccBlock(itemid);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];
}
@end
