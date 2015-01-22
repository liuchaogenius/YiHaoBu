//
//  QuoteDetailManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/22.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "QuoteDetailManage.h"
#import "NetManager.h"
#import "PriceDetailRslist.h"

@implementation QuoteDetailManage

int itemid;
int pagesize;
int pageid;
int pagetotal;
- (void)getQuoteDetailForItemid:(int)aItemid succBlock:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(void))aFailBlock
{
    itemid = aItemid;
    pagesize = 20;
    pageid = 1;
    NSString *supplyUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",[NSString stringWithFormat:@"%d", itemid],@"itemid", nil];
    kYHBRequestUrl(@"getBuyPriceDetial.php", supplyUrl);
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSDictionary *dataDict = [successDict objectForKey:@"data"];
        NSDictionary *pageDict = [dataDict objectForKey:@"page"];
        pagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
        NSArray *rslistArray = [dataDict objectForKey:@"rslist"];
        NSMutableArray *resultArray = [NSMutableArray new];
        for (int i=0; i<rslistArray.count; i++)
        {
            NSDictionary *dict = [rslistArray objectAtIndex:i];
            PriceDetailRslist *model = [PriceDetailRslist modelObjectWithDictionary:dict];
            [resultArray addObject:model];
        }
        aSuccBlock(resultArray);
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];

}

- (void)getNextQuoteArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(void))aFailBlock
{
    if (pageid*pagesize<pagetotal)
    {
        pageid++;
        NSString *supplyUrl = nil;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",[NSString stringWithFormat:@"%d", itemid],@"itemid", nil];
        kYHBRequestUrl(@"getBuyPriceDetial.php", supplyUrl);
        [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
            MLOG(@"%@", successDict);
            NSDictionary *dataDict = [successDict objectForKey:@"data"];
            NSDictionary *pageDict = [dataDict objectForKey:@"page"];
            pagetotal = [[pageDict objectForKey:@"pagetotal"] intValue];
            NSArray *rslistArray = [dataDict objectForKey:@"rslist"];
            NSMutableArray *resultArray = [NSMutableArray new];
            for (int i=0; i<rslistArray.count; i++)
            {
                NSDictionary *dict = [rslistArray objectAtIndex:i];
                PriceDetailRslist *model = [PriceDetailRslist modelObjectWithDictionary:dict];
                [resultArray addObject:model];
            }
            aSuccBlock(resultArray);
        } failure:^(NSDictionary *failDict, NSError *error) {
            aFailBlock();
        }];

    }
}
@end
