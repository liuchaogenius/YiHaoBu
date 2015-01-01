//
//  YHBInfoListManager.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/25.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBInfoListManager.h"
#import "NetManager.h"
#import "YHBPage.h"
#import "YHBRslist.h"

@implementation YHBInfoListManager

- (void)getProductListWithUserID:(NSInteger)userID typeID:(NSInteger)typeID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getMallList.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"userid",[NSNumber numberWithInteger:typeID],@"typeid",[NSNumber numberWithInteger:pageID],@"pageid",[NSNumber numberWithInteger:pageSize],@"pagesize",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBPage *page = [YHBPage modelObjectWithDictionary:(NSDictionary *)data[@"page"]];
            NSArray *array = data[@"rslist"];
           // MLOG(@"%@",array);
            NSMutableArray *modelArray = [NSMutableArray array];
            if (array.count > 0) {
                for (int i=0; i < array.count; i++) {
                    YHBRslist *list = [YHBRslist modelObjectWithDictionary:(NSDictionary *)array[i]];
                    modelArray[i] = list;
                }
            }
            if (sBlock) {
                sBlock(modelArray,page);
            }
        }else{
            if (fBlock) {
                fBlock();
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock();
    }];
}

- (void)getSellListWithUserID:(NSInteger)userID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getSellList.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"userid",[NSNumber numberWithInteger:pageID],@"pageid",[NSNumber numberWithInteger:pageSize],@"pagesize",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBPage *page = [YHBPage modelObjectWithDictionary:(NSDictionary *)data[@"page"]];
            NSArray *array = data[@"rslist"];
            NSMutableArray *modelArray = [NSMutableArray array];
            if (array.count > 0) {
                for (int i=0; i < array.count; i++) {
                    YHBRslist *list = [YHBRslist modelObjectWithDictionary:(NSDictionary *)array[i]];
                    modelArray[i] = list;
                }
            }
            if (sBlock) {
                sBlock(modelArray,page);
            }
        }else{
            if (fBlock) {
                fBlock();
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock();
    }];
}

@end
