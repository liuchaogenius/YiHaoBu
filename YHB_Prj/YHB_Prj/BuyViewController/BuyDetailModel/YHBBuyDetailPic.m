//
//  YHBBuyDetailPic.m
//
//  Created by  C陈政旭 on 14/12/21
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBBuyDetailPic.h"


NSString *const kYHBBuyDetailPicThumb = @"thumb";
NSString *const kYHBBuyDetailPicLarge = @"large";
NSString *const kYHBBuyDetailPicMiddle = @"middle";


@interface YHBBuyDetailPic ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBBuyDetailPic

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
            self.thumb = [self objectOrNilForKey:kYHBBuyDetailPicThumb fromDictionary:dict];
            self.large = [self objectOrNilForKey:kYHBBuyDetailPicLarge fromDictionary:dict];
            self.middle = [self objectOrNilForKey:kYHBBuyDetailPicMiddle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.thumb forKey:kYHBBuyDetailPicThumb];
    [mutableDict setValue:self.large forKey:kYHBBuyDetailPicLarge];
    [mutableDict setValue:self.middle forKey:kYHBBuyDetailPicMiddle];

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

    self.thumb = [aDecoder decodeObjectForKey:kYHBBuyDetailPicThumb];
    self.large = [aDecoder decodeObjectForKey:kYHBBuyDetailPicLarge];
    self.middle = [aDecoder decodeObjectForKey:kYHBBuyDetailPicMiddle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_thumb forKey:kYHBBuyDetailPicThumb];
    [aCoder encodeObject:_large forKey:kYHBBuyDetailPicLarge];
    [aCoder encodeObject:_middle forKey:kYHBBuyDetailPicMiddle];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBBuyDetailPic *copy = [[YHBBuyDetailPic alloc] init];
    
    if (copy) {

        copy.thumb = [self.thumb copyWithZone:zone];
        copy.large = [self.large copyWithZone:zone];
        copy.middle = [self.middle copyWithZone:zone];
    }
    
    return copy;
}


@end
