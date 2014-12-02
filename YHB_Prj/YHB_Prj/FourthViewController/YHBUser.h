//
//  YHBUser.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHBUserInfo;

@interface YHBUser : NSObject

@property (nonatomic,readonly) BOOL isLogin;//是否登录
@property (strong, nonatomic) YHBUserInfo *userInfo;//用户信息
@property (strong, nonatomic) NSString *token;

@property (nonatomic) BOOL statusIsChanged; //用户状态是否发生了变化

+ (YHBUser *)sharedYHBUser;
//通过token登陆
- (void)loginUserWithUserToken:(NSString *)token;
- (void)loginUserWithUserDictionnary:(NSDictionary *)userDic;

//退出登陆
- (void)logoutUser;
//保存文件至沙箱
- (void)writeUserInfoToFile;

@end
