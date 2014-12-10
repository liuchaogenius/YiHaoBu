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

@implementation YHBShopCartManage

- (void)getShopCartArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(void))aFailBlock
{
    NSString *shopCartUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"NlJQXmtcXzltUngTQy5kCAw8ZQQqJmFfSENGIgluG38IaVxiQSFvBWhReUxxS0YnXmZ7Tg86CzJlBA1kXTstGzZcUDZrD19hbQZ4T0N7ZF4MamVSKhxhC0hzRh8Jaw",@"token",nil];
    
    kYHBRequestUrl(@"getCartList.php", shopCartUrl);
    [NetManager requestWith:dict url:shopCartUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSDictionary *dataDict = [successDict objectForKey:@"data"];
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

//- (void)getNextShopCartArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(void))aFailBlock
//{
//    
//}

@end
