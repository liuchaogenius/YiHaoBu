//
//  YHBSlidelist.m
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBSlidelist.h"


NSString *const kYHBSlidelistThumb = @"thumb";
NSString *const kYHBSlidelistLinkurl = @"linkurl";


@interface YHBSlidelist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBSlidelist

@synthesize thumb = _thumb;
@synthesize linkurl = _linkurl;


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
            self.thumb = [self objectOrNilForKey:kYHBSlidelistThumb fromDictionary:dict];
            self.linkurl = [self objectOrNilForKey:kYHBSlidelistLinkurl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.thumb forKey:kYHBSlidelistThumb];
    [mutableDict setValue:self.linkurl forKey:kYHBSlidelistLinkurl];

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

    self.thumb = [aDecoder decodeObjectForKey:kYHBSlidelistThumb];
    self.linkurl = [aDecoder decodeObjectForKey:kYHBSlidelistLinkurl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_thumb forKey:kYHBSlidelistThumb];
    [aCoder encodeObject:_linkurl forKey:kYHBSlidelistLinkurl];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBSlidelist *copy = [[YHBSlidelist alloc] init];
    
    if (copy) {

        copy.thumb = [self.thumb copyWithZone:zone];
        copy.linkurl = [self.linkurl copyWithZone:zone];
    }
    
    return copy;
}


@end
