//
//  YHBUser.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBUser.h"
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
    _nickName = nil;
    _userid = 0;
    _photoUrl = nil;
    _phone = nil;
    _role = 0;
    _shopid = 0;
    _encodedToken = nil;
    _localPhoto = nil;
    _statusIsChanged = NO;
    [self loadLocalUserInfo]; //判断沙箱是否有数据，并修改数据
    return self;
}

//加载本地用户文件数据
- (void)loadLocalUserInfo
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.userFilePath]) {
        NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:self.userFilePath];
        if (userDic[@"encodedToken"]) {
            NSString *encodedToken = userDic[@"encodedToken"];
            
            if (encodedToken.length) {
                [self loadUserInfoWithDictionary:userDic];
                [[NetManager shareInstance] setUserid:self.userid];
            }
        }
    }
}
//登陆用户
- (void)loginUserWithUserDictionnary:(NSDictionary *)userDic
{
    [self loadUserInfoWithDictionary:userDic];
    [self writeUserInfoToFile];
}

//退出登录
- (void)logoutUser
{
    _isLogin = NO;
    _encodedToken = @"";
    [self writeUserInfoToFile];
    
}

//加载用户数据 - 通过dic
- (void)loadUserInfoWithDictionary:(NSDictionary *)userDic
{
    _isLogin = YES;
    self.nickName = userDic[@"nickName"];
    self.userid = [[userDic objectForKey:@"id"] integerValue];
    //    if(self.userID)
    //    {
    //        [[NetManager shareInstance] setUserid:self.userID];
    //    }
    self.photoUrl = userDic[@"photoUrl"];
    self.phone = userDic[@"phone"];
    self.encodedToken = userDic[@"encodedToken"];
    self.localPhoto = userDic[@"localPhoto"];
    self.role = [[userDic objectForKey:@"role"] integerValue];
    self.shopid = [[userDic objectForKey:@"shopid"] integerValue];
}

//保存用户信息文件至沙箱
- (void)writeUserInfoToFile
{
    self.nickName = self.nickName?:@"";
    self.photoUrl = self.photoUrl?:@"";
    self.phone = self.phone?:@"";
    self.encodedToken = self.encodedToken?:@"";
    self.localPhoto = self.localPhoto ? :@"";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"nickName":self.nickName, @"userid":[NSNumber numberWithInteger:self.userid], @"photoUrl":self.photoUrl, @"phone":self.phone, @"role":[NSNumber numberWithInteger:self.role],@"shopid":[NSNumber numberWithInteger:self.shopid],@"encodedToken":self.encodedToken,@"localPhoto":self.localPhoto}];
    [dic writeToFile:self.userFilePath atomically:YES];
    //MLOG(@"%@",self.userFilePath);
}


@end
