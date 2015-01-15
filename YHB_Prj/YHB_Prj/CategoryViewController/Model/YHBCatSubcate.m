//
//  YHBCatSubcate.m
//
//  Created by  C陈政旭 on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBCatSubcate.h"


NSString *const kYHBCatSubcateCatname = @"catname";
NSString *const kYHBCatSubcateCatid = @"catid";


@interface YHBCatSubcate ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBCatSubcate

@synthesize catname = _catname;
@synthesize catid = _catid;


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
            self.catname = [self objectOrNilForKey:kYHBCatSubcateCatname fromDictionary:dict];
            self.catid = [[self objectOrNilForKey:kYHBCatSubcateCatid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBCatSubcateCatname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.catid] forKey:kYHBCatSubcateCatid];

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

    self.catname = [aDecoder decodeObjectForKey:kYHBCatSubcateCatname];
    self.catid = [aDecoder decodeDoubleForKey:kYHBCatSubcateCatid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_catname forKey:kYHBCatSubcateCatname];
    [aCoder encodeDouble:_catid forKey:kYHBCatSubcateCatid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBCatSubcate *copy = [[YHBCatSubcate alloc] init];
    
    if (copy) {

        copy.catname = [self.catname copyWithZone:zone];
        copy.catid = self.catid;
    }
    
    return copy;
}


@end
