//
//  YHBBuyDetailAlbum.m
//
//  Created by  C陈政旭 on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBBuyDetailAlbum.h"


NSString *const kYHBBuyDetailAlbumThumb = @"thumb";
NSString *const kYHBBuyDetailAlbumLarge = @"large";
NSString *const kYHBBuyDetailAlbumMiddle = @"middle";


@interface YHBBuyDetailAlbum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBBuyDetailAlbum

@synthesize thumb = _thumb;
@synthesize large = _large;
@synthesize middle = _middle;


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
            self.thumb = [self objectOrNilForKey:kYHBBuyDetailAlbumThumb fromDictionary:dict];
            self.large = [self objectOrNilForKey:kYHBBuyDetailAlbumLarge fromDictionary:dict];
            self.middle = [self objectOrNilForKey:kYHBBuyDetailAlbumMiddle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.thumb forKey:kYHBBuyDetailAlbumThumb];
    [mutableDict setValue:self.large forKey:kYHBBuyDetailAlbumLarge];
    [mutableDict setValue:self.middle forKey:kYHBBuyDetailAlbumMiddle];

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

    self.thumb = [aDecoder decodeObjectForKey:kYHBBuyDetailAlbumThumb];
    self.large = [aDecoder decodeObjectForKey:kYHBBuyDetailAlbumLarge];
    self.middle = [aDecoder decodeObjectForKey:kYHBBuyDetailAlbumMiddle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_thumb forKey:kYHBBuyDetailAlbumThumb];
    [aCoder encodeObject:_large forKey:kYHBBuyDetailAlbumLarge];
    [aCoder encodeObject:_middle forKey:kYHBBuyDetailAlbumMiddle];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBBuyDetailAlbum *copy = [[YHBBuyDetailAlbum alloc] init];
    
    if (copy) {

        copy.thumb = [self.thumb copyWithZone:zone];
        copy.large = [self.large copyWithZone:zone];
        copy.middle = [self.middle copyWithZone:zone];
    }
    
    return copy;
}


@end
