//
//  YHBShopCartCartlist.m
//
//  Created by  C陈政旭 on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBShopCartCartlist.h"


NSString *const kYHBShopCartCartlistNumber = @"number";
NSString *const kYHBShopCartCartlistTitle = @"title";
NSString *const kYHBShopCartCartlistThumb = @"thumb";
NSString *const kYHBShopCartCartlistCatname = @"catname";
NSString *const kYHBShopCartCartlistPrice = @"price";
NSString *const kYHBShopCartCartlistItemid = @"itemid";


@interface YHBShopCartCartlist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBShopCartCartlist

@synthesize number = _number;
@synthesize title = _title;
@synthesize thumb = _thumb;
@synthesize catname = _catname;
@synthesize price = _price;
@synthesize itemid = _itemid;


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
            self.number = [self objectOrNilForKey:kYHBShopCartCartlistNumber fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBShopCartCartlistTitle fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBShopCartCartlistThumb fromDictionary:dict];
            self.catname = [self objectOrNilForKey:kYHBShopCartCartlistCatname fromDictionary:dict];
            self.price = [self objectOrNilForKey:kYHBShopCartCartlistPrice fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBShopCartCartlistItemid fromDictionary:dict] intValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.number forKey:kYHBShopCartCartlistNumber];
    [mutableDict setValue:self.title forKey:kYHBShopCartCartlistTitle];
    [mutableDict setValue:self.thumb forKey:kYHBShopCartCartlistThumb];
    [mutableDict setValue:self.catname forKey:kYHBShopCartCartlistCatname];
    [mutableDict setValue:self.price forKey:kYHBShopCartCartlistPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBShopCartCartlistItemid];

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

    self.number = [aDecoder decodeObjectForKey:kYHBShopCartCartlistNumber];
    self.title = [aDecoder decodeObjectForKey:kYHBShopCartCartlistTitle];
    self.thumb = [aDecoder decodeObjectForKey:kYHBShopCartCartlistThumb];
    self.catname = [aDecoder decodeObjectForKey:kYHBShopCartCartlistCatname];
    self.price = [aDecoder decodeObjectForKey:kYHBShopCartCartlistPrice];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBShopCartCartlistItemid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_number forKey:kYHBShopCartCartlistNumber];
    [aCoder encodeObject:_title forKey:kYHBShopCartCartlistTitle];
    [aCoder encodeObject:_thumb forKey:kYHBShopCartCartlistThumb];
    [aCoder encodeObject:_catname forKey:kYHBShopCartCartlistCatname];
    [aCoder encodeObject:_price forKey:kYHBShopCartCartlistPrice];
    [aCoder encodeDouble:_itemid forKey:kYHBShopCartCartlistItemid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBShopCartCartlist *copy = [[YHBShopCartCartlist alloc] init];
    
    if (copy) {

        copy.number = [self.number copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.catname = [self.catname copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.itemid = self.itemid;
    }
    
    return copy;
}


@end
