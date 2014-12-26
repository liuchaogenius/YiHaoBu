//
//  PushPriceManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/21.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "PushPriceManage.h"
#import "NetManager.h"

@implementation PushPriceManage

- (void)pushPriceManageWithItemId:(int)aItemId price:(float)aPrice content:(NSString *)aContent typeid:(int)aTypeid succBlock:(void (^)(void))aSuccBlock andFailBlock:(void (^)(void))aFailBlock
{
    NSString *supplyDetailUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", aItemId], @"itemid",@"NlJQXmtcXzltUngTQy5kCAw8ZQQqJmFfSENGIgluG38IaVxiQSFvBWhReUxxS0YnXmZ7Tg86CzJlBA1kXTstGzZcUDZrD19hbQZ4T0N7ZF4MamVSKhxhC0hzRh8Jaw",@"token",[NSString stringWithFormat:@"%.2f", aPrice],@"price",aContent,@"content",[NSString stringWithFormat:@"%d", aTypeid],@"typeid",nil];
    kYHBRequestUrl(@"postBuyPrice.php", supplyDetailUrl);
    [NetManager requestWith:dict url:supplyDetailUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        aSuccBlock();
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock();
    }];
}
@end
