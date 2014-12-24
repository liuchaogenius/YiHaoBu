//
//  YHBHotlist.m
//
//  Created by   on 14/12/23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBHotlist.h"


NSString *const kYHBHotlistTitle = @"title";
NSString *const kYHBHotlistThumb = @"thumb";
NSString *const kYHBHotlistPrice = @"price";
NSString *const kYHBHotlistItemid = @"itemid";


@interface YHBHotlist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBHotlist

@synthesize title = _title;
@synthesize thumb = _thumb;
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
            self.title = [self objectOrNilForKey:kYHBHotlistTitle fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBHotlistThumb fromDictionary:dict];
            self.price = [self objectOrNilForKey:kYHBHotlistPrice fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBHotlistItemid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kYHBHotlistTitle];
    [mutableDict setValue:self.thumb forKey:kYHBHotlistThumb];
    [mutableDict setValue:self.price forKey:kYHBHotlistPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBHotlistItemid];

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

    self.title = [aDecoder decodeObjectForKey:kYHBHotlistTitle];
    self.thumb = [aDecoder decodeObjectForKey:kYHBHotlistThumb];
    self.price = [aDecoder decodeObjectForKey:kYHBHotlistPrice];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBHotlistItemid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kYHBHotlistTitle];
    [aCoder encodeObject:_thumb forKey:kYHBHotlistThumb];
    [aCoder encodeObject:_price forKey:kYHBHotlistPrice];
    [aCoder encodeDouble:_itemid forKey:kYHBHotlistItemid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBHotlist *copy = [[YHBHotlist alloc] init];
    
    if (copy) {

        copy.title = [self.title copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.itemid = self.itemid;
    }
    
    return copy;
}


@end
