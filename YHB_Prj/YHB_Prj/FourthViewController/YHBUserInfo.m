//
//  YHBUserInfo.m
//
//  Created by   on 14/12/1
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBUserInfo.h"


NSString *const kYHBUserInfoCatname = @"catname";
NSString *const kYHBUserInfoUserid = @"userid";
NSString *const kYHBUserInfoIntroduce = @"introduce";
NSString *const kYHBUserInfoBusiness = @"business";
NSString *const kYHBUserInfoCompany = @"company";
NSString *const kYHBUserInfoVcompany = @"vcompany";
NSString *const kYHBUserInfoTruename = @"truename";
NSString *const kYHBUserInfoGroupid = @"groupid";
NSString *const kYHBUserInfoBuytotal = @"buytotal";
NSString *const kYHBUserInfoAreaid = @"areaid";
NSString *const kYHBUserInfoThumb = @"thumb";
NSString *const kYHBUserInfoCatid = @"catid";
NSString *const kYHBUserInfoMobile = @"mobile";
NSString *const kYHBUserInfoMalltotal = @"malltotal";
NSString *const kYHBUserInfoVmobile = @"vmobile";
NSString *const kYHBUserInfoAvatar = @"avatar";
NSString *const kYHBUserInfoArea = @"area";
NSString *const kYHBUserInfoCredit = @"credit";
NSString *const kYHBUserInfoSelltotal = @"selltotal";
NSString *const kYHBUserInfoAddress = @"address";


@interface YHBUserInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBUserInfo

