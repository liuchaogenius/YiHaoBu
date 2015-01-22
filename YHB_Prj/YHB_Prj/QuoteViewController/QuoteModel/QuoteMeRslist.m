//
//  QuoteMeRslist.m
//
//  Created by  C陈政旭 on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "QuoteMeRslist.h"


NSString *const kQuoteMeRslistAmount = @"amount";
NSString *const kQuoteMeRslistAddtime = @"addtime";
NSString *const kQuoteMeRslistAdddate = @"adddate";
NSString *const kQuoteMeRslistTypename = @"typename";
NSString *const kQuoteMeRslistPrice = @"price";
NSString *const kQuoteMeRslistTitle = @"title";
NSString *const kQuoteMeRslistItemid = @"itemid";
NSString *const kQuoteMeRslistThumb = @"thumb";


@interface QuoteMeRslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QuoteMeRslist

@synthesize amount = _amount;
@synthesize addtime = _addtime;
@synthesize adddate = _adddate;
@synthesize typename = _typename;
@synthesize price = _price;
@synthesize title = _title;
@synthesize itemid = _itemid;
@synthesize thumb = _thumb;


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
            self.amount = [self objectOrNilForKey:kQuoteMeRslistAmount fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kQuoteMeRslistAddtime fromDictionary:dict];
            self.adddate = [self objectOrNilForKey:kQuoteMeRslistAdddate fromDictionary:dict];
            self.typename = [self objectOrNilForKey:kQuoteMeRslistTypename fromDictionary:dict];
            self.price = [self objectOrNilForKey:kQuoteMeRslistPrice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kQuoteMeRslistTitle fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kQuoteMeRslistItemid fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kQuoteMeRslistThumb fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.amount forKey:kQuoteMeRslistAmount];
    [mutableDict setValue:self.addtime forKey:kQuoteMeRslistAddtime];
    [mutableDict setValue:self.adddate forKey:kQuoteMeRslistAdddate];
    [mutableDict setValue:self.typename forKey:kQuoteMeRslistTypename];
    [mutableDict setValue:self.price forKey:kQuoteMeRslistPrice];
    [mutableDict setValue:self.title forKey:kQuoteMeRslistTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kQuoteMeRslistItemid];
    [mutableDict setValue:self.thumb forKey:kQuoteMeRslistThumb];

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

    self.amount = [aDecoder decodeObjectForKey:kQuoteMeRslistAmount];
    self.addtime = [aDecoder decodeObjectForKey:kQuoteMeRslistAddtime];
    self.adddate = [aDecoder decodeObjectForKey:kQuoteMeRslistAdddate];
    self.typename = [aDecoder decodeObjectForKey:kQuoteMeRslistTypename];
    self.price = [aDecoder decodeObjectForKey:kQuoteMeRslistPrice];
    self.title = [aDecoder decodeObjectForKey:kQuoteMeRslistTitle];
    self.itemid = [aDecoder decodeDoubleForKey:kQuoteMeRslistItemid];
    self.thumb = [aDecoder decodeObjectForKey:kQuoteMeRslistThumb];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_amount forKey:kQuoteMeRslistAmount];
    [aCoder encodeObject:_addtime forKey:kQuoteMeRslistAddtime];
    [aCoder encodeObject:_adddate forKey:kQuoteMeRslistAdddate];
    [aCoder encodeObject:_typename forKey:kQuoteMeRslistTypename];
    [aCoder encodeObject:_price forKey:kQuoteMeRslistPrice];
    [aCoder encodeObject:_title forKey:kQuoteMeRslistTitle];
    [aCoder encodeDouble:_itemid forKey:kQuoteMeRslistItemid];
    [aCoder encodeObject:_thumb forKey:kQuoteMeRslistThumb];
}

- (id)copyWithZone:(NSZone *)zone
{
    QuoteMeRslist *copy = [[QuoteMeRslist alloc] init];
    
    if (copy) {

        copy.amount = [self.amount copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.typename = [self.typename copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.thumb = [self.thumb copyWithZone:zone];
    }
    
    return copy;
}


@end
