//
//  YHBAddressManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBAddressManager.h"
#import "YHBAddressModel.h"
#import "NetManager.h"
#import "YHBAreaModel.h"
@implementation YHBAddressManager

- (void)getDefaultAddressWithToken:(NSString *)token WithSuccess:(void(^)(YHBAddressModel *model))sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getAddress.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBAddressModel *model = [YHBAddressModel modelObjectWithDictionary:data];
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

- (void)getAddresslistWithToken:(NSString *)token WithSuccess:(void(^)(NSMutableArray *modelList))sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getAddressList.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:(token?:@""),@"token",@1,@"pageid",@30,@"pagesize",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            NSArray *array = data[@"rslist"];
            NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:array.count];
            for (int  i =0; i < array.count; i++) {
                YHBAddressModel *model = [YHBAddressModel modelObjectWithDictionary:(NSDictionary *)array[i]];
                [modelArray addObject:model];
            }
            if (sBlock) {
                sBlock(modelArray);
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

- (void)getAreaListWithSuccess:(void(^)(NSMutableArray *areaArray))sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getAreaList.php", url);
    [NetManager requestWith:nil url:url method:@"GET" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSArray *data = successDict[@"data"];
            NSMutableArray *areaArray = [NSMutableArray arrayWithCapacity:data.count];
            for (int i = 0; i < data.count; i ++) {
                YHBAreaModel *model = [YHBAreaModel modelObjectWithDictionary:(NSDictionary *)data[i]];
                areaArray[i] = model;
            }
            if (sBlock) {
                sBlock(areaArray);
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

- (void)addOrEditAddressWithAddModel:(YHBAddressModel *)model Token:(NSString *)token isNew:(BOOL)isNew WithSuccess:(void(^)())sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"postAddress.php", url);
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:7];
    [postDic setObject:(token?:@"") forKey:@"token"];
    [postDic setObject:model.truename?:@"" forKey:@"truename"];
    [postDic setObject:[NSNumber numberWithDouble:model.areaid] forKey:@"areaid"];
    [postDic setObject:model.address?: @"" forKey:@"address"];
    [postDic setObject:model.mobile?: @"" forKey:@"mobile"];
    [postDic setObject:[NSNumber numberWithInt:(int)model.ismain] forKey:@"ismain"];
    if(isNew) [postDic setObject:[NSNumber numberWithDouble:model.itemid] forKey:@"itemid"];
    
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            if (sBlock) {
                sBlock();
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

//删除常用地址 delAddress.php
- (void)deleteAddressWithToken:(NSString *)token AndItemID:(int)itemid WithSuccess:(void(^)())sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"delAddress.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:(token?:@""),@"token",[NSNumber numberWithInt:itemid],@"itemid",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            if (sBlock) {
                sBlock();
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
