//
//  YHBShopIndexManager.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopIndexManager.h"
#import "NetManager.h"
#import "YHBFirstPageIndex.h"

@implementation YHBShopIndexManager

- (void)getFirstPageIndexWithSuccess:(void(^)(YHBFirstPageIndex *model))sBlock failure:(void(^)(int result,NSString *errorString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getIndex.php", url);
    [NetManager requestWith:nil url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        // NSDictionary *data = successDict[@"data"];
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *dataDic = successDict[@"data"];
            //NSDictionary *dic = dataDic[@"shoplist"];
            YHBFirstPageIndex *indexModel = [YHBFirstPageIndex modelObjectWithDictionary:dataDic];
            sBlock(indexModel);
        }else{
            fBlock((int)result,@"获取信息失败，请稍后再试");
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-20,@"您的网路有些问题，请稍后再试");
    }];
}

/*
- (void)getShopIndexWithSuccess:(void(^)(YHBShopIndex *shopModel))sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getShopIndex.php", url);
    [NetManager requestWith:nil url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        // NSDictionary *data = successDict[@"data"];
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *dataDic = successDict[@"data"];
            NSDictionary *dic = dataDic[@"shoplist"];
            YHBShopIndex *indexModel = [YHBShopIndex modelObjectWithDictionary:dataDic];
            sBlock(indexModel);
        }else{
            fBlock();
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock();
    }];

}*/

@end
