//
//  YHBShoplist.m
//
//  Created by   on 14/12/23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBShoplist.h"


NSString *const kYHBShoplistCompany = @"company";
NSString *const kYHBShoplistItemid = @"itemid";
NSString *const kYHBShoplistAvatar = @"avatar";


@interface YHBShoplist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBShoplist

@synthesize company = _company;
@synthesize itemid = _itemid;
@synthesize avatar = _avatar;


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
            self.company = [self objectOrNilForKey:kYHBShoplistCompany fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBShoplistItemid fromDictionary:dict] doubleValue];
            self.avatar = [self objectOrNilForKey:kYHBShoplistAvatar fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.company forKey:kYHBShoplistCompany];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBShoplistItemid];
    [mutableDict setValue:self.avatar forKey:kYHBShoplistAvatar];

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

    self.company = [aDecoder decodeObjectForKey:kYHBShoplistCompany];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBShoplistItemid];
    self.avatar = [aDecoder decodeObjectForKey:kYHBShoplistAvatar];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_company forKey:kYHBShoplistCompany];
    [aCoder encodeDouble:_itemid forKey:kYHBShoplistItemid];
    [aCoder encodeObject:_avatar forKey:kYHBShoplistAvatar];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBShoplist *copy = [[YHBShoplist alloc] init];
    
    if (copy) {

        copy.company = [self.company copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.avatar = [self.avatar copyWithZone:zone];
    }
    
    return copy;
}


@end
