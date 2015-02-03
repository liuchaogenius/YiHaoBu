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
#import "YHBUser.h"

BOOL isMe;
int pagesize;
int pageid;
int pagetotal;
@implementation LookQuoteManage

- (void)getQuoteArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(NSString *aStr))aFailBlock isMe:(BOOL)aBool
{
    isMe = aBool;
    pagesize = 20;
    pageid = 1;
    NSString *supplyUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize", nil];
    if (isMe)
    {
        kYHBRequestUrl(@"getBuyPriceToList.php", supplyUrl);
    }
    else
    {
        kYHBRequestUrl(@"getBuyPriceList.php", supplyUrl);
    }
    
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//                MLOG(@"%@", successDict);
        int result = [[successDict objectForKey:@"result"] intValue];
        kResult_11_CheckWithAlert;
        if (result != 1)
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
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];
}

- (void)getNextQuoteArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock
{
    if (pageid*pagesize<pagetotal)
    {
        pageid++;
        NSString *supplyUrl = nil;
        NSString *token = [YHBUser sharedYHBUser].token;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize", nil];
        if (isMe)
        {
            kYHBRequestUrl(@"getBuyPriceToList.php", supplyUrl);
        }
        else
        {
            kYHBRequestUrl(@"getBuyPriceList.php", supplyUrl);
        }
        
        [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//            MLOG(@"%@", successDict);
            int result = [[successDict objectForKey:@"result"] intValue];
            kResult_11_CheckWithAlert;
            if (result != 1)

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
