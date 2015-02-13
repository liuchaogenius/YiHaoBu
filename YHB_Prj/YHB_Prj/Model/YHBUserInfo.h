//
//  YHBUserInfo.h
//
//  Created by   on 15/2/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBUserInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *catname;
@property (nonatomic, assign) double userid;
@property (nonatomic, assign) double selltotal;
@property (nonatomic, strong) NSString *star1;
@property (nonatomic, strong) NSString *business;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, assign) double friend;
@property (nonatomic, strong) NSString *empass;
@property (nonatomic, assign) double vcompany;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, assign) double groupid;
@property (nonatomic, assign) double buytotal;
@property (nonatomic, assign) double mall1total;
@property (nonatomic, assign) double mall0total;
@property (nonatomic, assign) double friendtotal;
@property (nonatomic, assign) double areaid;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *catid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) double malltotal;
@property (nonatomic, assign) double vtruename;
@property (nonatomic, strong) NSString *star2;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, assign) double credit;
@property (nonatomic, assign) double vmobile;
@property (nonatomic, strong) NSString *locking;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *introduce;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
