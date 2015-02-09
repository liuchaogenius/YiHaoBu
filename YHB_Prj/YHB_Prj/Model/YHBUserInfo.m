//
//  YHBUserInfo.m
//
//  Created by   on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBUserInfo.h"


NSString *const kYHBUserInfoCatname = @"catname";
NSString *const kYHBUserInfoUserid = @"userid";
NSString *const kYHBUserInfoSelltotal = @"selltotal";
NSString *const kYHBUserInfoStar1 = @"star1";
NSString *const kYHBUserInfoBusiness = @"business";
NSString *const kYHBUserInfoMoney = @"money";
NSString *const kYHBUserInfoCompany = @"company";
NSString *const kYHBUserInfoTelephone = @"telephone";
NSString *const kYHBUserInfoFriend = @"friend";
NSString *const kYHBUserInfoEmpass = @"empass";
NSString *const kYHBUserInfoVcompany = @"vcompany";
NSString *const kYHBUserInfoTruename = @"truename";
NSString *const kYHBUserInfoGroupid = @"groupid";
NSString *const kYHBUserInfoBuytotal = @"buytotal";
NSString *const kYHBUserInfoMall1total = @"mall1total";
NSString *const kYHBUserInfoMall0total = @"mall0total";
NSString *const kYHBUserInfoFriendtotal = @"friendtotal";
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
NSString *const kYHBUserInfoLocking = @"locking";
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
@synthesize money = _money;
@synthesize company = _company;
@synthesize telephone = _telephone;
@synthesize friend = _friend;
@synthesize empass = _empass;
@synthesize vcompany = _vcompany;
@synthesize truename = _truename;
@synthesize groupid = _groupid;
@synthesize buytotal = _buytotal;
@synthesize mall1total = _mall1total;
@synthesize mall0total = _mall0total;
@synthesize friendtotal = _friendtotal;
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
@synthesize locking = _locking;
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
            self.userid = [[self objectOrNilForKey:kYHBUserInfoUserid fromDictionary:dict] doubleValue];
            self.selltotal = [[self objectOrNilForKey:kYHBUserInfoSelltotal fromDictionary:dict] doubleValue];
            self.star1 = [self objectOrNilForKey:kYHBUserInfoStar1 fromDictionary:dict];
            self.business = [self objectOrNilForKey:kYHBUserInfoBusiness fromDictionary:dict];
            self.money = [self objectOrNilForKey:kYHBUserInfoMoney fromDictionary:dict];
            self.company = [self objectOrNilForKey:kYHBUserInfoCompany fromDictionary:dict];
            self.telephone = [self objectOrNilForKey:kYHBUserInfoTelephone fromDictionary:dict];
            self.friend = [[self objectOrNilForKey:kYHBUserInfoFriend fromDictionary:dict] doubleValue];
            self.empass = [self objectOrNilForKey:kYHBUserInfoEmpass fromDictionary:dict];
            self.vcompany = [[self objectOrNilForKey:kYHBUserInfoVcompany fromDictionary:dict] doubleValue];
            self.truename = [self objectOrNilForKey:kYHBUserInfoTruename fromDictionary:dict];
            self.groupid = [[self objectOrNilForKey:kYHBUserInfoGroupid fromDictionary:dict] doubleValue];
            self.buytotal = [[self objectOrNilForKey:kYHBUserInfoBuytotal fromDictionary:dict] doubleValue];
            self.mall1total = [[self objectOrNilForKey:kYHBUserInfoMall1total fromDictionary:dict] doubleValue];
            self.mall0total = [[self objectOrNilForKey:kYHBUserInfoMall0total fromDictionary:dict] doubleValue];
            self.friendtotal = [[self objectOrNilForKey:kYHBUserInfoFriendtotal fromDictionary:dict] doubleValue];
            self.areaid = [[self objectOrNilForKey:kYHBUserInfoAreaid fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kYHBUserInfoThumb fromDictionary:dict];
            self.catid = [self objectOrNilForKey:kYHBUserInfoCatid fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kYHBUserInfoMobile fromDictionary:dict];
            self.malltotal = [[self objectOrNilForKey:kYHBUserInfoMalltotal fromDictionary:dict] doubleValue];
            self.star2 = [self objectOrNilForKey:kYHBUserInfoStar2 fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kYHBUserInfoAvatar fromDictionary:dict];
            self.area = [self objectOrNilForKey:kYHBUserInfoArea fromDictionary:dict];
            self.credit = [[self objectOrNilForKey:kYHBUserInfoCredit fromDictionary:dict] doubleValue];
            self.vmobile = [[self objectOrNilForKey:kYHBUserInfoVmobile fromDictionary:dict] doubleValue];
            self.locking = [self objectOrNilForKey:kYHBUserInfoLocking fromDictionary:dict];
            self.address = [self objectOrNilForKey:kYHBUserInfoAddress fromDictionary:dict];
            self.introduce = [self objectOrNilForKey:kYHBUserInfoIntroduce fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBUserInfoCatname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBUserInfoUserid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.selltotal] forKey:kYHBUserInfoSelltotal];
    [mutableDict setValue:self.star1 forKey:kYHBUserInfoStar1];
    [mutableDict setValue:self.business forKey:kYHBUserInfoBusiness];
    [mutableDict setValue:self.money forKey:kYHBUserInfoMoney];
    [mutableDict setValue:self.company forKey:kYHBUserInfoCompany];
    [mutableDict setValue:self.telephone forKey:kYHBUserInfoTelephone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.friend] forKey:kYHBUserInfoFriend];
    [mutableDict setValue:self.empass forKey:kYHBUserInfoEmpass];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vcompany] forKey:kYHBUserInfoVcompany];
    [mutableDict setValue:self.truename forKey:kYHBUserInfoTruename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupid] forKey:kYHBUserInfoGroupid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.buytotal] forKey:kYHBUserInfoBuytotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mall1total] forKey:kYHBUserInfoMall1total];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mall0total] forKey:kYHBUserInfoMall0total];
    [mutableDict setValue:[NSNumber numberWithDouble:self.friendtotal] forKey:kYHBUserInfoFriendtotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaid] forKey:kYHBUserInfoAreaid];
    [mutableDict setValue:self.thumb forKey:kYHBUserInfoThumb];
    [mutableDict setValue:self.catid forKey:kYHBUserInfoCatid];
    [mutableDict setValue:self.mobile forKey:kYHBUserInfoMobile];
    [mutableDict setValue:[NSNumber numberWithDouble:self.malltotal] forKey:kYHBUserInfoMalltotal];
    [mutableDict setValue:self.star2 forKey:kYHBUserInfoStar2];
    [mutableDict setValue:self.avatar forKey:kYHBUserInfoAvatar];
    [mutableDict setValue:self.area forKey:kYHBUserInfoArea];
    [mutableDict setValue:[NSNumber numberWithDouble:self.credit] forKey:kYHBUserInfoCredit];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vmobile] forKey:kYHBUserInfoVmobile];
    [mutableDict setValue:self.locking forKey:kYHBUserInfoLocking];
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
    self.userid = [aDecoder decodeDoubleForKey:kYHBUserInfoUserid];
    self.selltotal = [aDecoder decodeDoubleForKey:kYHBUserInfoSelltotal];
    self.star1 = [aDecoder decodeObjectForKey:kYHBUserInfoStar1];
    self.business = [aDecoder decodeObjectForKey:kYHBUserInfoBusiness];
    self.money = [aDecoder decodeObjectForKey:kYHBUserInfoMoney];
    self.company = [aDecoder decodeObjectForKey:kYHBUserInfoCompany];
    self.telephone = [aDecoder decodeObjectForKey:kYHBUserInfoTelephone];
    self.friend = [aDecoder decodeDoubleForKey:kYHBUserInfoFriend];
    self.empass = [aDecoder decodeObjectForKey:kYHBUserInfoEmpass];
    self.vcompany = [aDecoder decodeDoubleForKey:kYHBUserInfoVcompany];
    self.truename = [aDecoder decodeObjectForKey:kYHBUserInfoTruename];
    self.groupid = [aDecoder decodeDoubleForKey:kYHBUserInfoGroupid];
    self.buytotal = [aDecoder decodeDoubleForKey:kYHBUserInfoBuytotal];
    self.mall1total = [aDecoder decodeDoubleForKey:kYHBUserInfoMall1total];
    self.mall0total = [aDecoder decodeDoubleForKey:kYHBUserInfoMall0total];
    self.friendtotal = [aDecoder decodeDoubleForKey:kYHBUserInfoFriendtotal];
    self.areaid = [aDecoder decodeDoubleForKey:kYHBUserInfoAreaid];
    self.thumb = [aDecoder decodeObjectForKey:kYHBUserInfoThumb];
    self.catid = [aDecoder decodeObjectForKey:kYHBUserInfoCatid];
    self.mobile = [aDecoder decodeObjectForKey:kYHBUserInfoMobile];
    self.malltotal = [aDecoder decodeDoubleForKey:kYHBUserInfoMalltotal];
    self.star2 = [aDecoder decodeObjectForKey:kYHBUserInfoStar2];
    self.avatar = [aDecoder decodeObjectForKey:kYHBUserInfoAvatar];
    self.area = [aDecoder decodeObjectForKey:kYHBUserInfoArea];
    self.credit = [aDecoder decodeDoubleForKey:kYHBUserInfoCredit];
    self.vmobile = [aDecoder decodeDoubleForKey:kYHBUserInfoVmobile];
    self.locking = [aDecoder decodeObjectForKey:kYHBUserInfoLocking];
    self.address = [aDecoder decodeObjectForKey:kYHBUserInfoAddress];
    self.introduce = [aDecoder decodeObjectForKey:kYHBUserInfoIntroduce];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_catname forKey:kYHBUserInfoCatname];
    [aCoder encodeDouble:_userid forKey:kYHBUserInfoUserid];
    [aCoder encodeDouble:_selltotal forKey:kYHBUserInfoSelltotal];
    [aCoder encodeObject:_star1 forKey:kYHBUserInfoStar1];
    [aCoder encodeObject:_business forKey:kYHBUserInfoBusiness];
    [aCoder encodeObject:_money forKey:kYHBUserInfoMoney];
    [aCoder encodeObject:_company forKey:kYHBUserInfoCompany];
    [aCoder encodeObject:_telephone forKey:kYHBUserInfoTelephone];
    [aCoder encodeDouble:_friend forKey:kYHBUserInfoFriend];
    [aCoder encodeObject:_empass forKey:kYHBUserInfoEmpass];
    [aCoder encodeDouble:_vcompany forKey:kYHBUserInfoVcompany];
    [aCoder encodeObject:_truename forKey:kYHBUserInfoTruename];
    [aCoder encodeDouble:_groupid forKey:kYHBUserInfoGroupid];
    [aCoder encodeDouble:_buytotal forKey:kYHBUserInfoBuytotal];
    [aCoder encodeDouble:_mall1total forKey:kYHBUserInfoMall1total];
    [aCoder encodeDouble:_mall0total forKey:kYHBUserInfoMall0total];
    [aCoder encodeDouble:_friendtotal forKey:kYHBUserInfoFriendtotal];
    [aCoder encodeDouble:_areaid forKey:kYHBUserInfoAreaid];
    [aCoder encodeObject:_thumb forKey:kYHBUserInfoThumb];
    [aCoder encodeObject:_catid forKey:kYHBUserInfoCatid];
    [aCoder encodeObject:_mobile forKey:kYHBUserInfoMobile];
    [aCoder encodeDouble:_malltotal forKey:kYHBUserInfoMalltotal];
    [aCoder encodeObject:_star2 forKey:kYHBUserInfoStar2];
    [aCoder encodeObject:_avatar forKey:kYHBUserInfoAvatar];
    [aCoder encodeObject:_area forKey:kYHBUserInfoArea];
    [aCoder encodeDouble:_credit forKey:kYHBUserInfoCredit];
    [aCoder encodeDouble:_vmobile forKey:kYHBUserInfoVmobile];
    [aCoder encodeObject:_locking forKey:kYHBUserInfoLocking];
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
        copy.money = [self.money copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.telephone = [self.telephone copyWithZone:zone];
        copy.friend = self.friend;
        copy.empass = [self.empass copyWithZone:zone];
        copy.vcompany = self.vcompany;
        copy.truename = [self.truename copyWithZone:zone];
        copy.groupid = self.groupid;
        copy.buytotal = self.buytotal;
        copy.mall1total = self.mall1total;
        copy.mall0total = self.mall0total;
        copy.friendtotal = self.friendtotal;
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
        copy.locking = [self.locking copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.introduce = [self.introduce copyWithZone:zone];
    }
    
    return copy;
}


@end
