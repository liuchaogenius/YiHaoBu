//
//  YHBUserInfo.m
//
//  Created by   on 14/12/1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBUserInfo.h"


NSString *const kYHBUserInfoCatname = @"catname";
NSString *const kYHBUserInfoUserid = @"userid";
NSString *const kYHBUserInfoSelltotal = @"selltotal";
NSString *const kYHBUserInfoStar1 = @"star1";
NSString *const kYHBUserInfoBusiness = @"business";
NSString *const kYHBUserInfoEmuser = @"emuser";
NSString *const kYHBUserInfoCompany = @"company";
NSString *const kYHBUserInfoFriend = @"friend";
NSString *const kYHBUserInfoEmpass = @"empass";
NSString *const kYHBUserInfoVcompany = @"vcompany";
NSString *const kYHBUserInfoTruename = @"truename";
NSString *const kYHBUserInfoGroupid = @"groupid";
NSString *const kYHBUserInfoBuytotal = @"buytotal";
NSString *const kYHBUserInfoAreaid = @"areaid";
NSString *const kYHBUserInfoThumb = @"thumb";
NSString *const kYHBUserInfoCatid = @"catid";
NSString *const kYHBUserInfoMobile = @"mobile";
NSString *const kYHBUserInfoMalltotal = @"malltotal";
NSString *const kYHBUserInfoStar2 = @"star2";
NSString *const kYHBUserInfoAvatar = @"avatar";
NSString *const kYHBUserInfoArea = @"area";
NSString *const kYHBUserInfoCredit = @"credit";
NSString *const kYHBUserInfoVmobile = @"vmobile";
NSString *const kYHBUserInfoAddress = @"address";
NSString *const kYHBUserInfoIntroduce = @"introduce";


@interface YHBUserInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBUserInfo

