//
//  AttentionManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "AttentionManage.h"
#import "NetManager.h"
#import "YHBUser.h"

@implementation AttentionManage

- (void)changeLikeStatusAction:(NSString *)aAction itemid:(int)aId SuccBlock:(void (^)(void))aSuccBlock andFailBlock:(void (^)(NSString *aStr))aFailBlock
{
    NSString *shopCartUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aAction,@"action",aId,"itemid",token,@"token",nil];
    kYHBRequestUrl(@"postFavorite.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
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
        aFailBlock(@"出现错误");
    }];
}
@end
