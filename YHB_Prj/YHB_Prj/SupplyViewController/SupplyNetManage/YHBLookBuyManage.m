//
//  YHBLookBuyManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBLookBuyManage.h"
#import "NetManager.h"
#import "YHBSupplyModel.h"

@implementation YHBLookBuyManage

BOOL isVip;
int pagesize;
int pageid;
int pagetotal;

- (void)getBuyArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(NSString *aStr))aFailBlock isVip:(BOOL)aBool
{
    isVip = aBool;
    pagesize = 20;
    pageid = 1;
    NSString *supplyUrl = nil;
    NSDictionary *dict;
    if (isVip)
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",@"1",@"vip",@"0",@"typeid",nil];
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",@"0",@"typeid",nil];
    }
    
    kYHBRequestUrl(@"getBuyList.php", supplyUrl);
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        //        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            NSDictionary *dataDict = [successDict objectForKey:@"data"];
            NSDictionary *pageDict = [dataDict objectForKey:@"page"];
            pagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
            NSArray *rslistArray = [dataDict objectForKey:@"rslist"];
            NSMutableArray *resultArray = [NSMutableArray new];
            for (int i=0; i<rslistArray.count; i++)
            {
                NSDictionary *dict = [rslistArray objectAtIndex:i];
                YHBSupplyModel *model = [YHBSupplyModel modelObjectWithDictionary:dict];
                [resultArray addObject:model];
            }
            aSuccBlock(resultArray);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];
}

- (void)getNextBuyArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock
{
    if (pagesize*pageid<pagetotal)
    {
        pageid++;
        NSString *supplyUrl = nil;
        NSDictionary *dict;
        if (isVip)
        {
            dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",@"1",@"vip",nil];
        }
        else
        {
            dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
        }
        
        kYHBRequestUrl(@"getBuyList.php", supplyUrl);
        [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
            //        MLOG(@"%@", successDict);
            NSString *result = [successDict objectForKey:@"result"];
            if ([result intValue] != 1)
            {
                aFailBlock([successDict objectForKey:@"error"]);
            }
            else
            {
                NSDictionary *dataDict = [successDict objectForKey:@"data"];
                NSDictionary *pageDict = [dataDict objectForKey:@"page"];
                pagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
                NSArray *rslistArray = [dataDict objectForKey:@"rslist"];
                NSMutableArray *resultArray = [NSMutableArray new];
                for (int i=0; i<rslistArray.count; i++)
                {
                    NSDictionary *dict = [rslistArray objectAtIndex:i];
                    YHBSupplyModel *model = [YHBSupplyModel modelObjectWithDictionary:dict];
                    [resultArray addObject:model];
                }
                aSuccBlock(resultArray);
            }
        } failure:^(NSDictionary *failDict, NSError *error) {
            aFailBlock([failDict objectForKey:@"error"]);
        }];
    }
    else
    {
        aFailBlock(@"已无更多");
    }
}

@end
