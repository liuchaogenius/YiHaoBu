//
//  PriceDetailRslist.m
//
//  Created by  C陈政旭 on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PriceDetailRslist.h"


NSString *const kPriceDetailRslistTypename = @"typename";
NSString *const kPriceDetailRslistUserid = @"userid";
NSString *const kPriceDetailRslistMobile = @"mobile";
NSString *const kPriceDetailRslistTruename = @"truename";
NSString *const kPriceDetailRslistPrice = @"price";
NSString *const kPriceDetailRslistCompany = @"company";
NSString *const kPriceDetailRslistAvatar = @"avatar";
NSString *const kPriceDetailRslistNote = @"note";
NSString *const kPriceDetailRslistAddtime = @"addtime";
NSString *const kPriceDetailRslistAdddate = @"adddate";


@interface PriceDetailRslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PriceDetailRslist

@synthesize typename = _typename;
@synthesize userid = _userid;
@synthesize mobile = _mobile;
@synthesize truename = _truename;
@synthesize price = _price;
@synthesize company = _company;
@synthesize avatar = _avatar;
@synthesize note = _note;
@synthesize addtime = _addtime;
@synthesize adddate = _adddate;


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
            self.typename = [self objectOrNilForKey:kPriceDetailRslistTypename fromDictionary:dict];
            self.userid = [[self objectOrNilForKey:kPriceDetailRslistUserid fromDictionary:dict] doubleValue];
            self.mobile = [self objectOrNilForKey:kPriceDetailRslistMobile fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kPriceDetailRslistTruename fromDictionary:dict];
            self.price = [self objectOrNilForKey:kPriceDetailRslistPrice fromDictionary:dict];
            self.company = [self objectOrNilForKey:kPriceDetailRslistCompany fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kPriceDetailRslistAvatar fromDictionary:dict];
            self.note = [self objectOrNilForKey:kPriceDetailRslistNote fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kPriceDetailRslistAddtime fromDictionary:dict];
            self.adddate = [self objectOrNilForKey:kPriceDetailRslistAdddate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.typename forKey:kPriceDetailRslistTypename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kPriceDetailRslistUserid];
    [mutableDict setValue:self.mobile forKey:kPriceDetailRslistMobile];
    [mutableDict setValue:self.truename forKey:kPriceDetailRslistTruename];
    [mutableDict setValue:self.price forKey:kPriceDetailRslistPrice];
    [mutableDict setValue:self.company forKey:kPriceDetailRslistCompany];
    [mutableDict setValue:self.avatar forKey:kPriceDetailRslistAvatar];
    [mutableDict setValue:self.note forKey:kPriceDetailRslistNote];
    [mutableDict setValue:self.addtime forKey:kPriceDetailRslistAddtime];
    [mutableDict setValue:self.adddate forKey:kPriceDetailRslistAdddate];

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

    self.typename = [aDecoder decodeObjectForKey:kPriceDetailRslistTypename];
    self.userid = [aDecoder decodeDoubleForKey:kPriceDetailRslistUserid];
    self.mobile = [aDecoder decodeObjectForKey:kPriceDetailRslistMobile];
    self.truename = [aDecoder decodeObjectForKey:kPriceDetailRslistTruename];
    self.price = [aDecoder decodeObjectForKey:kPriceDetailRslistPrice];
    self.company = [aDecoder decodeObjectForKey:kPriceDetailRslistCompany];
    self.avatar = [aDecoder decodeObjectForKey:kPriceDetailRslistAvatar];
    self.note = [aDecoder decodeObjectForKey:kPriceDetailRslistNote];
    self.addtime = [aDecoder decodeObjectForKey:kPriceDetailRslistAddtime];
    self.adddate = [aDecoder decodeObjectForKey:kPriceDetailRslistAdddate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_typename forKey:kPriceDetailRslistTypename];
    [aCoder encodeDouble:_userid forKey:kPriceDetailRslistUserid];
    [aCoder encodeObject:_mobile forKey:kPriceDetailRslistMobile];
    [aCoder encodeObject:_truename forKey:kPriceDetailRslistTruename];
    [aCoder encodeObject:_price forKey:kPriceDetailRslistPrice];
    [aCoder encodeObject:_company forKey:kPriceDetailRslistCompany];
    [aCoder encodeObject:_avatar forKey:kPriceDetailRslistAvatar];
    [aCoder encodeObject:_note forKey:kPriceDetailRslistNote];
    [aCoder encodeObject:_addtime forKey:kPriceDetailRslistAddtime];
    [aCoder encodeObject:_adddate forKey:kPriceDetailRslistAdddate];
}

- (id)copyWithZone:(NSZone *)zone
{
    PriceDetailRslist *copy = [[PriceDetailRslist alloc] init];
    
    if (copy) {

        copy.typename = [self.typename copyWithZone:zone];
        copy.userid = self.userid;
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.note = [self.note copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
    }
    
    return copy;
}


@end
