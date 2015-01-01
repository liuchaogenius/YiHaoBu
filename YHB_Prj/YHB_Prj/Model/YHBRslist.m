//
//  YHBRslist.m
//
//  Created by   on 14/12/30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBRslist.h"


NSString *const kYHBRslistTypename = @"typename";
NSString *const kYHBRslistItemid = @"itemid";
NSString *const kYHBRslistCatname = @"catname";
NSString *const kYHBRslistTitle = @"title";
NSString *const kYHBRslistEditdate = @"editdate";
NSString *const kYHBRslistThumb = @"thumb";
NSString *const kYHBRslistVip = @"vip";
NSString *const kYHBRslistEdittime = @"edittime";
NSString *const kYHBRslistPrice = @"price";
NSString *const kYHBRslistHits = @"hits";


@interface YHBRslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBRslist

@synthesize typename = _typename;
@synthesize itemid = _itemid;
@synthesize catname = _catname;
@synthesize title = _title;
@synthesize editdate = _editdate;
@synthesize thumb = _thumb;
@synthesize vip = _vip;
@synthesize edittime = _edittime;
@synthesize price = _price;
@synthesize hits = _hits;


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
            self.typename = [self objectOrNilForKey:kYHBRslistTypename fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBRslistItemid fromDictionary:dict] doubleValue];
            self.catname = [self objectOrNilForKey:kYHBRslistCatname fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBRslistTitle fromDictionary:dict];
            self.editdate = [self objectOrNilForKey:kYHBRslistEditdate fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBRslistThumb fromDictionary:dict];
            self.vip = [[self objectOrNilForKey:kYHBRslistVip fromDictionary:dict] doubleValue];
            self.edittime = [self objectOrNilForKey:kYHBRslistEdittime fromDictionary:dict];
            self.price = [self objectOrNilForKey:kYHBRslistPrice fromDictionary:dict];
            self.hits = [[self objectOrNilForKey:kYHBRslistHits fromDictionary:dict] intValue];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.typename forKey:kYHBRslistTypename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBRslistItemid];
    [mutableDict setValue:self.catname forKey:kYHBRslistCatname];
    [mutableDict setValue:self.title forKey:kYHBRslistTitle];
    [mutableDict setValue:self.editdate forKey:kYHBRslistEditdate];
    [mutableDict setValue:self.thumb forKey:kYHBRslistThumb];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vip] forKey:kYHBRslistVip];
    [mutableDict setValue:self.edittime forKey:kYHBRslistEdittime];
    [mutableDict setValue:self.price forKey:kYHBRslistPrice];
    [mutableDict setValue:[NSNumber numberWithInt:self.hits] forKey:kYHBRslistHits];

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

    self.typename = [aDecoder decodeObjectForKey:kYHBRslistTypename];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBRslistItemid];
    self.catname = [aDecoder decodeObjectForKey:kYHBRslistCatname];
    self.title = [aDecoder decodeObjectForKey:kYHBRslistTitle];
    self.editdate = [aDecoder decodeObjectForKey:kYHBRslistEditdate];
    self.thumb = [aDecoder decodeObjectForKey:kYHBRslistThumb];
    self.vip = [aDecoder decodeDoubleForKey:kYHBRslistVip];
    self.edittime = [aDecoder decodeObjectForKey:kYHBRslistEdittime];
    self.price = [aDecoder decodeObjectForKey:kYHBRslistPrice];
    self.hits = [aDecoder decodeIntForKey:kYHBRslistHits];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_typename forKey:kYHBRslistTypename];
    [aCoder encodeDouble:_itemid forKey:kYHBRslistItemid];
    [aCoder encodeObject:_catname forKey:kYHBRslistCatname];
    [aCoder encodeObject:_title forKey:kYHBRslistTitle];
    [aCoder encodeObject:_editdate forKey:kYHBRslistEditdate];
    [aCoder encodeObject:_thumb forKey:kYHBRslistThumb];
    [aCoder encodeDouble:_vip forKey:kYHBRslistVip];
    [aCoder encodeObject:_edittime forKey:kYHBRslistEdittime];
    [aCoder encodeObject:_price forKey:kYHBRslistPrice];
    [aCoder encodeDouble:_hits forKey:kYHBRslistHits];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBRslist *copy = [[YHBRslist alloc] init];
    
    if (copy) {

        copy.typename = [self.typename copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.catname = [self.catname copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.editdate = [self.editdate copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.vip = self.vip;
        copy.edittime = [self.edittime copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.hits = self.hits;
    }
    
    return copy;
}


@end
