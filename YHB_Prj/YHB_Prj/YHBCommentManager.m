//
//  YHBCommentManager.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBCommentManager.h"
#import "YHBComment.h"
#import "NetManager.h"
#import "YHBUser.h"
@implementation YHBCommentManager

- (void)getCommentListWithItemID:(NSInteger)itemID token:(NSString *)token Success:(void(^)(NSMutableArray *modelArray))sBlock failure:(void(^)(NSString *error))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getCommentList.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:itemID],@"itemid",token?:@"",@"token",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSArray *data = successDict[@"data"];
            NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:data.count];
            for (NSInteger i = 0; i < data.count; i++) {
                YHBComment *comment = [YHBComment modelObjectWithDictionary:(NSDictionary *)data[i]];
                modelArray[i] = comment;
            }
            if (sBlock) {
                sBlock(modelArray);
            }
        }else{
            NSString *error = successDict[@"error"];
            if (fBlock) {
                fBlock(error?:@"未知错误");
            }
        }
    }failure:^(NSDictionary *failDict, NSError *error) {
        if (fBlock) {
            fBlock(kNoNet);
        }
    }];
}

@end
