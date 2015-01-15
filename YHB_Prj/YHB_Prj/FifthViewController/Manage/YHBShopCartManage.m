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

int pageid;
int pagesize;
int pagetotal;
@implementation YHBShopCartManage

- (void)getShopCartArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(void))aFailBlock
{
    pageid=1;
    pagesize=10;
    NSString *shopCartUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"NlJQXmtcXzltUngTQy5kCAw8ZQQqJmFfSENGIgluG38IaVxiQSFvBWhReUxxS0YnXmZ7Tg86CzJlBA1kXTstGzZcUDZrD19hbQZ4T0N7ZF4MamVSKhxhC0hzRh8Jaw",@"token",[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
    kYHBRequestUrl(@"getCartList.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
//        MLOG(@"%@", successDict);
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
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];

}

- (void)getNextShopCartArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(void))aFailBlock
{
    if (pagesize*pageid<pagetotal)
    {
        pageid++;
        NSString *shopCartUrl = nil;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"NlJQXmtcXzltUngTQy5kCAw8ZQQqJmFfSENGIgluG38IaVxiQSFvBWhReUxxS0YnXmZ7Tg86CzJlBA1kXTstGzZcUDZrD19hbQZ4T0N7ZF4MamVSKhxhC0hzRh8Jaw",@"token",[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
        kYHBRequestUrl(@"getCartList.php", shopCartUrl);
        [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
            //        MLOG(@"%@", successDict);
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
        } failure:^(NSDictionary *failDict, NSError *error) {
            aFailBlock();
        }];
    }
}

- (void)changeShopCartWithArray:(NSArray *)aArray andSuccBlock:(void (^)(void))aSuccBlock failBlock:(void (^)(void))aFailBlock
{
    NSString *shopCartUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"NlJQXmtcXzltUngTQy5kCAw8ZQQqJmFfSENGIgluG38IaVxiQSFvBWhReUxxS0YnXmZ7Tg86CzJlBA1kXTstGzZcUDZrD19hbQZ4T0N7ZF4MamVSKhxhC0hzRh8Jaw",@"token",aArray,@"rslist",nil];
    kYHBRequestUrl(@"postCart.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        
        aSuccBlock();
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}

- (void)deleteShopCartWithArray:(NSArray *)aArray andSuccBlock:(void (^)(void))aSuccBlock failBlock:(void (^)(void))aFailBlock
{
    NSString *shopCartUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"NlJQXmtcXzltUngTQy5kCAw8ZQQqJmFfSENGIgluG38IaVxiQSFvBWhReUxxS0YnXmZ7Tg86CzJlBA1kXTstGzZcUDZrD19hbQZ4T0N7ZF4MamVSKhxhC0hzRh8Jaw",@"token",aArray,@"itemid",nil];
    kYHBRequestUrl(@"delCart.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        
        aSuccBlock();
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}

@end
