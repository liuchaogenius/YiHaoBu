//
//  YHBMalllist.m
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBMalllist.h"


NSString *const kYHBMalllistTitle = @"title";
NSString *const kYHBMalllistThumb = @"thumb";
NSString *const kYHBMalllistPrice = @"price";
NSString *const kYHBMalllistItemid = @"itemid";


@interface YHBMalllist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBMalllist

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
            self.title = [self objectOrNilForKey:kYHBMalllistTitle fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBMalllistThumb fromDictionary:dict];
            self.price = [self objectOrNilForKey:kYHBMalllistPrice fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBMalllistItemid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kYHBMalllistTitle];
    [mutableDict setValue:self.thumb forKey:kYHBMalllistThumb];
    [mutableDict setValue:self.price forKey:kYHBMalllistPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBMalllistItemid];

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

    self.title = [aDecoder decodeObjectForKey:kYHBMalllistTitle];
    self.thumb = [aDecoder decodeObjectForKey:kYHBMalllistThumb];
    self.price = [aDecoder decodeObjectForKey:kYHBMalllistPrice];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBMalllistItemid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kYHBMalllistTitle];
    [aCoder encodeObject:_thumb forKey:kYHBMalllistThumb];
    [aCoder encodeObject:_price forKey:kYHBMalllistPrice];
    [aCoder encodeDouble:_itemid forKey:kYHBMalllistItemid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBMalllist *copy = [[YHBMalllist alloc] init];
    
    if (copy) {

        copy.title = [self.title copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.itemid = self.itemid;
    }
    
    return copy;
}


@end
