//
//  YHBPivateManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/14.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBPrivateManager.h"
#import "NetManager.h"

@interface YHBPrivateManager()
@property (strong, nonatomic) NSArray *privateArray;
@end

@implementation YHBPrivateManager
//收藏类型   sell:供应 buy:求购 mall:产品 company:店铺
- (NSArray *)privateArray
{
    if (!_privateArray) {
        _privateArray = @[@"sell",@"buy",@"mall",@"company"];
    }
    return _privateArray;
}

- (void)privateOrDisPrivateWithItemID:(NSString *)itemID privateType:(NSInteger)privateType token:(NSString *)token Success:(void(^)())sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"postFavorite.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",itemID,@"itemid",self.privateArray[privateType],@"action",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
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

@end
