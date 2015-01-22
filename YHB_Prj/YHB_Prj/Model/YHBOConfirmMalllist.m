//
//  YHBOConfirmMalllist.m
//
//  Created by   on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOConfirmMalllist.h"
#import "YHBOConfirmExpress.h"


NSString *const kYHBOConfirmMalllistTypeid = @"typeid";
NSString *const kYHBOConfirmMalllistUnit1 = @"unit1";
NSString *const kYHBOConfirmMalllistNumber = @"number";
NSString *const kYHBOConfirmMalllistItemid = @"itemid";
NSString *const kYHBOConfirmMalllistPrice = @"price";
NSString *const kYHBOConfirmMalllistTitle = @"title";
NSString *const kYHBOConfirmMalllistThumb = @"thumb";
NSString *const kYHBOConfirmMalllistSkuname = @"skuname";
NSString *const kYHBOConfirmMalllistExpress = @"express";
NSString *const kYHBOConfirmMalllistSkuid = @"skuid";


@interface YHBOConfirmMalllist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOConfirmMalllist

@synthesize typeid = _typeid;
@synthesize unit1 = _unit1;
@synthesize number = _number;
@synthesize itemid = _itemid;
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
            self.typeid = [[self objectOrNilForKey:kYHBOConfirmMalllistTypeid fromDictionary:dict] doubleValue];
            self.unit1 = [self objectOrNilForKey:kYHBOConfirmMalllistUnit1 fromDictionary:dict];
            self.number = [self objectOrNilForKey:kYHBOConfirmMalllistNumber fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBOConfirmMalllistItemid fromDictionary:dict] doubleValue];
            self.price = [self objectOrNilForKey:kYHBOConfirmMalllistPrice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBOConfirmMalllistTitle fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBOConfirmMalllistThumb fromDictionary:dict];
            self.skuname = [self objectOrNilForKey:kYHBOConfirmMalllistSkuname fromDictionary:dict];
    NSObject *receivedYHBOConfirmExpress = [dict objectForKey:kYHBOConfirmMalllistExpress];
    NSMutableArray *parsedYHBOConfirmExpress = [NSMutableArray array];
    if ([receivedYHBOConfirmExpress isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBOConfirmExpress) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBOConfirmExpress addObject:[YHBOConfirmExpress modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBOConfirmExpress isKindOfClass:[NSDictionary class]]) {
       [parsedYHBOConfirmExpress addObject:[YHBOConfirmExpress modelObjectWithDictionary:(NSDictionary *)receivedYHBOConfirmExpress]];
    }

    self.express = [NSArray arrayWithArray:parsedYHBOConfirmExpress];
            self.skuid = [[self objectOrNilForKey:kYHBOConfirmMalllistSkuid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.typeid] forKey:kYHBOConfirmMalllistTypeid];
    [mutableDict setValue:self.unit1 forKey:kYHBOConfirmMalllistUnit1];
    [mutableDict setValue:self.number forKey:kYHBOConfirmMalllistNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBOConfirmMalllistItemid];
    [mutableDict setValue:self.price forKey:kYHBOConfirmMalllistPrice];
    [mutableDict setValue:self.title forKey:kYHBOConfirmMalllistTitle];
    [mutableDict setValue:self.thumb forKey:kYHBOConfirmMalllistThumb];
    [mutableDict setValue:self.skuname forKey:kYHBOConfirmMalllistSkuname];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForExpress] forKey:kYHBOConfirmMalllistExpress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.skuid] forKey:kYHBOConfirmMalllistSkuid];

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

    self.typeid = [aDecoder decodeDoubleForKey:kYHBOConfirmMalllistTypeid];
    self.unit1 = [aDecoder decodeObjectForKey:kYHBOConfirmMalllistUnit1];
    self.number = [aDecoder decodeObjectForKey:kYHBOConfirmMalllistNumber];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBOConfirmMalllistItemid];
    self.price = [aDecoder decodeObjectForKey:kYHBOConfirmMalllistPrice];
    self.title = [aDecoder decodeObjectForKey:kYHBOConfirmMalllistTitle];
    self.thumb = [aDecoder decodeObjectForKey:kYHBOConfirmMalllistThumb];
    self.skuname = [aDecoder decodeObjectForKey:kYHBOConfirmMalllistSkuname];
    self.express = [aDecoder decodeObjectForKey:kYHBOConfirmMalllistExpress];
    self.skuid = [aDecoder decodeDoubleForKey:kYHBOConfirmMalllistSkuid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_typeid forKey:kYHBOConfirmMalllistTypeid];
    [aCoder encodeObject:_unit1 forKey:kYHBOConfirmMalllistUnit1];
    [aCoder encodeObject:_number forKey:kYHBOConfirmMalllistNumber];
    [aCoder encodeDouble:_itemid forKey:kYHBOConfirmMalllistItemid];
    [aCoder encodeObject:_price forKey:kYHBOConfirmMalllistPrice];
    [aCoder encodeObject:_title forKey:kYHBOConfirmMalllistTitle];
    [aCoder encodeObject:_thumb forKey:kYHBOConfirmMalllistThumb];
    [aCoder encodeObject:_skuname forKey:kYHBOConfirmMalllistSkuname];
    [aCoder encodeObject:_express forKey:kYHBOConfirmMalllistExpress];
    [aCoder encodeDouble:_skuid forKey:kYHBOConfirmMalllistSkuid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOConfirmMalllist *copy = [[YHBOConfirmMalllist alloc] init];
    
    if (copy) {

        copy.typeid = self.typeid;
        copy.unit1 = [self.unit1 copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.itemid = self.itemid;
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
