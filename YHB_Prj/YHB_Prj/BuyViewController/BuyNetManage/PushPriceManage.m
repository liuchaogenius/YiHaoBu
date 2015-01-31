//
//  PushPriceManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "PushPriceManage.h"
#import "NetManager.h"
#import "YHBUser.h"

@implementation PushPriceManage

- (void)pushPriceManageWithItemId:(int)aItemId price:(float)aPrice content:(NSString *)aContent typeid:(int)aTypeid succBlock:(void (^)(void))aSuccBlock andFailBlock:(void (^)(NSString *aStr))aFailBlock
{
    NSString *supplyDetailUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", aItemId], @"itemid",token,@"token",[NSString stringWithFormat:@"%.2f", aPrice],@"price",aContent,@"content",[NSString stringWithFormat:@"%d", aTypeid],@"typeid",nil];
    kYHBRequestUrl(@"postBuyPrice.php", supplyDetailUrl);
    [NetManager requestWith:dict url:supplyDetailUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
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
