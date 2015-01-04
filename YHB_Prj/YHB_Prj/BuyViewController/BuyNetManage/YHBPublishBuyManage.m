//
//  YHBPublishBuyManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/4.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPublishBuyManage.h"
#import "NetManager.h"

@implementation YHBPublishBuyManage

- (void)publishBuyWithItemid:(int)aItemId title:(NSString *)aTitle catid:(NSString *)aCatId today:(NSString *)aToday content:(NSString *)aContent truename:(NSString *)aName mobile:(NSString *)aMobile andSuccBlock:(void (^)(int aItemId))aSuccBlock failBlock:(void (^)(void))aFailBlock
{
    NSString *supplyUrl = nil;
    NSDictionary *dict;
    if (aItemId)
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:aTitle,@"title",aCatId,@"catid",aToday,@"today",aContent,@"content",aName,@"truename",aMobile,@"mobile",aItemId,@"itemid",nil];
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:aTitle,@"title",aCatId,@"catid",aToday,@"today",aContent,@"content",aName,@"truename",aMobile,@"mobile",nil];
    }
    kYHBRequestUrl(@"postBuy.php", supplyUrl);
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSDictionary *dict = [successDict objectForKey:@"data"];
        int itemid = [[dict objectForKey:@"itemid"] intValue];
        aSuccBlock(itemid);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}
@end
