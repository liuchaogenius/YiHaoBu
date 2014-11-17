//
//  YHBUser.h
//  YHB_Prj
//
//  Created by yato_kami on 14/11/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBUser : NSObject

@property (nonatomic,readonly) BOOL isLogin;//是否登录
@property (assign, nonatomic) NSInteger userid; //id
@property (strong, nonatomic) NSString *nickName; //昵称
@property (strong, nonatomic) NSString *photoUrl; //头像
@property (strong, nonatomic) NSString *localPhoto;//本地头像url
@property (strong, nonatomic) NSString *phone; //手机
@property (strong, nonatomic) NSString *encodedToken; //token
@property (assign, nonatomic) NSInteger role;//1已注册，2认证用户，3企业认证
@property (assign, nonatomic) NSInteger shopid;

@property (nonatomic) BOOL statusIsChanged; //用户状态是否发生了变化

+ (YHBUser *)sharedYHBUser;

/**
 *  登陆用户，并储存用户信息至沙箱
 *
 *  @param userDic 用户信息数组
 */
- (void)loginUserWithUserDictionnary:(NSDictionary *)userDic;

//退出登陆
- (void)logoutUser;
//保存文件至沙箱
- (void)writeUserInfoToFile;

@end
