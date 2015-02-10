//
//  jubaoManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/2/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "jubaoManage.h"
#import "YHBUser.h"
#import "NetManager.h"

@implementation jubaoManage

- (void)jubaoModuleid:(int)aModuleid itemid:(int)aItemid typeid:(int)aTypeid andintroduce:(NSString *)aIntroduce succBlock:(void(^)(void))aSuccBlock failBlock:(void(^)(NSString *aStr))aFailBlock
{
    NSString *supplyUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSString stringWithFormat:@"%d", aModuleid],@"mid",[NSString stringWithFormat:@"%d", aItemid],@"itemid",[NSString stringWithFormat:@"%d", aTypeid],@"typeid",aIntroduce,@"introduce",nil];

    kYHBRequestUrl(@"postReport.php", supplyUrl);
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
