//
//  QuoteRslist.m
//
//  Created by  C陈政旭 on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "QuoteRslist.h"


NSString *const kQuoteRslistAmount = @"amount";
NSString *const kQuoteRslistAddtime = @"addtime";
NSString *const kQuoteRslistAdddate = @"adddate";
NSString *const kQuoteRslistItemid = @"itemid";
NSString *const kQuoteRslistTitle = @"title";
NSString *const kQuoteRslistThumb = @"thumb";
NSString *const kQuoteRslistNew = @"new";


@interface QuoteRslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QuoteRslist

@synthesize amount = _amount;
@synthesize addtime = _addtime;
@synthesize adddate = _adddate;
@synthesize itemid = _itemid;
@synthesize title = _title;
@synthesize thumb = _thumb;
@synthesize new = _new;


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
            self.amount = [self objectOrNilForKey:kQuoteRslistAmount fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kQuoteRslistAddtime fromDictionary:dict];
            self.adddate = [self objectOrNilForKey:kQuoteRslistAdddate fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kQuoteRslistItemid fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kQuoteRslistTitle fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kQuoteRslistThumb fromDictionary:dict];
            self.new = [[self objectOrNilForKey:kQuoteRslistNew fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.amount forKey:kQuoteRslistAmount];
    [mutableDict setValue:self.addtime forKey:kQuoteRslistAddtime];
    [mutableDict setValue:self.adddate forKey:kQuoteRslistAdddate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kQuoteRslistItemid];
    [mutableDict setValue:self.title forKey:kQuoteRslistTitle];
    [mutableDict setValue:self.thumb forKey:kQuoteRslistThumb];
    [mutableDict setValue:[NSNumber numberWithDouble:self.new] forKey:kQuoteRslistNew];

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

    self.amount = [aDecoder decodeObjectForKey:kQuoteRslistAmount];
    self.addtime = [aDecoder decodeObjectForKey:kQuoteRslistAddtime];
    self.adddate = [aDecoder decodeObjectForKey:kQuoteRslistAdddate];
    self.itemid = [aDecoder decodeDoubleForKey:kQuoteRslistItemid];
    self.title = [aDecoder decodeObjectForKey:kQuoteRslistTitle];
    self.thumb = [aDecoder decodeObjectForKey:kQuoteRslistThumb];
    self.new = [aDecoder decodeDoubleForKey:kQuoteRslistNew];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_amount forKey:kQuoteRslistAmount];
    [aCoder encodeObject:_addtime forKey:kQuoteRslistAddtime];
    [aCoder encodeObject:_adddate forKey:kQuoteRslistAdddate];
    [aCoder encodeDouble:_itemid forKey:kQuoteRslistItemid];
    [aCoder encodeObject:_title forKey:kQuoteRslistTitle];
    [aCoder encodeObject:_thumb forKey:kQuoteRslistThumb];
    [aCoder encodeDouble:_new forKey:kQuoteRslistNew];
}

- (id)copyWithZone:(NSZone *)zone
{
    QuoteRslist *copy = [[QuoteRslist alloc] init];
    
    if (copy) {

        copy.amount = [self.amount copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.title = [self.title copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.new = self.new;
    }
    
    return copy;
}


@end
