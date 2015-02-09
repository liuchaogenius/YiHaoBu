//
//  GetUserNameManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/2/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "GetUserNameManage.h"
#import "NetManager.h"
#import "YHBUser.h"
#import "UserinfoBaseClass.h"

@implementation GetUserNameManage

- (void)getUserNameUseridArray:(NSMutableArray *)aArray succBlock:(void(^)(NSMutableArray *aMuArray))aSuccBlock failBlock:(void(^)(NSString *aStr))aFailBlock
{
    NSString *supplyUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",@"em",@"action",aArray,@"userid", nil];
    
    kYHBRequestUrl(@"getUser.php", supplyUrl);
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            NSDictionary *dataDict = [successDict objectForKey:@"data"];
//            NSDictionary *pageDict = [dataDict objectForKey:@"page"];
//            pagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
//            NSArray *rslistArray = [dataDict objectForKey:@"rslist"];
            NSMutableArray *resultArray = [NSMutableArray new];
            for (int i=0; i<aArray.count; i++)
            {
                NSString *key = [aArray objectAtIndex:i];
                NSDictionary *dict = [dataDict objectForKey:key];
                UserinfoBaseClass *model = [UserinfoBaseClass modelObjectWithDictionary:dict];
                [resultArray addObject:model];
            }
            aSuccBlock(resultArray);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];

}

@end
