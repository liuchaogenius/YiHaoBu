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

//获取用户信息请求-传token获得个人信息 token=nil，传入userid时，获取他人信息 action:em|all 数据返回动作,正常为nil
- (void)getUserInfoWithToken:(NSString *)token orUserId:(NSString *)userId action:(NSString *)action Success:(void(^)(NSDictionary *dataDic))sBlock failure:(void(^)())fBlock;

//用户找回密码
- (void)findPasswordWithPhone:(NSString *)phone newPassword:(NSString *)new checkcode:(NSString *)checkcode Success:(void(^)())sBlock failure:(void(^)(NSInteger result,NSString *resultString))fBlock;

//用户修改密码网络请求
//- (void)changePassWordWithOldPwd:(NSString *)oldpwd andNewPwd:(NSString *)newpwd andComfirmPwd:(NSString *)comfirmpwd Success:(void(^)())sBlock failure:(void(^)(NSInteger result,NSString *resultString))fBlock;

//注册获取验证码 smstpl:短信模板-register:注册短信；findpassword:找回密码短信
- (void)getCheckCodeWithPhone : (NSString *)phone smstpl:(NSString *)sms Success:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock;

//注册账号
- (void)registerWithPhone:(NSString *)phone checkCode:(NSString *)checkcode passWord:(NSString *)password withSuccess:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock;

//修改用户信息
- (void)editUserInfoWithInfoDic:(NSMutableDictionary *)dic withSuccess:(void(^)())sBlock failure:(void(^)(int result,NSString *errorString))fBlock;
@end
