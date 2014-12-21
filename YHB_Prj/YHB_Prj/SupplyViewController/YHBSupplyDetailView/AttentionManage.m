//
//  AttentionManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "AttentionManage.h"
#import "NetManager.h"

@implementation AttentionManage

- (void)changeLikeStatusAction:(NSString *)aAction itemid:(int)aId SuccBlock:(void (^)(void))aSuccBlock andFailBlock:(void (^)(void))aFailBlock
{
    NSString *shopCartUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aAction,@"action",aId,"itemid",nil];
    kYHBRequestUrl(@"postFavorite.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@",successDict);
        aSuccBlock();
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}
@end
