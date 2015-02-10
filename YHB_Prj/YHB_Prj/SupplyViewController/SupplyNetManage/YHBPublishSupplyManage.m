//
//  YHBPublishSupplyManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPublishSupplyManage.h"
#import "NetManager.h"
#import "YHBUser.h"

@implementation YHBPublishSupplyManage

- (void)publishSupplyWithItemid:(int)aItemId title:(NSString *)aTitle price:(NSString *)aPrice catid:(NSString *)aCatId typeid:(NSString *)aTypeid today:(NSString *)aToday content:(NSString *)aContent truename:(NSString *)aName mobile:(NSString *)aMobile unit:(NSString *)aUnit photoArray:(NSArray *)aArray andSuccBlock:(void(^)(NSDictionary *aDict))aSuccBlock failBlock:(void (^)(NSString *aStr))aFailBlock
{
    NSString *supplyUrl = nil;
    NSDictionary *dict;
    YHBUser *user = [YHBUser sharedYHBUser];
    if (aItemId)
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:user.token,@"token",aTitle,@"title",aPrice,@"price",aCatId,@"catid",aTypeid,@"typeid",aToday,@"today",aContent,@"introduce",aName,@"truename",aMobile,@"mobile",[NSString stringWithFormat:@"%d", aItemId],@"itemid",aArray,@"album",aUnit,@"unit",nil];
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:user.token,@"token",aTitle,@"title",aPrice,@"price",aCatId,@"catid",aTypeid,@"typeid",aToday,@"today",aContent,@"introduce",aName,@"truename",aMobile,@"mobile",aArray,@"album",aUnit,@"unit",nil];
    }
    kYHBRequestUrl(@"postSell.php", supplyUrl);
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
        int result = [[successDict objectForKey:@"result"] intValue];
        kResult_11_CheckWithAlert;
        if (result != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            NSDictionary *dict = [successDict objectForKey:@"data"];
            aSuccBlock(dict);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];
}
@end
