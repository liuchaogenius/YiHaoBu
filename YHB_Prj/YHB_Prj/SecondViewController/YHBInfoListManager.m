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
#import "YHBUser.h"
#import "YHBCRslist.h"
#import "YHBSupplyModel.h"

@interface YHBInfoListManager()

@property (strong, nonatomic) NSArray *actionArray;

@end

@implementation YHBInfoListManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static YHBInfoListManager *sharedManger;
    dispatch_once(&once, ^{
        sharedManger = [[YHBInfoListManager alloc] init];
    });
    return sharedManger;
}

- (NSArray *)actionArray
{
    if (!_actionArray) {
        _actionArray = @[@"company",@"sell",@"buy",@"mall"];
    }
    return _actionArray;
}
//NSString *error = successDict[@"error"];
- (void)getProductListWithUserID:(NSInteger)userID typeID:(NSInteger)typeID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock
{
    [self searchProductListWithUserID:userID typeID:typeID KeyWord:nil cateID:nil PageID:pageID pageSize:pageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
        sBlock(modelArray,page);
    } failure:^(NSString *error){
        if(fBlock) fBlock(error);
    }];
}

- (void)searchProductListWithUserID:(NSInteger)userID typeID:(NSInteger)typeID KeyWord:(NSString *)keyWord cateID:(NSString *)cateID PageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getMallList.php", url);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:7];
    if ([YHBUser sharedYHBUser].token.length) {
        [postDic setObject:[YHBUser sharedYHBUser].token forKey:@"token"];
    }
    if (userID != kAll) {
        [postDic setObject:[NSNumber numberWithInteger:userID] forKey:@"userid"];
    }
    if (typeID != kAll) {
        [postDic setObject:[NSNumber numberWithInteger:typeID] forKey:@"typeid"];
    }
    if (keyWord.length) {
        [postDic setObject:keyWord forKey:@"keyword"];
    }
    if (cateID.length) {
        [postDic setObject:cateID forKey:@"catid"];
    }
    [postDic setObject:[NSNumber numberWithInteger:pageID] forKey:@"pageid"];
    [postDic setObject:[NSNumber numberWithInteger:pageSize] forKey:@"pagesize"];
    
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
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
                fBlock(kErrorStr);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(kNoNet);
    }];
}

- (void)getSellListWithUserID:(NSInteger)userID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock
{
    [self searchSellListWithUserID:userID KeyWord:nil cateID:nil Vip:kAll pageID:pageID pageSize:pageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
        sBlock(modelArray,page);
    } failure:^(NSString *error){
        if(fBlock) fBlock(error);
    }];
}

- (void)searchSellListWithUserID:(NSInteger)userID KeyWord:(NSString *)keyWord cateID:(NSString *)cateID Vip:(NSInteger)vip pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getSellList.php", url);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:7];
    if ([YHBUser sharedYHBUser].token.length) {
        [postDic setObject:[YHBUser sharedYHBUser].token forKey:@"token"];
    }
    if (userID >0) {
        [postDic setObject:[NSNumber numberWithInteger:userID] forKey:@"userid"];
    }
    if (vip != kAll) {
        [postDic setObject:[NSNumber numberWithInteger:vip] forKey:@"vip"];
    }
    if (keyWord.length) {
        [postDic setObject:keyWord forKey:@"keyword"];
    }
    if (cateID.length) {
        [postDic setObject:cateID forKey:@"catid"];
    }
    [postDic setObject:[NSNumber numberWithInteger:pageID] forKey:@"pageid"];
    [postDic setObject:[NSNumber numberWithInteger:pageSize] forKey:@"pagesize"];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBPage *page = [YHBPage modelObjectWithDictionary:(NSDictionary *)data[@"page"]];
            NSArray *array = data[@"rslist"];
            NSMutableArray *modelArray = [NSMutableArray array];
            if (array.count > 0) {
                for (int i=0; i < array.count; i++) {
                    YHBSupplyModel *list = [YHBSupplyModel modelObjectWithDictionary:(NSDictionary *)array[i]];
                    modelArray[i] = list;
                }
            }
            if (sBlock) {
                sBlock(modelArray,page);
            }
        }else{
            if (fBlock) {
                fBlock(kErrorStr);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(kNoNet);
    }];
}

//获取/搜索求购信息列表
- (void)getBuyListWithUserID:(NSInteger)userID pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock
{
    [self searchBuyListWithUserID:userID KeyWord:nil cateID:nil pageID:pageID Vip:kAll pageSize:pageSize Success:^(NSMutableArray *modelArray, YHBPage *page) {
        sBlock(modelArray,page);
    } failure:^(NSString *error){
        if(fBlock) fBlock(error);
    }];
}

