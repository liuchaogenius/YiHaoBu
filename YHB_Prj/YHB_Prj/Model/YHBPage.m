//
//  YHBPage.m
//
//  Created by   on 14/12/30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBPage.h"


NSString *const kYHBPagePageid = @"pageid";
NSString *const kYHBPagePagetotal = @"pagetotal";


@interface YHBPage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBPage

@synthesize pageid = _pageid;
@synthesize pagetotal = _pagetotal;


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
            self.pageid = [[self objectOrNilForKey:kYHBPagePageid fromDictionary:dict] doubleValue];
            self.pagetotal = [[self objectOrNilForKey:kYHBPagePagetotal fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageid] forKey:kYHBPagePageid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pagetotal] forKey:kYHBPagePagetotal];

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

    self.pageid = [aDecoder decodeDoubleForKey:kYHBPagePageid];
    self.pagetotal = [aDecoder decodeDoubleForKey:kYHBPagePagetotal];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_pageid forKey:kYHBPagePageid];
    [aCoder encodeDouble:_pagetotal forKey:kYHBPagePagetotal];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBPage *copy = [[YHBPage alloc] init];
    
    if (copy) {

        copy.pageid = self.pageid;
        copy.pagetotal = self.pagetotal;
    }
    
    return copy;
}


@end
