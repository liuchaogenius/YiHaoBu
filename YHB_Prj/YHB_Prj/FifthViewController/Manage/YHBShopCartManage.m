//
//  YHBShopCartManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopCartManage.h"
#import "NetManager.h"
#import "YHBShopCartRslist.h"
#import "YHBUser.h"

int pageid;
int pagesize;
int pagetotal;
@implementation YHBShopCartManage

- (void)getShopCartArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock
{
    pageid=1;
    pagesize=10;
    NSString *shopCartUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
    kYHBRequestUrl(@"getCartList.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
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
                YHBShopCartRslist *model = [YHBShopCartRslist modelObjectWithDictionary:dict];
                [resultArray addObject:model];
            }
            aSuccBlock(resultArray);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];

}

- (void)getNextShopCartArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock
{
    if (pagesize*pageid<pagetotal)
    {
        pageid++;
        NSString *shopCartUrl = nil;
        NSString *token = [YHBUser sharedYHBUser].token;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
        kYHBRequestUrl(@"getCartList.php", shopCartUrl);
        [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
            //        MLOG(@"%@", successDict);
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
                    YHBShopCartRslist *model = [YHBShopCartRslist modelObjectWithDictionary:dict];
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

- (void)changeShopCartWithArray:(NSArray *)aArray andSuccBlock:(void (^)(void))aSuccBlock failBlock:(void (^)(NSString *aStr))aFailBlock
{
    NSString *shopCartUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",aArray,@"rslist",nil];
    kYHBRequestUrl(@"postCart.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
        int result = [[successDict objectForKey:@"result"] intValue];
        kResult_11_CheckWithAlert;
        if (result != 1)
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

- (void)deleteShopCartWithArray:(NSArray *)aArray andSuccBlock:(void (^)(void))aSuccBlock failBlock:(void (^)(NSString *aStr))aFailBlock
{
    NSString *shopCartUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",aArray,@"itemid",nil];
    kYHBRequestUrl(@"delCart.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
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
