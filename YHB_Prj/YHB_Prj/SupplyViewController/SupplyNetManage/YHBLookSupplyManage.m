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

BOOL isVip;
int pagesize;
int pageid;
@implementation YHBLookSupplyManage

- (void)getSupplyArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(void))aFailBlock isVip:(BOOL)aBool
{
    isVip = aBool;
    pagesize = 20;
    pageid = 1;
    NSString *supplyUrl = nil;
    NSDictionary *dict;
    if (isVip)
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Cm58clJlBmBqVV02Zgt5FQc3CWggLFxicnlfO0cgOV0pSAU7A2NcNgkwQnd7QX4fIBgHMi0YZ15/Hg1kCW9VYwpgfBpSNgY4agFdamZeeUMHYQk+IBZcNnJJXwZHJQ",@"token", @"1",@"vip",[NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
    }
    else
    {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Cm58clJlBmBqVV02Zgt5FQc3CWggLFxicnlfO0cgOV0pSAU7A2NcNgkwQnd7QX4fIBgHMi0YZ15/Hg1kCW9VYwpgfBpSNgY4agFdamZeeUMHYQk+IBZcNnJJXwZHJQ",@"token", [NSString stringWithFormat:@"%d", pageid],@"pageid",[NSString stringWithFormat:@"%d", pagesize],@"pagesize",nil];
    }
    
    kYHBRequestUrl(@"getSellList.php", supplyUrl);
    [NetManager requestWith:dict url:supplyUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSDictionary *dataDict = [successDict objectForKey:@"data"];
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
        
    }];
}

- (void)getNextSupplyArray:(void (^)(NSMutableArray *))aSuccBlock andFail:(void (^)(void))aFailBlock
{
    
}


@end
