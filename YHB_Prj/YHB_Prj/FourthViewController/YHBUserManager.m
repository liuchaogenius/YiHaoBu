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
    if (self = [self init]) {
        
    }
    return self;
}

//登陆
- (void)loginWithPhone:(NSString *)phone andPassWord:(NSString *)password withSuccess:(void(^)())sBlock failure:(void(^)(int result, NSString *errorStr))fBlock
{
    NSString *loginUrl = nil;
    kYHBRequestUrl(@"login.aspx", loginUrl);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:phone ? phone:@"",@"phone",password ? :@"",@"password", nil];
    
    [NetManager requestWith:postDic url:loginUrl method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        if ([successDict[@"result"] intValue] == 1) {
            NSDictionary *userDic = successDict[@"user"];
            [[YHBUser sharedYHBUser] loginUserWithUserDictionnary:userDic];
            sBlock();
        }else if ([successDict[@"result"] intValue] == 0){
            fBlock(0,@"账号或密码错误");
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        MLOG(@"%@",error.localizedDescription);
        if (fBlock){
            fBlock(-2,@"网络错误，请检查网络");
        }
    }];
}

- (void)findPasswordWithPhone:(NSString *)phone newPassword:(NSString *)new checkcode:(NSString *)checkcode Success:(void(^)())sBlock failure:(void(^)(NSInteger result,NSString *resultString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"findPassword.aspx", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",new,@"new",checkcode,@"checkcode",nil];
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
       // NSDictionary *data = successDict[@"data"];
        NSInteger result = [successDict[@"result"] integerValue];
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

- (void)getCheckCodeWithPhone : (NSString *)phone Success:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"getConfirmCode.aspx", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",nil];
    
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
        int result = [((NSDictionary *)successDict[@"data"])[@"result"] intValue];
        if ( result >= -1 && result <=0) {
            //已经注册
            fBlock(result,@"该手机号已被注册");
        }else if (result == -2){
            //2分钟只能发送1次
            fBlock(result,@"2分钟内只能发送一次验证码，请稍后重试");
        }else if (result == 0){
            //发送失败
            fBlock(result,@"验证码发送失败，请稍后重试");
        }else if (result == 1){
            //成功
            sBlock();
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-3,@"请求失败，请检查网络，稍后重试");
    }];
}

- (void)registerWithPhone:(NSString *)phone checkCode:(NSString *)checkcode passWord:(NSString *)password withSuccess:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock
{
    NSString *url = nil;
    kYHBRequestUrl(@"register.ashx", url);
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",checkcode,@"checkcode",password,@"password",nil];
    
    [NetManager requestWith:postDic url:url method:@"POST" operationKey:nil parameEncoding:AFJSONParameterEncoding succ:^(NSDictionary *successDict) {
#warning 待补完，未实现
        //NSDictionary *data = successDict[@"data"];
        int result = [successDict[@"result"] intValue];
        if (result == 1) {
            NSDictionary *userDic = successDict[@"user"];
            [[YHBUser sharedYHBUser] loginUserWithUserDictionnary:userDic];
            if (sBlock) {
                sBlock();
            }
        }else if(result == -1){
            fBlock(result,@"该手机已被注册");
        }else if(result == -3){
            fBlock(result,@"验证码错误");
        }else{
            fBlock(result,@"发生错误");
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        fBlock(-5,@"网络错误");
    }];
}


@end
