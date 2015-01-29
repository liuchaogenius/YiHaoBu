//
//  YHBBuyDetailManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBBuyDetailManage.h"
#import "NetManager.h"

@implementation YHBBuyDetailManage

-(void)getBuyDetailWithItemid:(int)aItemId SuccessBlock:(void (^)(YHBBuyDetailData *aModel))aSuccBlock andFailBlock:(void (^)(NSString *aStr))aFailBlock
{
    NSString *supplyDetailUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", aItemId], @"itemid",nil];
    kYHBRequestUrl(@"getBuyDetail.php", supplyDetailUrl);
    [NetManager requestWith:dict url:supplyDetailUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            NSDictionary *dataDict = [successDict objectForKey:@"data"];
            YHBBuyDetailData *model = [YHBBuyDetailData modelObjectWithDictionary:dataDict];
            aSuccBlock(model);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];
    
}


@end