- (void)searchBuyListWithUserID:(NSInteger)userID KeyWord:(NSString *)keyWord cateID:(NSString *)cateID pageID:(NSInteger)pageID Vip:(NSInteger)vip pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock{
    NSString *url = nil;
    kYHBRequestUrl(@"getBuyList.php", url);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:7];
    if ([YHBUser sharedYHBUser].token.length) {
        [postDic setObject:[YHBUser sharedYHBUser].token forKey:@"token"];
    }
    if (userID) {
        [postDic setObject:[NSNumber numberWithInteger:userID] forKey:@"userid"];
    }
    if (vip != kAll) {
        [postDic setObject:[NSNumber numberWithInteger:vip] forKey:@"vip"];
    }
    if (keyWord.length) {
        [postDic setObject:keyWord forKey:@"keyword"];
    }
    if (cateID.length) {
        [postDic setObject:cateID forKey:@"catid"];
    }
    [postDic setObject:[NSNumber numberWithInteger:pageID] forKey:@"pageid"];
    [postDic setObject:[NSNumber numberWithInteger:pageSize] forKey:@"pagesize"];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBPage *page = [YHBPage modelObjectWithDictionary:(NSDictionary *)data[@"page"]];
            NSArray *array = data[@"rslist"];
            NSMutableArray *modelArray = [NSMutableArray array];
            if (array.count > 0) {
                for (int i=0; i < array.count; i++) {
                    YHBSupplyModel *list = [YHBSupplyModel modelObjectWithDictionary:(NSDictionary *)array[i]];
                    modelArray[i] = list;
                }
            }
            if (sBlock) {
                sBlock(modelArray,page);
            }
        }else{
            if (fBlock) {
                fBlock(kErrorStr);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(kNoNet);
    }];
}

- (void)searchCompanyListWithKeyWord:(NSString *)keyWord cateID:(NSString *)cateID Vip:(int)vip pageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getCompanyList.php", url);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:6];
    if ([YHBUser sharedYHBUser].token.length) {
        [postDic setObject:[YHBUser sharedYHBUser].token forKey:@"token"];
    }
    if (vip != kAll) {
        [postDic setObject:[NSNumber numberWithInteger:vip] forKey:@"vip"];
    }
    if (keyWord.length) {
        [postDic setObject:keyWord forKey:@"keyword"];
    }
    if (cateID.length) {
        [postDic setObject:cateID forKey:@"catid"];
    }
    [postDic setObject:[NSNumber numberWithInteger:pageID] forKey:@"pageid"];
    [postDic setObject:[NSNumber numberWithInteger:pageSize] forKey:@"pagesize"];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBPage *page = [YHBPage modelObjectWithDictionary:(NSDictionary *)data[@"page"]];
            NSArray *array = data[@"rslist"];
            NSMutableArray *modelArray = [NSMutableArray array];
            if (array.count > 0) {
                for (int i=0; i < array.count; i++) {
                    YHBCRslist *list = [YHBCRslist modelObjectWithDictionary:(NSDictionary *)array[i]];
                    modelArray[i] = list;
                }
            }
            if (sBlock) {
                sBlock(modelArray,page);
            }
        }else{
            if (fBlock) {
                fBlock(kErrorStr);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(kNoNet);
    }];
}

- (void)getMyFavoriteWithToken:(NSString *)token Action:(GetPrivateTag)tag PageID:(NSInteger)pageID pageSize:(NSInteger)pageSize Success:(void(^)(NSMutableArray *modelArray,YHBPage *page))sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:4];
    if (tag == Get_Company) {
        kYHBRequestUrl(@"getFriend.php", url);
    }else{
        kYHBRequestUrl(@"getFavorite.php", url);
        [postDic setObject:self.actionArray[tag] forKey:@"action"];
    }
    if ([YHBUser sharedYHBUser].token.length) {
        [postDic setObject:[YHBUser sharedYHBUser].token forKey:@"token"];
    }
    [postDic setObject:[NSNumber numberWithInteger:pageID] forKey:@"pageid"];
    [postDic setObject:[NSNumber numberWithInteger:pageSize] forKey:@"pagesize"];

    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBPage *page = [YHBPage modelObjectWithDictionary:(NSDictionary *)data[@"page"]];
            NSArray *array = data[@"rslist"];
            NSMutableArray *modelArray = [NSMutableArray array];
            if (array.count > 0) {
                
                for (int i=0; i < array.count; i++) {
                    if(tag == Get_Buy || tag == Get_Sell){
                        YHBSupplyModel *list = [YHBSupplyModel modelObjectWithDictionary:(NSDictionary *)array[i]];
                        modelArray[i] = list;
                    }else if (tag == Get_Product){
                        YHBRslist *list = [YHBRslist modelObjectWithDictionary:(NSDictionary *)array[i]];
                        modelArray[i] = list;
                    }else if(tag == Get_Company){
                        YHBCRslist *list = [YHBCRslist modelObjectWithDictionary:(NSDictionary *)array[i]];
                        modelArray[i] = list;
                    }
                }
            }
            if (sBlock) {
                sBlock(modelArray,page);
            }
                    
        }else{
            if (fBlock) {
                fBlock(kErrorStr);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(kNoNet);
    }];
}

@end