@synthesize catname = _catname;
@synthesize userid = _userid;
@synthesize selltotal = _selltotal;
@synthesize star1 = _star1;
@synthesize business = _business;
@synthesize emuser = _emuser;
@synthesize company = _company;
@synthesize friend = _friend;
@synthesize empass = _empass;
@synthesize vcompany = _vcompany;
@synthesize truename = _truename;
@synthesize groupid = _groupid;
@synthesize buytotal = _buytotal;
@synthesize areaid = _areaid;
@synthesize thumb = _thumb;
@synthesize catid = _catid;
@synthesize mobile = _mobile;
@synthesize malltotal = _malltotal;
@synthesize star2 = _star2;
@synthesize avatar = _avatar;
@synthesize area = _area;
@synthesize credit = _credit;
@synthesize vmobile = _vmobile;
@synthesize address = _address;
@synthesize introduce = _introduce;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.catname = [self objectOrNilForKey:kYHBUserInfoCatname fromDictionary:dict];
        self.userid = [[self objectOrNilForKey:kYHBUserInfoUserid fromDictionary:dict] integerValue];
        self.selltotal = [[self objectOrNilForKey:kYHBUserInfoSelltotal fromDictionary:dict] integerValue];
        self.star1 = [self objectOrNilForKey:kYHBUserInfoStar1 fromDictionary:dict];
        self.business = [self objectOrNilForKey:kYHBUserInfoBusiness fromDictionary:dict];
        self.emuser = [self objectOrNilForKey:kYHBUserInfoEmuser fromDictionary:dict];
        self.company = [self objectOrNilForKey:kYHBUserInfoCompany fromDictionary:dict];
        self.friend = [[self objectOrNilForKey:kYHBUserInfoFriend fromDictionary:dict] integerValue];
        self.empass = [self objectOrNilForKey:kYHBUserInfoEmpass fromDictionary:dict];
        self.vcompany = [[self objectOrNilForKey:kYHBUserInfoVcompany fromDictionary:dict] integerValue];
        self.truename = [self objectOrNilForKey:kYHBUserInfoTruename fromDictionary:dict];
        self.groupid = [[self objectOrNilForKey:kYHBUserInfoGroupid fromDictionary:dict] integerValue];
        self.buytotal = [[self objectOrNilForKey:kYHBUserInfoBuytotal fromDictionary:dict] integerValue];
        self.areaid = [[self objectOrNilForKey:kYHBUserInfoAreaid fromDictionary:dict] integerValue];
        self.thumb = [self objectOrNilForKey:kYHBUserInfoThumb fromDictionary:dict];
        self.catid = [self objectOrNilForKey:kYHBUserInfoCatid fromDictionary:dict];
        self.mobile = [self objectOrNilForKey:kYHBUserInfoMobile fromDictionary:dict];
        self.malltotal = [[self objectOrNilForKey:kYHBUserInfoMalltotal fromDictionary:dict] integerValue];
        self.star2 = [self objectOrNilForKey:kYHBUserInfoStar2 fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kYHBUserInfoAvatar fromDictionary:dict];
        self.area = [self objectOrNilForKey:kYHBUserInfoArea fromDictionary:dict];
        self.credit = [[self objectOrNilForKey:kYHBUserInfoCredit fromDictionary:dict] doubleValue];
        self.vmobile = [[self objectOrNilForKey:kYHBUserInfoVmobile fromDictionary:dict] integerValue];
        self.address = [self objectOrNilForKey:kYHBUserInfoAddress fromDictionary:dict];
        self.introduce = [self objectOrNilForKey:kYHBUserInfoIntroduce fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBUserInfoCatname];
    [mutableDict setValue:[NSNumber numberWithInteger:self.userid] forKey:kYHBUserInfoUserid];
    [mutableDict setValue:[NSNumber numberWithInteger:self.selltotal] forKey:kYHBUserInfoSelltotal];
    [mutableDict setValue:self.star1 forKey:kYHBUserInfoStar1];
    [mutableDict setValue:self.business forKey:kYHBUserInfoBusiness];
    [mutableDict setValue:self.emuser forKey:kYHBUserInfoEmuser];
    [mutableDict setValue:self.company forKey:kYHBUserInfoCompany];
    [mutableDict setValue:[NSNumber numberWithInteger:self.friend] forKey:kYHBUserInfoFriend];
    [mutableDict setValue:self.empass forKey:kYHBUserInfoEmpass];
    [mutableDict setValue:[NSNumber numberWithInteger:self.vcompany] forKey:kYHBUserInfoVcompany];
    [mutableDict setValue:self.truename forKey:kYHBUserInfoTruename];
    [mutableDict setValue:[NSNumber numberWithInteger:self.groupid] forKey:kYHBUserInfoGroupid];
    [mutableDict setValue:[NSNumber numberWithInteger:self.buytotal] forKey:kYHBUserInfoBuytotal];
    [mutableDict setValue:[NSNumber numberWithInteger:self.areaid] forKey:kYHBUserInfoAreaid];
    [mutableDict setValue:self.thumb forKey:kYHBUserInfoThumb];
    [mutableDict setValue:self.catid forKey:kYHBUserInfoCatid];
    [mutableDict setValue:self.mobile forKey:kYHBUserInfoMobile];
    [mutableDict setValue:[NSNumber numberWithInteger:self.malltotal] forKey:kYHBUserInfoMalltotal];
    [mutableDict setValue:self.star2 forKey:kYHBUserInfoStar2];
    [mutableDict setValue:self.avatar forKey:kYHBUserInfoAvatar];
    [mutableDict setValue:self.area forKey:kYHBUserInfoArea];
    [mutableDict setValue:[NSNumber numberWithDouble:self.credit] forKey:kYHBUserInfoCredit];
    [mutableDict setValue:[NSNumber numberWithInteger:self.vmobile] forKey:kYHBUserInfoVmobile];
    [mutableDict setValue:self.address forKey:kYHBUserInfoAddress];
    [mutableDict setValue:self.introduce forKey:kYHBUserInfoIntroduce];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.catname = [aDecoder decodeObjectForKey:kYHBUserInfoCatname];
    self.userid = [aDecoder decodeIntegerForKey:kYHBUserInfoUserid];
    self.selltotal = [aDecoder decodeIntegerForKey:kYHBUserInfoSelltotal];
    self.star1 = [aDecoder decodeObjectForKey:kYHBUserInfoStar1];
    self.business = [aDecoder decodeObjectForKey:kYHBUserInfoBusiness];
    self.emuser = [aDecoder decodeObjectForKey:kYHBUserInfoEmuser];
    self.company = [aDecoder decodeObjectForKey:kYHBUserInfoCompany];
    self.friend = [aDecoder decodeIntegerForKey:kYHBUserInfoFriend];
    self.empass = [aDecoder decodeObjectForKey:kYHBUserInfoEmpass];
    self.vcompany = [aDecoder decodeIntegerForKey:kYHBUserInfoVcompany];
    self.truename = [aDecoder decodeObjectForKey:kYHBUserInfoTruename];
    self.groupid = [aDecoder decodeIntegerForKey:kYHBUserInfoGroupid];
    self.buytotal = [aDecoder decodeIntegerForKey:kYHBUserInfoBuytotal];
    self.areaid = [aDecoder decodeIntegerForKey:kYHBUserInfoAreaid];
    self.thumb = [aDecoder decodeObjectForKey:kYHBUserInfoThumb];
    self.catid = [aDecoder decodeObjectForKey:kYHBUserInfoCatid];
    self.mobile = [aDecoder decodeObjectForKey:kYHBUserInfoMobile];
    self.malltotal = [aDecoder decodeIntegerForKey:kYHBUserInfoMalltotal];
    self.star2 = [aDecoder decodeObjectForKey:kYHBUserInfoStar2];
    self.avatar = [aDecoder decodeObjectForKey:kYHBUserInfoAvatar];
    self.area = [aDecoder decodeObjectForKey:kYHBUserInfoArea];
    self.credit = [aDecoder decodeDoubleForKey:kYHBUserInfoCredit];
    self.vmobile = [aDecoder decodeIntegerForKey:kYHBUserInfoVmobile];
    self.address = [aDecoder decodeObjectForKey:kYHBUserInfoAddress];
    self.introduce = [aDecoder decodeObjectForKey:kYHBUserInfoIntroduce];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_catname forKey:kYHBUserInfoCatname];
    [aCoder encodeInteger:_userid forKey:kYHBUserInfoUserid];
    [aCoder encodeInteger:_selltotal forKey:kYHBUserInfoSelltotal];
    [aCoder encodeObject:_star1 forKey:kYHBUserInfoStar1];
    [aCoder encodeObject:_business forKey:kYHBUserInfoBusiness];
    [aCoder encodeObject:_emuser forKey:kYHBUserInfoEmuser];
    [aCoder encodeObject:_company forKey:kYHBUserInfoCompany];
    [aCoder encodeInteger:_friend forKey:kYHBUserInfoFriend];
    [aCoder encodeObject:_empass forKey:kYHBUserInfoEmpass];
    [aCoder encodeInteger:_vcompany forKey:kYHBUserInfoVcompany];
    [aCoder encodeObject:_truename forKey:kYHBUserInfoTruename];
    [aCoder encodeInteger:_groupid forKey:kYHBUserInfoGroupid];
    [aCoder encodeInteger:_buytotal forKey:kYHBUserInfoBuytotal];
    [aCoder encodeInteger:_areaid forKey:kYHBUserInfoAreaid];
    [aCoder encodeObject:_thumb forKey:kYHBUserInfoThumb];
    [aCoder encodeObject:_catid forKey:kYHBUserInfoCatid];
    [aCoder encodeObject:_mobile forKey:kYHBUserInfoMobile];
    [aCoder encodeInteger:_malltotal forKey:kYHBUserInfoMalltotal];
    [aCoder encodeObject:_star2 forKey:kYHBUserInfoStar2];
    [aCoder encodeObject:_avatar forKey:kYHBUserInfoAvatar];
    [aCoder encodeObject:_area forKey:kYHBUserInfoArea];
    [aCoder encodeDouble:_credit forKey:kYHBUserInfoCredit];
    [aCoder encodeInteger:_vmobile forKey:kYHBUserInfoVmobile];
    [aCoder encodeObject:_address forKey:kYHBUserInfoAddress];
    [aCoder encodeObject:_introduce forKey:kYHBUserInfoIntroduce];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBUserInfo *copy = [[YHBUserInfo alloc] init];
    
    if (copy) {
        
        copy.catname = [self.catname copyWithZone:zone];
        copy.userid = self.userid;
        copy.selltotal = self.selltotal;
        copy.star1 = [self.star1 copyWithZone:zone];
        copy.business = [self.business copyWithZone:zone];
        copy.emuser = [self.emuser copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.friend = self.friend;
        copy.empass = [self.empass copyWithZone:zone];
        copy.vcompany = self.vcompany;
        copy.truename = [self.truename copyWithZone:zone];
        copy.groupid = self.groupid;
        copy.buytotal = self.buytotal;
        copy.areaid = self.areaid;
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.catid = [self.catid copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.malltotal = self.malltotal;
        copy.star2 = [self.star2 copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.credit = self.credit;
        copy.vmobile = self.vmobile;
        copy.address = [self.address copyWithZone:zone];
        copy.introduce = [self.introduce copyWithZone:zone];
    }
    
    return copy;
}



@end
