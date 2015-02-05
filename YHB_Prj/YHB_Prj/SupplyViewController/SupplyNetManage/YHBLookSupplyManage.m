//
//  YHBLookSupplyManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/6.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBLookSupplyManage.h"
#import "NetManager.h"
#import "YHBSupplyModel.h"
//#import "YHBUser.h"

int mytypeid;
int pagesize;
int pageid;
int pagetotal;
@implementation YHBLookSupplyManage

- (void)getSupplyArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(NSString *aStr))aFailBlock andtypeid:(int)aTypeid
{
    mytypeid = aTypeid;
    pagesize = 20;
    pageid = 1;
//    YHBUser *user = [YHBUser sharedYHBUser];
    NSString *supplyUrl = nil;
    NSDictionary *dict;
    if (mytypeid==0)
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",[NSString stringWithFormat:@"%d", mytypeid-1],@"typeid",nil];
    }
    
    kYHBRequestUrl(@"getSellList.php", supplyUrl);
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

- (void)getNextSupplyArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock
{
    if (pagesize*pageid<pagetotal)
    {
        pageid++;
        NSString *supplyUrl = nil;
//        YHBUser *user = [YHBUser sharedYHBUser];
        NSDictionary *dict;
        if (mytypeid==0)
        {
            dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
        }
        else
        {
            dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",[NSString stringWithFormat:@"%d", mytypeid-1],@"typeid",nil];
        }
        kYHBRequestUrl(@"getSellList.php", supplyUrl);
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
