//
//  YHBProductManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBProductManager.h"
#import "YHBProductDetail.h"
#import "NetManager.h"
@implementation YHBProductManager

- (void)getProductDetailInfoWithProductID:(NSInteger)productID token:(NSString *)token Success : (void(^)(YHBProductDetail *model))sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getMallDetail.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:productID],@"itemid",token ?: @"",@"token",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            YHBProductDetail *model = [YHBProductDetail modelObjectWithDictionary:data];
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
