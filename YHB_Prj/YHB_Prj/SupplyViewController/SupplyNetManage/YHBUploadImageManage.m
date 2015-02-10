//
//  YHBUploadImageManage.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/31.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBUploadImageManage.h"
#import "NetManager.h"
#import "YHBUser.h"

@implementation YHBUploadImageManage

- (void)uploadImageWithItemid:(NSString *)aItemid moduleid:(NSString *)aModuleid order:(NSString *)aOrder image:(UIImage *)aImage succBlock:(void(^)(void))aSuccBlock andFail:(void(^)(NSString *aStr))aFailBlock
{
    NSString *uploadUrl = nil;
    NSString *token = [YHBUser sharedYHBUser].token;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",@"album",@"action",aItemid,@"itemid",aModuleid,@"mid",aOrder,@"order",aImage,@"files",nil];
    kYHBRequestUrl(@"upload.php", uploadUrl);
    [NetManager requestWith:dict url:uploadUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        //        MLOG(@"%@", successDict);
        int result = [[successDict objectForKey:@"result"] intValue];
        kResult_11_CheckWithAlert;
        if (result != 1)
        {
            aFailBlock([successDict objectForKey:@"error"]);
        }
        else
        {
            aSuccBlock();
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        aFailBlock([failDict objectForKey:@"error"]);
    }];
}

@end
