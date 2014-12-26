//
//  YHBShopCartCartlist.m
//
//  Created by  C陈政旭 on 14/12/22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBShopCartCartlist.h"
#import "YHBShopCartExpress.h"


NSString *const kYHBShopCartCartlistNumber = @"number";
NSString *const kYHBShopCartCartlistItemid = @"itemid";
NSString *const kYHBShopCartCartlistCatname = @"catname";
NSString *const kYHBShopCartCartlistPrice = @"price";
NSString *const kYHBShopCartCartlistTitle = @"title";
NSString *const kYHBShopCartCartlistThumb = @"thumb";
NSString *const kYHBShopCartCartlistSkuname = @"skuname";
NSString *const kYHBShopCartCartlistExpress = @"express";
NSString *const kYHBShopCartCartlistSkuid = @"skuid";


@interface YHBShopCartCartlist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBShopCartCartlist

@synthesize number = _number;
@synthesize itemid = _itemid;
@synthesize catname = _catname;
@synthesize price = _price;
@synthesize title = _title;
@synthesize thumb = _thumb;
@synthesize skuname = _skuname;
@synthesize express = _express;
@synthesize skuid = _skuid;


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
            self.itemid = [[self objectOrNilForKey:kYHBShopCartCartlistItemid fromDictionary:dict] doubleValue];
            self.catname = [self objectOrNilForKey:kYHBShopCartCartlistCatname fromDictionary:dict];
            self.price = [self objectOrNilForKey:kYHBShopCartCartlistPrice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBShopCartCartlistTitle fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBShopCartCartlistThumb fromDictionary:dict];
            self.skuname = [self objectOrNilForKey:kYHBShopCartCartlistSkuname fromDictionary:dict];
    NSObject *receivedYHBShopCartExpress = [dict objectForKey:kYHBShopCartCartlistExpress];
    NSMutableArray *parsedYHBShopCartExpress = [NSMutableArray array];
    if ([receivedYHBShopCartExpress isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBShopCartExpress) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBShopCartExpress addObject:[YHBShopCartExpress modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBShopCartExpress isKindOfClass:[NSDictionary class]]) {
       [parsedYHBShopCartExpress addObject:[YHBShopCartExpress modelObjectWithDictionary:(NSDictionary *)receivedYHBShopCartExpress]];
    }

    self.express = [NSArray arrayWithArray:parsedYHBShopCartExpress];
            self.skuid = [[self objectOrNilForKey:kYHBShopCartCartlistSkuid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.number forKey:kYHBShopCartCartlistNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBShopCartCartlistItemid];
    [mutableDict setValue:self.catname forKey:kYHBShopCartCartlistCatname];
    [mutableDict setValue:self.price forKey:kYHBShopCartCartlistPrice];
    [mutableDict setValue:self.title forKey:kYHBShopCartCartlistTitle];
    [mutableDict setValue:self.thumb forKey:kYHBShopCartCartlistThumb];
    [mutableDict setValue:self.skuname forKey:kYHBShopCartCartlistSkuname];
    NSMutableArray *tempArrayForExpress = [NSMutableArray array];
    for (NSObject *subArrayObject in self.express) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForExpress addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForExpress addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForExpress] forKey:kYHBShopCartCartlistExpress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.skuid] forKey:kYHBShopCartCartlistSkuid];

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
    self.itemid = [aDecoder decodeDoubleForKey:kYHBShopCartCartlistItemid];
    self.catname = [aDecoder decodeObjectForKey:kYHBShopCartCartlistCatname];
    self.price = [aDecoder decodeObjectForKey:kYHBShopCartCartlistPrice];
    self.title = [aDecoder decodeObjectForKey:kYHBShopCartCartlistTitle];
    self.thumb = [aDecoder decodeObjectForKey:kYHBShopCartCartlistThumb];
    self.skuname = [aDecoder decodeObjectForKey:kYHBShopCartCartlistSkuname];
    self.express = [aDecoder decodeObjectForKey:kYHBShopCartCartlistExpress];
    self.skuid = [aDecoder decodeDoubleForKey:kYHBShopCartCartlistSkuid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_number forKey:kYHBShopCartCartlistNumber];
    [aCoder encodeDouble:_itemid forKey:kYHBShopCartCartlistItemid];
    [aCoder encodeObject:_catname forKey:kYHBShopCartCartlistCatname];
    [aCoder encodeObject:_price forKey:kYHBShopCartCartlistPrice];
    [aCoder encodeObject:_title forKey:kYHBShopCartCartlistTitle];
    [aCoder encodeObject:_thumb forKey:kYHBShopCartCartlistThumb];
    [aCoder encodeObject:_skuname forKey:kYHBShopCartCartlistSkuname];
    [aCoder encodeObject:_express forKey:kYHBShopCartCartlistExpress];
    [aCoder encodeDouble:_skuid forKey:kYHBShopCartCartlistSkuid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBShopCartCartlist *copy = [[YHBShopCartCartlist alloc] init];
    
    if (copy) {

        copy.number = [self.number copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.catname = [self.catname copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.skuname = [self.skuname copyWithZone:zone];
        copy.express = [self.express copyWithZone:zone];
        copy.skuid = self.skuid;
    }
    
    return copy;
}


@end