@synthesize catname = _catname;
@synthesize userid = _userid;
@synthesize introduce = _introduce;
@synthesize business = _business;
@synthesize company = _company;
@synthesize vcompany = _vcompany;
@synthesize truename = _truename;
@synthesize groupid = _groupid;
@synthesize buytotal = _buytotal;
@synthesize areaid = _areaid;
@synthesize thumb = _thumb;
@synthesize catid = _catid;
@synthesize mobile = _mobile;
@synthesize malltotal = _malltotal;
@synthesize vmobile = _vmobile;
@synthesize avatar = _avatar;
@synthesize area = _area;
@synthesize credit = _credit;
@synthesize selltotal = _selltotal;
@synthesize address = _address;


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
            self.introduce = [self objectOrNilForKey:kYHBUserInfoIntroduce fromDictionary:dict];
            self.business = [self objectOrNilForKey:kYHBUserInfoBusiness fromDictionary:dict];
            self.company = [self objectOrNilForKey:kYHBUserInfoCompany fromDictionary:dict];
            self.vcompany = [[self objectOrNilForKey:kYHBUserInfoVcompany fromDictionary:dict] doubleValue];
            self.truename = [self objectOrNilForKey:kYHBUserInfoTruename fromDictionary:dict];
            self.groupid = [[self objectOrNilForKey:kYHBUserInfoGroupid fromDictionary:dict] doubleValue];
            self.buytotal = [[self objectOrNilForKey:kYHBUserInfoBuytotal fromDictionary:dict] doubleValue];
            self.areaid = [[self objectOrNilForKey:kYHBUserInfoAreaid fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kYHBUserInfoThumb fromDictionary:dict];
            self.catid = [self objectOrNilForKey:kYHBUserInfoCatid fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kYHBUserInfoMobile fromDictionary:dict];
            self.malltotal = [[self objectOrNilForKey:kYHBUserInfoMalltotal fromDictionary:dict] doubleValue];
            self.vmobile = [[self objectOrNilForKey:kYHBUserInfoVmobile fromDictionary:dict] doubleValue];
            self.avatar = [self objectOrNilForKey:kYHBUserInfoAvatar fromDictionary:dict];
            self.area = [self objectOrNilForKey:kYHBUserInfoArea fromDictionary:dict];
            self.credit = [[self objectOrNilForKey:kYHBUserInfoCredit fromDictionary:dict] doubleValue];
            self.selltotal = [[self objectOrNilForKey:kYHBUserInfoSelltotal fromDictionary:dict] doubleValue];
            self.address = [self objectOrNilForKey:kYHBUserInfoAddress fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBUserInfoCatname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBUserInfoUserid];
    [mutableDict setValue:self.introduce forKey:kYHBUserInfoIntroduce];
    [mutableDict setValue:self.business forKey:kYHBUserInfoBusiness];
    [mutableDict setValue:self.company forKey:kYHBUserInfoCompany];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vcompany] forKey:kYHBUserInfoVcompany];
    [mutableDict setValue:self.truename forKey:kYHBUserInfoTruename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupid] forKey:kYHBUserInfoGroupid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.buytotal] forKey:kYHBUserInfoBuytotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaid] forKey:kYHBUserInfoAreaid];
    [mutableDict setValue:self.thumb forKey:kYHBUserInfoThumb];
    [mutableDict setValue:self.catid forKey:kYHBUserInfoCatid];
    [mutableDict setValue:self.mobile forKey:kYHBUserInfoMobile];
    [mutableDict setValue:[NSNumber numberWithDouble:self.malltotal] forKey:kYHBUserInfoMalltotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vmobile] forKey:kYHBUserInfoVmobile];
    [mutableDict setValue:self.avatar forKey:kYHBUserInfoAvatar];
    [mutableDict setValue:self.area forKey:kYHBUserInfoArea];
    [mutableDict setValue:[NSNumber numberWithDouble:self.credit] forKey:kYHBUserInfoCredit];
    [mutableDict setValue:[NSNumber numberWithDouble:self.selltotal] forKey:kYHBUserInfoSelltotal];
    [mutableDict setValue:self.address forKey:kYHBUserInfoAddress];

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
    self.introduce = [aDecoder decodeObjectForKey:kYHBUserInfoIntroduce];
    self.business = [aDecoder decodeObjectForKey:kYHBUserInfoBusiness];
    self.company = [aDecoder decodeObjectForKey:kYHBUserInfoCompany];
    self.vcompany = [aDecoder decodeDoubleForKey:kYHBUserInfoVcompany];
    self.truename = [aDecoder decodeObjectForKey:kYHBUserInfoTruename];
    self.groupid = [aDecoder decodeDoubleForKey:kYHBUserInfoGroupid];
    self.buytotal = [aDecoder decodeDoubleForKey:kYHBUserInfoBuytotal];
    self.areaid = [aDecoder decodeDoubleForKey:kYHBUserInfoAreaid];
    self.thumb = [aDecoder decodeObjectForKey:kYHBUserInfoThumb];
    self.catid = [aDecoder decodeObjectForKey:kYHBUserInfoCatid];
    self.mobile = [aDecoder decodeObjectForKey:kYHBUserInfoMobile];
    self.malltotal = [aDecoder decodeDoubleForKey:kYHBUserInfoMalltotal];
    self.vmobile = [aDecoder decodeDoubleForKey:kYHBUserInfoVmobile];
    self.avatar = [aDecoder decodeObjectForKey:kYHBUserInfoAvatar];
    self.area = [aDecoder decodeObjectForKey:kYHBUserInfoArea];
    self.credit = [aDecoder decodeDoubleForKey:kYHBUserInfoCredit];
    self.selltotal = [aDecoder decodeDoubleForKey:kYHBUserInfoSelltotal];
    self.address = [aDecoder decodeObjectForKey:kYHBUserInfoAddress];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_catname forKey:kYHBUserInfoCatname];
    [aCoder encodeDouble:_userid forKey:kYHBUserInfoUserid];
    [aCoder encodeObject:_introduce forKey:kYHBUserInfoIntroduce];
    [aCoder encodeObject:_business forKey:kYHBUserInfoBusiness];
    [aCoder encodeObject:_company forKey:kYHBUserInfoCompany];
    [aCoder encodeDouble:_vcompany forKey:kYHBUserInfoVcompany];
    [aCoder encodeObject:_truename forKey:kYHBUserInfoTruename];
    [aCoder encodeDouble:_groupid forKey:kYHBUserInfoGroupid];
    [aCoder encodeDouble:_buytotal forKey:kYHBUserInfoBuytotal];
    [aCoder encodeDouble:_areaid forKey:kYHBUserInfoAreaid];
    [aCoder encodeObject:_thumb forKey:kYHBUserInfoThumb];
    [aCoder encodeObject:_catid forKey:kYHBUserInfoCatid];
    [aCoder encodeObject:_mobile forKey:kYHBUserInfoMobile];
    [aCoder encodeDouble:_malltotal forKey:kYHBUserInfoMalltotal];
    [aCoder encodeDouble:_vmobile forKey:kYHBUserInfoVmobile];
    [aCoder encodeObject:_avatar forKey:kYHBUserInfoAvatar];
    [aCoder encodeObject:_area forKey:kYHBUserInfoArea];
    [aCoder encodeDouble:_credit forKey:kYHBUserInfoCredit];
    [aCoder encodeDouble:_selltotal forKey:kYHBUserInfoSelltotal];
    [aCoder encodeObject:_address forKey:kYHBUserInfoAddress];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBUserInfo *copy = [[YHBUserInfo alloc] init];
    
    if (copy) {

        copy.catname = [self.catname copyWithZone:zone];
        copy.userid = self.userid;
        copy.introduce = [self.introduce copyWithZone:zone];
        copy.business = [self.business copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.vcompany = self.vcompany;
        copy.truename = [self.truename copyWithZone:zone];
        copy.groupid = self.groupid;
        copy.buytotal = self.buytotal;
        copy.areaid = self.areaid;
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.catid = [self.catid copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.malltotal = self.malltotal;
        copy.vmobile = self.vmobile;
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.credit = self.credit;
        copy.selltotal = self.selltotal;
        copy.address = [self.address copyWithZone:zone];
    }
    
    return copy;
}


@end
