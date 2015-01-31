//
//  YHBCatManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/15.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBCatManage.h"
#import "YHBCatData.h"
#import "NetManager.h"

@implementation YHBCatManage

- (void)getDataArraySuccBlock:(void(^)(NSMutableArray *aArray))aSuccBlock andFailBlock:(void(^)(NSString *aStr))aFailBlock
{
    NSString *supplyDetailUrl = nil;
    NSDictionary *dict = [NSDictionary new];
    kYHBRequestUrl(@"getCategory.php", supplyDetailUrl);
    [NetManager requestWith:dict url:supplyDetailUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            NSMutableArray *reslutArray = [NSMutableArray new];
            NSArray *dataArray = [successDict objectForKey:@"data"];
            for (NSDictionary *dict in dataArray)
            {
                YHBCatData *model = [YHBCatData modelObjectWithDictionary:dict];
                [reslutArray addObject:model];
            }
            aSuccBlock(reslutArray);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];

}

@end
