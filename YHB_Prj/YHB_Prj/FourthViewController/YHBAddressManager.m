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

@end
