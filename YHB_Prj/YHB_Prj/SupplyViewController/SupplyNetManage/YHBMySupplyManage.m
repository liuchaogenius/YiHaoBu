//
//  YHBMySupplyManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/26.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBMySupplyManage.h"
#import "NetManager.h"
#import "YHBSupplyModel.h"

BOOL isSupply;
int pagesize;
int supplyPageid;
int buyPageid;
int supplyPagetotal;
int buyPagetotal;
@implementation YHBMySupplyManage

-(void)getSupplyArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(void))aFailBlock isSupply:(BOOL)aBool
{
    supplyPageid = 1;
    buyPageid = 1;
    pagesize = 20;
    isSupply = aBool;
    NSString *supplyUrl = nil;
    NSDictionary *dict;
#warning userid czx
    dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",@"1",@"userid",nil];
    if (isSupply)
    {
        kYHBRequestUrl(@"getSellList.php", supplyUrl);
    }
    else
    {
        kYHBRequestUrl(@"getBuyList.php", supplyUrl);
    }
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        //        MLOG(@"%@", successDict);
        NSDictionary *dataDict = [successDict objectForKey:@"data"];
        NSDictionary *pageDict = [dataDict objectForKey:@"page"];
        if (isSupply)
        {
            supplyPagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
        }
        else
        {
            buyPagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
        }
        NSArray *rslistArray = [dataDict objectForKey:@"rslist"];
        NSMutableArray *resultArray = [NSMutableArray new];
        for (int i=0; i<rslistArray.count; i++)
        {
            NSDictionary *dict = [rslistArray objectAtIndex:i];
            YHBSupplyModel *model = [YHBSupplyModel modelObjectWithDictionary:dict];
            [resultArray addObject:model];
        }
        aSuccBlock(resultArray);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}

-(void)getNextSupplyArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(void))aFailBlock
{
    int pageTotal = isSupply?supplyPagetotal:buyPagetotal;
    int pageId = isSupply?supplyPageid:buyPageid;
    if (pagesize*pageId<pageTotal)
    {
        if (isSupply)
        {
            supplyPageid++;
        }
        else
        {
            buyPageid++;
        }
        NSString *supplyUrl = nil;
        NSDictionary *dict;
#warning userid czx
        dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageId],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",@"1",@"userid",nil];
        if (isSupply)
        {
            kYHBRequestUrl(@"getSellList.php", supplyUrl);
        }
        else
        {
            kYHBRequestUrl(@"getBuyList.php", supplyUrl);
        }
        [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
            //        MLOG(@"%@", successDict);
            NSDictionary *dataDict = [successDict objectForKey:@"data"];
            NSDictionary *pageDict = [dataDict objectForKey:@"page"];
            if (isSupply)
            {
                supplyPagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
            }
            else
            {
                buyPagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
            }
            NSArray *rslistArray = [dataDict objectForKey:@"rslist"];
            NSMutableArray *resultArray = [NSMutableArray new];
            for (int i=0; i<rslistArray.count; i++)
            {
                NSDictionary *dict = [rslistArray objectAtIndex:i];
                YHBSupplyModel *model = [YHBSupplyModel modelObjectWithDictionary:dict];
                [resultArray addObject:model];
            }
            aSuccBlock(resultArray);
        } failure:^(NSDictionary *failDict, NSError *error) {
            aFailBlock();
        }];

    }
}

@end
