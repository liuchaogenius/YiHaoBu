//
//  YHBUserManager.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/15.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YHBUserManager : NSObject

+ (YHBUserManager *)sharedManager;

//用户登陆网络请求
- (void)loginWithPhone:(NSString *)phone andPassWord:(NSString *)password withSuccess:(void(^)())sBlock failure:(void(^)(int result, NSString *errorStr))fBlock;
//用户找回密码
- (void)findPasswordWithPhone:(NSString *)phone newPassword:(NSString *)new checkcode:(NSString *)checkcode Success:(void(^)())sBlock failure:(void(^)(NSInteger result,NSString *resultString))fBlock;

//用户修改密码网络请求
//- (void)changePassWordWithOldPwd:(NSString *)oldpwd andNewPwd:(NSString *)newpwd andComfirmPwd:(NSString *)comfirmpwd Success:(void(^)())sBlock failure:(void(^)(NSInteger result,NSString *resultString))fBlock;

//注册获取验证码
- (void)getCheckCodeWithPhone : (NSString *)phone Success:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock;

//注册账号
- (void)registerWithPhone:(NSString *)phone checkCode:(NSString *)checkcode passWord:(NSString *)password withSuccess:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock;

@end
