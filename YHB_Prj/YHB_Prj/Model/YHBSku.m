//
//  YHBSku.m
//
//  Created by   on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBSku.h"


NSString *const kYHBSkuLarge = @"large";
NSString *const kYHBSkuTitle = @"skuname";
NSString *const kYHBSkuColorid = @"skuid";
NSString *const kYHBSkuThumb = @"thumb";
NSString *const kYHBSkuMiddle = @"middle";


@interface YHBSku ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBSku

@synthesize large = _large;
@synthesize title = _title;
@synthesize colorid = _colorid;
@synthesize thumb = _thumb;
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
            self.large = [self objectOrNilForKey:kYHBSkuLarge fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBSkuTitle fromDictionary:dict];
            self.colorid = [[self objectOrNilForKey:kYHBSkuColorid fromDictionary:dict] doubleValue];
            self.thumb = [self objectOrNilForKey:kYHBSkuThumb fromDictionary:dict];
            self.middle = [self objectOrNilForKey:kYHBSkuMiddle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.large forKey:kYHBSkuLarge];
    [mutableDict setValue:self.title forKey:kYHBSkuTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.colorid] forKey:kYHBSkuColorid];
    [mutableDict setValue:self.thumb forKey:kYHBSkuThumb];
    [mutableDict setValue:self.middle forKey:kYHBSkuMiddle];

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

    self.large = [aDecoder decodeObjectForKey:kYHBSkuLarge];
    self.title = [aDecoder decodeObjectForKey:kYHBSkuTitle];
    self.colorid = [aDecoder decodeDoubleForKey:kYHBSkuColorid];
    self.thumb = [aDecoder decodeObjectForKey:kYHBSkuThumb];
    self.middle = [aDecoder decodeObjectForKey:kYHBSkuMiddle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_large forKey:kYHBSkuLarge];
    [aCoder encodeObject:_title forKey:kYHBSkuTitle];
    [aCoder encodeDouble:_colorid forKey:kYHBSkuColorid];
    [aCoder encodeObject:_thumb forKey:kYHBSkuThumb];
    [aCoder encodeObject:_middle forKey:kYHBSkuMiddle];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBSku *copy = [[YHBSku alloc] init];
    
    if (copy) {

        copy.large = [self.large copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.colorid = self.colorid;
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.middle = [self.middle copyWithZone:zone];
    }
    
    return copy;
}


@end
