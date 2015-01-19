//
//  YHBOrderManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderManager.h"
#import "YHBOrderList.h"
#import "NetManager.h"
#import "YHBOrderDetail.h"
@implementation YHBOrderManager

+ (YHBOrderManager *)sharedManager
{
    static YHBOrderManager *orderManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        orderManager = [[YHBOrderManager alloc] init];
    });
    return orderManager;
}

- (void)getOrderListWithToken:(NSString *)token PageID:(NSInteger)pageid PageSize:(NSInteger)pageSize Success:(void (^)(YHBOrderList *listModel))sBlock failure:(void (^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getOrderList.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:(token.length?token:@""),@"token",[NSNumber numberWithInteger:pageid],@"pageid",[NSNumber numberWithInteger:pageSize],@"pagesize",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBOrderList *listmodel = [YHBOrderList modelObjectWithDictionary:data];
            if (sBlock) {
                sBlock(listmodel);
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

- (void)getOrderDetailWithToken:(NSString *)token ItemID:(NSInteger)itemID Success:(void (^)(YHBOrderDetail *model))sBlock failure:(void (^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getOrderDetail.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:token?:@"",@"token",[NSNumber numberWithInteger:itemID],@"itemid",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBOrderDetail *model = [YHBOrderDetail modelObjectWithDictionary:data];
            if (sBlock) {
                sBlock(model);
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
