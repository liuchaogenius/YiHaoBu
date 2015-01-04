//
//  YHBPic.m
//
//  Created by   on 15/1/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBPic.h"


NSString *const kYHBPicThumb = @"thumb";
NSString *const kYHBPicLarge = @"large";
NSString *const kYHBPicMiddle = @"middle";


@interface YHBPic ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBPic

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
            self.thumb = [self objectOrNilForKey:kYHBPicThumb fromDictionary:dict];
            self.large = [self objectOrNilForKey:kYHBPicLarge fromDictionary:dict];
            self.middle = [self objectOrNilForKey:kYHBPicMiddle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.thumb forKey:kYHBPicThumb];
    [mutableDict setValue:self.large forKey:kYHBPicLarge];
    [mutableDict setValue:self.middle forKey:kYHBPicMiddle];

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

    self.thumb = [aDecoder decodeObjectForKey:kYHBPicThumb];
    self.large = [aDecoder decodeObjectForKey:kYHBPicLarge];
    self.middle = [aDecoder decodeObjectForKey:kYHBPicMiddle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_thumb forKey:kYHBPicThumb];
    [aCoder encodeObject:_large forKey:kYHBPicLarge];
    [aCoder encodeObject:_middle forKey:kYHBPicMiddle];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBPic *copy = [[YHBPic alloc] init];
    
    if (copy) {

        copy.thumb = [self.thumb copyWithZone:zone];
        copy.large = [self.large copyWithZone:zone];
        copy.middle = [self.middle copyWithZone:zone];
    }
    
    return copy;
}


@end
