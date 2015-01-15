//
//  YHBCatData.m
//
//  Created by  C陈政旭 on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBCatData.h"
#import "YHBCatSubcate.h"


NSString *const kYHBCatDataCatname = @"catname";
NSString *const kYHBCatDataCatid = @"catid";
NSString *const kYHBCatDataSubcate = @"subcate";


@interface YHBCatData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBCatData

@synthesize catname = _catname;
@synthesize catid = _catid;
@synthesize subcate = _subcate;


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
            self.catname = [self objectOrNilForKey:kYHBCatDataCatname fromDictionary:dict];
            self.catid = [[self objectOrNilForKey:kYHBCatDataCatid fromDictionary:dict] doubleValue];
    NSObject *receivedYHBCatSubcate = [dict objectForKey:kYHBCatDataSubcate];
    NSMutableArray *parsedYHBCatSubcate = [NSMutableArray array];
    if ([receivedYHBCatSubcate isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBCatSubcate) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBCatSubcate addObject:[YHBCatSubcate modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBCatSubcate isKindOfClass:[NSDictionary class]]) {
       [parsedYHBCatSubcate addObject:[YHBCatSubcate modelObjectWithDictionary:(NSDictionary *)receivedYHBCatSubcate]];
    }

    self.subcate = [NSArray arrayWithArray:parsedYHBCatSubcate];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBCatDataCatname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.catid] forKey:kYHBCatDataCatid];
    NSMutableArray *tempArrayForSubcate = [NSMutableArray array];
    for (NSObject *subArrayObject in self.subcate) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSubcate addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSubcate addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSubcate] forKey:kYHBCatDataSubcate];

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

    self.catname = [aDecoder decodeObjectForKey:kYHBCatDataCatname];
    self.catid = [aDecoder decodeDoubleForKey:kYHBCatDataCatid];
    self.subcate = [aDecoder decodeObjectForKey:kYHBCatDataSubcate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_catname forKey:kYHBCatDataCatname];
    [aCoder encodeDouble:_catid forKey:kYHBCatDataCatid];
    [aCoder encodeObject:_subcate forKey:kYHBCatDataSubcate];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBCatData *copy = [[YHBCatData alloc] init];
    
    if (copy) {

        copy.catname = [self.catname copyWithZone:zone];
        copy.catid = self.catid;
        copy.subcate = [self.subcate copyWithZone:zone];
    }
    
    return copy;
}


@end
