//
//  YHBPublishBuyManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPublishBuyManage.h"
#import "NetManager.h"
#import "YHBUser.h"

@implementation YHBPublishBuyManage

- (void)publishBuyWithItemid:(int)aItemId title:(NSString *)aTitle catid:(NSString *)aCatId today:(NSString *)aToday content:(NSString *)aContent truename:(NSString *)aName mobile:(NSString *)aMobile unit:(NSString *)aUnit photoArray:(NSArray *)aArray amount:(NSString *)aAmount andSuccBlock:(void (^)(NSDictionary *aDict))aSuccBlock failBlock:(void (^)(NSString *aStr))aFailBlock
{
    NSString *supplyUrl = nil;
    NSDictionary *dict;
    NSString *token = [YHBUser sharedYHBUser].token;
    if (aItemId)
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",aTitle,@"title",aCatId,@"catid",aToday,@"today",aContent,@"introduce",aName,@"truename",aMobile,@"mobile",[NSString stringWithFormat:@"%d",aItemId],@"itemid",aUnit,@"unit",aArray,@"album",aAmount,@"amount",nil];
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",aTitle,@"title",aCatId,@"catid",aToday,@"today",aContent,@"introduce",aName,@"truename",aMobile,@"mobile",aUnit,@"unit",aArray,@"album",aAmount,@"amount",nil];
    }
    kYHBRequestUrl(@"postBuy.php", supplyUrl);
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
