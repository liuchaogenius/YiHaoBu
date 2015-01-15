//
//  YHBAlbum.m
//
//  Created by   on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBAlbum.h"


NSString *const kYHBAlbumThumb = @"thumb";
NSString *const kYHBAlbumLarge = @"large";
NSString *const kYHBAlbumMiddle = @"middle";


@interface YHBAlbum ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBAlbum

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
            self.thumb = [self objectOrNilForKey:kYHBAlbumThumb fromDictionary:dict];
            self.large = [self objectOrNilForKey:kYHBAlbumLarge fromDictionary:dict];
            self.middle = [self objectOrNilForKey:kYHBAlbumMiddle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.thumb forKey:kYHBAlbumThumb];
    [mutableDict setValue:self.large forKey:kYHBAlbumLarge];
    [mutableDict setValue:self.middle forKey:kYHBAlbumMiddle];

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

    self.thumb = [aDecoder decodeObjectForKey:kYHBAlbumThumb];
    self.large = [aDecoder decodeObjectForKey:kYHBAlbumLarge];
    self.middle = [aDecoder decodeObjectForKey:kYHBAlbumMiddle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_thumb forKey:kYHBAlbumThumb];
    [aCoder encodeObject:_large forKey:kYHBAlbumLarge];
    [aCoder encodeObject:_middle forKey:kYHBAlbumMiddle];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBAlbum *copy = [[YHBAlbum alloc] init];
    
    if (copy) {

        copy.thumb = [self.thumb copyWithZone:zone];
        copy.large = [self.large copyWithZone:zone];
        copy.middle = [self.middle copyWithZone:zone];
    }
    
    return copy;
}


@end
