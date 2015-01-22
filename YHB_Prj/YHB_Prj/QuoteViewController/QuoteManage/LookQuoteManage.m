//
//  LookQuoteManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "LookQuoteManage.h"
#import "NetManager.h"
#import "QuoteMeRslist.h"
#import "QuoteRslist.h"

BOOL isMe;
int pagesize;
int pageid;
int pagetotal;
@implementation LookQuoteManage

- (void)getQuoteArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(void))aFailBlock isMe:(BOOL)aBool
{
    isMe = aBool;
    pagesize = 20;
    pageid = 1;
    NSString *supplyUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize", nil];
    if (isMe)
    {
        kYHBRequestUrl(@"getBuyPriceToList.php", supplyUrl);
    }
    else
    {
        kYHBRequestUrl(@"getBuyPriceList.php", supplyUrl);
    }
    
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
            if (isMe)
            {
                QuoteMeRslist *model = [QuoteMeRslist modelObjectWithDictionary:dict];
                [resultArray addObject:model];
            }
            else
            {
                QuoteRslist *model = [QuoteRslist modelObjectWithDictionary:dict];
                [resultArray addObject:model];
            }
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
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize", nil];
        if (isMe)
        {
            kYHBRequestUrl(@"getBuyPriceToList.php", supplyUrl);
        }
        else
        {
            kYHBRequestUrl(@"getBuyPriceList.php", supplyUrl);
        }
        
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
                if (isMe)
                {
                    QuoteMeRslist *model = [QuoteMeRslist modelObjectWithDictionary:dict];
                    [resultArray addObject:model];
                }
                else
                {
                    QuoteRslist *model = [QuoteRslist modelObjectWithDictionary:dict];
                    [resultArray addObject:model];
                }
            }
            aSuccBlock(resultArray);
        } failure:^(NSDictionary *failDict, NSError *error) {
            aFailBlock();
        }];

    }
}

@end
