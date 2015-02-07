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
#import "YHBOConfirmModel.h"
#import "YHBUser.h"
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

- (void)getOrderListWithToken:(NSString *)token PageID:(NSInteger)pageid PageSize:(NSInteger)pageSize Success:(void (^)(YHBOrderList *listModel))sBlock failure:(void (^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getOrderList.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:(token.length?token:@""),@"token",[NSNumber numberWithInteger:pageid],@"pageid",[NSNumber numberWithInteger:pageSize],@"pagesize",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBOrderList *listmodel = [YHBOrderList modelObjectWithDictionary:data];
            if (sBlock) {
                sBlock(listmodel);
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

- (void)getOrderDetailWithToken:(NSString *)token ItemID:(NSInteger)itemID Success:(void (^)(YHBOrderDetail *model))sBlock failure:(void (^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getOrderDetail.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:token?:@"",@"token",[NSNumber numberWithInteger:itemID],@"itemid",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBOrderDetail *model = [YHBOrderDetail modelObjectWithDictionary:data];
            if (sBlock) {
                sBlock(model);
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

- (void)changeOrderStatusWithToken:(NSString *)token ItemID:(NSInteger)itemID Action:(NSString *)action Success:(void(^)())sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"postOrderStatus.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",[NSNumber numberWithInteger:itemID],@"itemid",action,@"action",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            if (sBlock) {
                sBlock();
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

- (void)getOrderConfirmWithToken:(NSString *)token source:(NSString *)source ListArray:(NSArray *)listArray Success:(void (^)(YHBOConfirmModel *model))sBlock failure:(void (^)(NSInteger result,NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getOrder.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",source,@"source",listArray,@"rslist",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBOConfirmModel *model = [YHBOConfirmModel modelObjectWithDictionary:data];
            if (sBlock) {
                sBlock(model);
            }
        }else{
            if (fBlock) {
                fBlock(result,kErrorStr);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-20,kNoNet);
    }];
}

- (void)getOrderTotalPriceWithPostDic:(NSDictionary *)postDic Success:(void(^)(NSString *totalPriceStr))sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"postOrder.php", url);
    static NSString *opKey = @"price";
    [NetManager cancelOperation:opKey];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:opKey parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            NSString *price = data[@"money"];
            if (sBlock) {
                sBlock(price);
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

//提交订单， info：支付宝相关字段
- (void)postOrderWithPostDic:(NSDictionary *)postDic Success:(void(^)(NSString *info))sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"postOrder.php", url);
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            NSString *info = data[@"info"];
            if (sBlock) {
                sBlock(info);
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
