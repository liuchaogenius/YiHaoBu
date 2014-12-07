//
//  YHBSupplyDetailManage.m
//  YHB_Prj
//
//  Created by Johnny's on 14/12/7.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBSupplyDetailManage.h"
#import "NetManager.h"

@implementation YHBSupplyDetailManage

- (void)getSupllyDetailWithItemid:(int)aItemId SuccessBlock:(void(^)(YHBSupplyDetailModel *aModel))aSuccBlock andFailBlock:(void(^)(void))aFailBlock
{
    NSString *supplyDetailUrl = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Cm58clJlBmBqVV02Zgt5FQc3CWggLFxicnlfO0cgOV0pSAU7A2NcNgkwQnd7QX4fIBgHMi0YZ15/Hg1kCW9VYwpgfBpSNgY4agFdamZeeUMHYQk+IBZcNnJJXwZHJQ",@"token", [NSString stringWithFormat:@"%d", aItemId], @"itemid",nil];
    kYHBRequestUrl(@"getSellDetail.php", supplyDetailUrl);
    [NetManager requestWith:dict url:supplyDetailUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSDictionary *dataDict = [successDict objectForKey:@"data"];
        YHBSupplyDetailModel *model = [YHBSupplyDetailModel modelObjectWithDictionary:dataDict];
        aSuccBlock(model);
    } failure:^(NSDictionary *failDict, NSError *error) {
        
    }];

}
@end
