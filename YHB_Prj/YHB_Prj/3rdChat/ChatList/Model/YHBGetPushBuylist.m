//
//  YHBGetPushBuylist.m
//
//  Created by  C陈政旭 on 15/2/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBGetPushBuylist.h"


NSString *const kYHBGetPushBuylistAdddate = @"adddate";
NSString *const kYHBGetPushBuylistAddtime = @"addtime";
NSString *const kYHBGetPushBuylistIsread = @"isread";
NSString *const kYHBGetPushBuylistItemid = @"itemid";
NSString *const kYHBGetPushBuylistTitle = @"title";
NSString *const kYHBGetPushBuylistThumb = @"thumb";
NSString *const kYHBGetPushBuylistEdittime = @"edittime";


@interface YHBGetPushBuylist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBGetPushBuylist

@synthesize adddate = _adddate;
@synthesize addtime = _addtime;
@synthesize isread = _isread;
@synthesize itemid = _itemid;
@synthesize title = _title;
@synthesize thumb = _thumb;
@synthesize edittime = _edittime;


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
            self.adddate = [self objectOrNilForKey:kYHBGetPushBuylistAdddate fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kYHBGetPushBuylistAddtime fromDictionary:dict];
            self.isread = [self objectOrNilForKey:kYHBGetPushBuylistIsread fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBGetPushBuylistItemid fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kYHBGetPushBuylistTitle fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBGetPushBuylistThumb fromDictionary:dict];
            self.edittime = [self objectOrNilForKey:kYHBGetPushBuylistEdittime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.adddate forKey:kYHBGetPushBuylistAdddate];
    [mutableDict setValue:self.addtime forKey:kYHBGetPushBuylistAddtime];
    [mutableDict setValue:self.isread forKey:kYHBGetPushBuylistIsread];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBGetPushBuylistItemid];
    [mutableDict setValue:self.title forKey:kYHBGetPushBuylistTitle];
    [mutableDict setValue:self.thumb forKey:kYHBGetPushBuylistThumb];
    [mutableDict setValue:self.edittime forKey:kYHBGetPushBuylistEdittime];

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

    self.adddate = [aDecoder decodeObjectForKey:kYHBGetPushBuylistAdddate];
    self.addtime = [aDecoder decodeObjectForKey:kYHBGetPushBuylistAddtime];
    self.isread = [aDecoder decodeObjectForKey:kYHBGetPushBuylistIsread];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBGetPushBuylistItemid];
    self.title = [aDecoder decodeObjectForKey:kYHBGetPushBuylistTitle];
    self.thumb = [aDecoder decodeObjectForKey:kYHBGetPushBuylistThumb];
    self.edittime = [aDecoder decodeObjectForKey:kYHBGetPushBuylistEdittime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_adddate forKey:kYHBGetPushBuylistAdddate];
    [aCoder encodeObject:_addtime forKey:kYHBGetPushBuylistAddtime];
    [aCoder encodeObject:_isread forKey:kYHBGetPushBuylistIsread];
    [aCoder encodeDouble:_itemid forKey:kYHBGetPushBuylistItemid];
    [aCoder encodeObject:_title forKey:kYHBGetPushBuylistTitle];
    [aCoder encodeObject:_thumb forKey:kYHBGetPushBuylistThumb];
    [aCoder encodeObject:_edittime forKey:kYHBGetPushBuylistEdittime];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBGetPushBuylist *copy = [[YHBGetPushBuylist alloc] init];
    
    if (copy) {

        copy.adddate = [self.adddate copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.isread = [self.isread copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.title = [self.title copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.edittime = [self.edittime copyWithZone:zone];
    }
    
    return copy;
}


@end
