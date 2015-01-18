//
//  YHBCRslist.m
//
//  Created by   on 15/1/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBCRslist.h"


NSString *const kYHBCRslistUserid = @"userid";
NSString *const kYHBCRslistStar1 = @"star1";
NSString *const kYHBCRslistTruename = @"truename";
NSString *const kYHBCRslistGroupid = @"groupid";
NSString *const kYHBCRslistAvatar = @"avatar";
NSString *const kYHBCRslistCompany = @"company";
NSString *const kYHBCRslistStar2 = @"star2";


@interface YHBCRslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBCRslist

@synthesize userid = _userid;
@synthesize star1 = _star1;
@synthesize truename = _truename;
@synthesize groupid = _groupid;
@synthesize avatar = _avatar;
@synthesize company = _company;
@synthesize star2 = _star2;


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
            self.userid = [[self objectOrNilForKey:kYHBCRslistUserid fromDictionary:dict] doubleValue];
            self.star1 = [self objectOrNilForKey:kYHBCRslistStar1 fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBCRslistTruename fromDictionary:dict];
            self.groupid = [[self objectOrNilForKey:kYHBCRslistGroupid fromDictionary:dict] doubleValue];
            self.avatar = [self objectOrNilForKey:kYHBCRslistAvatar fromDictionary:dict];
            self.company = [self objectOrNilForKey:kYHBCRslistCompany fromDictionary:dict];
            self.star2 = [self objectOrNilForKey:kYHBCRslistStar2 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBCRslistUserid];
    [mutableDict setValue:self.star1 forKey:kYHBCRslistStar1];
    [mutableDict setValue:self.truename forKey:kYHBCRslistTruename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupid] forKey:kYHBCRslistGroupid];
    [mutableDict setValue:self.avatar forKey:kYHBCRslistAvatar];
    [mutableDict setValue:self.company forKey:kYHBCRslistCompany];
    [mutableDict setValue:self.star2 forKey:kYHBCRslistStar2];

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

    self.userid = [aDecoder decodeDoubleForKey:kYHBCRslistUserid];
    self.star1 = [aDecoder decodeObjectForKey:kYHBCRslistStar1];
    self.truename = [aDecoder decodeObjectForKey:kYHBCRslistTruename];
    self.groupid = [aDecoder decodeDoubleForKey:kYHBCRslistGroupid];
    self.avatar = [aDecoder decodeObjectForKey:kYHBCRslistAvatar];
    self.company = [aDecoder decodeObjectForKey:kYHBCRslistCompany];
    self.star2 = [aDecoder decodeObjectForKey:kYHBCRslistStar2];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_userid forKey:kYHBCRslistUserid];
    [aCoder encodeObject:_star1 forKey:kYHBCRslistStar1];
    [aCoder encodeObject:_truename forKey:kYHBCRslistTruename];
    [aCoder encodeDouble:_groupid forKey:kYHBCRslistGroupid];
    [aCoder encodeObject:_avatar forKey:kYHBCRslistAvatar];
    [aCoder encodeObject:_company forKey:kYHBCRslistCompany];
    [aCoder encodeObject:_star2 forKey:kYHBCRslistStar2];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBCRslist *copy = [[YHBCRslist alloc] init];
    
    if (copy) {

        copy.userid = self.userid;
        copy.star1 = [self.star1 copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.groupid = self.groupid;
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.star2 = [self.star2 copyWithZone:zone];
    }
    
    return copy;
}


@end
