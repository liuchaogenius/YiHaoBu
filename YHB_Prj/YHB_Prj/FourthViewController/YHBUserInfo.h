//
//  YHBUserInfo.h
//
//  Created by   on 14/12/1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBUserInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *catname;//订阅分类名称
@property (nonatomic, assign) NSInteger userid;//用户ID
@property (nonatomic, strong) NSString *introduce;//店铺简介/企业简介
@property (nonatomic, strong) NSString *business;//主营业务
@property (nonatomic, strong) NSString *company;//企业名称
@property (nonatomic, assign) int vcompany;//企业验证：1验证 0未验证
@property (nonatomic, strong) NSString *truename;//姓名
@property (nonatomic, assign) NSInteger groupid;//用户组：5个人用户，6企业用户，7VIP用户
@property (nonatomic, assign) NSInteger buytotal;//发布求购个数
@property (nonatomic, assign) NSInteger areaid;//地区ID
@property (nonatomic, strong) NSString *thumb;//店铺横幅banner
@property (nonatomic, strong) NSString *catid;//订阅分类ID
@property (nonatomic, strong) NSString *mobile;//手机
@property (nonatomic, assign) NSInteger malltotal;//发布产品个数
@property (nonatomic, assign) int vmobile;//手机验证，默认手机注册均验证
@property (nonatomic, strong) NSString *avatar;//头像
@property (nonatomic, strong) NSString *area;//省市地区
@property (nonatomic, assign) NSInteger credit;//积分
@property (nonatomic, assign) NSInteger selltotal;//发布供应个数
@property (nonatomic, strong) NSString *address;//地址

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
