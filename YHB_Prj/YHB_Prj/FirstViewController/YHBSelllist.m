//
//  YHBSelllist.m
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBSelllist.h"


NSString *const kYHBSelllistEdittime = @"edittime";
NSString *const kYHBSelllistItemid = @"itemid";
NSString *const kYHBSelllistTitle = @"title";
NSString *const kYHBSelllistThumb = @"thumb";
NSString *const kYHBSelllistHits = @"hits";


@interface YHBSelllist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBSelllist

@synthesize edittime = _edittime;
@synthesize itemid = _itemid;
@synthesize title = _title;
@synthesize thumb = _thumb;
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
            self.edittime = [self objectOrNilForKey:kYHBSelllistEdittime fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBSelllistItemid fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kYHBSelllistTitle fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBSelllistThumb fromDictionary:dict];
            self.hits = [[self objectOrNilForKey:kYHBSelllistHits fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.edittime forKey:kYHBSelllistEdittime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBSelllistItemid];
    [mutableDict setValue:self.title forKey:kYHBSelllistTitle];
    [mutableDict setValue:self.thumb forKey:kYHBSelllistThumb];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hits] forKey:kYHBSelllistHits];

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

    self.edittime = [aDecoder decodeObjectForKey:kYHBSelllistEdittime];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBSelllistItemid];
    self.title = [aDecoder decodeObjectForKey:kYHBSelllistTitle];
    self.thumb = [aDecoder decodeObjectForKey:kYHBSelllistThumb];
    self.hits = [aDecoder decodeDoubleForKey:kYHBSelllistHits];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_edittime forKey:kYHBSelllistEdittime];
    [aCoder encodeDouble:_itemid forKey:kYHBSelllistItemid];
    [aCoder encodeObject:_title forKey:kYHBSelllistTitle];
    [aCoder encodeObject:_thumb forKey:kYHBSelllistThumb];
    [aCoder encodeDouble:_hits forKey:kYHBSelllistHits];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBSelllist *copy = [[YHBSelllist alloc] init];
    
    if (copy) {

        copy.edittime = [self.edittime copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.title = [self.title copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.hits = self.hits;
    }
    
    return copy;
}


@end
