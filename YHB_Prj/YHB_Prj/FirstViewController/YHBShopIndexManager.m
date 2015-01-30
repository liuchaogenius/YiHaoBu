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
#import "YHBCompanyIndex.h"

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
            NSString *error = successDict[@"error"];
            fBlock((int)result,error);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-20,kNoNet);
    }];
}

- (void)getCompanyIndexWithSuccess:(void(^)(YHBCompanyIndex *model))sBlock failure:(void(^)(int result,NSString *errorString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getCompanyIndex.php", url);
    [NetManager requestWith:nil url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        // NSDictionary *data = successDict[@"data"];
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *dataDic = successDict[@"data"];
            //NSDictionary *dic = dataDic[@"shoplist"];
            YHBCompanyIndex *indexModel = [YHBCompanyIndex modelObjectWithDictionary:dataDic];
            sBlock(indexModel);
        }else{
            NSString *error = successDict[@"error"];
            fBlock((int)result,error);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-20,kNoNet);
    }];
}


@end
