//
//  YHBUser.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBUser.h"
#import "YHBUserInfo.h"
#import "SynthesizeSingleton.h"
#import "NetManager.h"
@interface YHBUser()
@property (strong, nonatomic) NSString *userFilePath; //用户文件路径
//@property (strong, nonatomic) NSMutableDictionary *userInfoDic;//用户信息字典
@end

@implementation YHBUser
SYNTHESIZE_SINGLETON_FOR_CLASS(YHBUser);
#pragma mark - getter and setter
- (NSString *)userFilePath
{
    if (!_userFilePath) {
        NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = storeFilePath[0];
        _userFilePath = [docPath stringByAppendingPathComponent:@"user.plist"];
        //MLOG(@"%@",_userFilePath);
    }
    return _userFilePath;
}

- (id)init
{
    MLOG(@"%@",self.userFilePath);
    self = [super init];
    _isLogin = NO;
    _userInfo = nil;
    _statusIsChanged = NO;
    [self loadLocalUserInfo]; //判断沙箱是否有数据，并修改数据
    return self;
}

//加载本地用户文件数据
- (void)loadLocalUserInfo
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.userFilePath]) {
        NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:self.userFilePath];
        NSString *token = userDic[@"token"];
        NSData *infoData = userDic[@"userinfo"];
        NSDictionary *infoDic = [NSKeyedUnarchiver unarchiveObjectWithData:infoData];
        if (token.length && infoDic) {
            [self loadUserInfoWithDictionary:userDic];
            _isLogin = YES;
            [[NetManager shareInstance] setUserid:self.userInfo.userid];
        }
    }
}
//登陆用户
- (void)loginUserWithUserDictionnary:(NSDictionary *)userDic
{
    [self loadUserInfoWithDictionary:userDic];
    [self writeUserInfoToFile];
}

//登陆用户-传token
- (void)loginUserWithUserToken:(NSString *)token
{
    self.token = token;
    _isLogin = YES;
    [self writeUserInfoToFile];
}

//退出登录
- (void)logoutUser
{
    _isLogin = NO;
    _token = @"";
    [self writeUserInfoToFile];
    
}

//加载用户数据 - 通过dic
- (void)loadUserInfoWithDictionary:(NSDictionary *)userDic
{
    _isLogin = YES;
    self.token = userDic[@"token"];
    self.userInfo = [YHBUserInfo modelObjectWithDictionary:userDic];
}

//保存用户信息文件至沙箱
- (void)writeUserInfoToFile
{
    self.token = self.token ? :@"";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:self.token forKey:@"token"];
    if (self.userInfo.userid ) {
#warning have problem to be tested
        NSData *info = [NSKeyedArchiver archivedDataWithRootObject:self.userInfo];
        [dic setObject:info forKey:@"userInfo"];
    }
    [dic writeToFile:self.userFilePath atomically:YES];
    //MLOG(@"%@",self.userFilePath);
}


@end
