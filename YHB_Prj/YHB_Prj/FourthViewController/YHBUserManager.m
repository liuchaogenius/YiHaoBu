//
//  YHBUserManager.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/15.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBUserManager.h"
#import "NetManager.h"
#import "YHBUser.h"

@implementation YHBUserManager

+ (YHBUserManager *)sharedManager
{
    static YHBUserManager *userManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        userManager = [[YHBUserManager alloc] init];
    });
    return userManager;
}

- (instancetype)init
{
    self = [super init];
    
    return self;
}

//登陆
- (void)loginWithPhone:(NSString *)phone andPassWord:(NSString *)password withSuccess:(void(^)())sBlock failure:(void(^)(int result, NSString *errorStr))fBlock
{
    NSString *loginUrl = nil;
    kYHBRequestUrl(@"login.php", loginUrl);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:phone ? phone:@"",@"mobile",password ? :@"",@"password", nil];
    [NetManager requestWith:postDic url:loginUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        MLOG(@"%@",successDict);
        int result = [successDict[@"result"] intValue];
        kResult_11_CheckWithAlert;
        if (result == 1) {
            NSDictionary *data = successDict[@"data"];
            [[YHBUser sharedYHBUser] loginUserWithUserToken:data[@"token"]];
            sBlock();
        }else{
            if (fBlock) {
                fBlock(result,kErrorStr);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        MLOG(@"%@",error.localizedDescription);
        if (fBlock){
            fBlock(-2,@"网络错误，请检查网络");
        }
    }];
}

- (void)getUserInfoWithToken:(NSString *)token orUserId:(NSString *)userId Success:(void(^)(NSDictionary *dataDic))sBlock failure:(void(^)())fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getUser.php", url);
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:2];
    if(token) [postDic setObject:token forKey:@"token"];
    else if(userId) [postDic setObject:userId forKey:@"userid"];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        kResult_11_CheckWithAlert;
        if (result) {
            NSDictionary *dataDic = successDict[@"data"];
         
            //[[YHBUser sharedYHBUser] loginUserWithUserDictionnary:dataDic];
            if (sBlock) {
                sBlock(dataDic);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        if (fBlock) {
            fBlock();
        }
    }];
}

- (void)findPasswordWithPhone:(NSString *)phone newPassword:(NSString *)new checkcode:(NSString *)checkcode Success:(void(^)())sBlock failure:(void(^)(NSInteger result,NSString *resultString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"findPassword.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:phone? : @"",@"mobile",new?: @"",@"password",checkcode? :@"",@"verifycode",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
       // NSDictionary *data = successDict[@"data"];
        NSInteger result = [successDict[@"result"] integerValue];
        if(result == 1){
            sBlock(); //成功
        }else {
            fBlock(result,kErrorStr);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-3,@"网络错误，请检查网络");
    }];
}

/*
- (void)changePassWordWithOldPwd:(NSString *)oldpwd andNewPwd:(NSString *)newpwd andComfirmPwd:(NSString *)comfirmpwd Success:(void(^)())sBlock failure:(void(^)(NSInteger result,NSString *resultString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"changePassword.ashx", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:oldpwd,@"oldpwd",newpwd,@"newpwd",comfirmpwd,@"comfirmpwd",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSDictionary *data = successDict[@"data"];
        NSInteger result = [data[@"result"] integerValue];
        if (result == 0) {
            fBlock(result,@"修改失败，请重新尝试");
        }else if(result == 1){
            sBlock(); //成功
        }else if(result == -1){
            fBlock(result,@"原始密码错误");
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-3,@"网络错误，请检查网络");
    }];
}
*/

- (void)getCheckCodeWithPhone : (NSString *)phone smstpl:(NSString *)sms Success:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"sendSms.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:phone? :@"",@"mobile",sms? :@"",@"smstpl",nil];
    
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        int result = [successDict[@"result"] intValue];
        if (result == 1){
            //成功
            sBlock();
        }else{
            fBlock(result,kErrorStr);
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-4,@"请求失败，请检查网络，稍后重试");
    }];
}

- (void)registerWithPhone:(NSString *)phone checkCode:(NSString *)checkcode passWord:(NSString *)password withSuccess:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"register.php", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:phone?: @"",@"mobile",checkcode? :@"",@"verifycode",password? :@"",@"password",nil];
    
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {

        int result = [successDict[@"result"] intValue];
        if (result == 1) {
            NSDictionary *dataDic = successDict[@"data"];
            NSString *token = dataDic[@"token"];
            [[YHBUser sharedYHBUser] loginUserWithUserToken:token];
            if (sBlock) {
                sBlock();
            }
        }else{
            if (fBlock) {
                fBlock(result,kErrorStr);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-5,@"网络错误");
    }];
}

- (void)editUserInfoWithInfoDic:(NSMutableDictionary *)dic withSuccess:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"postUser.php", url);
    [NetManager requestWith:dic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        NSInteger result = [successDict[@"result"] integerValue];
        if (result == 1) {
            if (sBlock) {
                sBlock();
            }
        }else{
            NSString *error = successDict[@"error"];
            if (fBlock) {
                fBlock((int)result,error);
            }
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-25,@"您的网络有点问题，请稍后再试");
    }];

}


@end
