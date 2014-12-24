//
//  YHBCompanyIndex.m
//
//  Created by   on 14/12/23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBCompanyIndex.h"
#import "YHBMalllist.h"
#import "YHBHotlist.h"
#import "YHBSlidelist.h"
#import "YHBShoplist.h"


NSString *const kYHBCompanyIndexTaglist = @"taglist";
NSString *const kYHBCompanyIndexMalllist = @"malllist";
NSString *const kYHBCompanyIndexHotlist = @"hotlist";
NSString *const kYHBCompanyIndexSlidelist = @"slidelist";
NSString *const kYHBCompanyIndexShoplist = @"shoplist";


@interface YHBCompanyIndex ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBCompanyIndex

@synthesize taglist = _taglist;
@synthesize malllist = _malllist;
@synthesize hotlist = _hotlist;
@synthesize slidelist = _slidelist;
@synthesize shoplist = _shoplist;


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
            self.taglist = [self objectOrNilForKey:kYHBCompanyIndexTaglist fromDictionary:dict];
    NSObject *receivedYHBMalllist = [dict objectForKey:kYHBCompanyIndexMalllist];
    NSMutableArray *parsedYHBMalllist = [NSMutableArray array];
    if ([receivedYHBMalllist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBMalllist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBMalllist addObject:[YHBMalllist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBMalllist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBMalllist addObject:[YHBMalllist modelObjectWithDictionary:(NSDictionary *)receivedYHBMalllist]];
    }

    self.malllist = [NSArray arrayWithArray:parsedYHBMalllist];
    NSObject *receivedYHBHotlist = [dict objectForKey:kYHBCompanyIndexHotlist];
    NSMutableArray *parsedYHBHotlist = [NSMutableArray array];
    if ([receivedYHBHotlist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBHotlist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBHotlist addObject:[YHBHotlist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBHotlist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBHotlist addObject:[YHBHotlist modelObjectWithDictionary:(NSDictionary *)receivedYHBHotlist]];
    }

    self.hotlist = [NSArray arrayWithArray:parsedYHBHotlist];
    NSObject *receivedYHBSlidelist = [dict objectForKey:kYHBCompanyIndexSlidelist];
    NSMutableArray *parsedYHBSlidelist = [NSMutableArray array];
    if ([receivedYHBSlidelist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBSlidelist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBSlidelist addObject:[YHBSlidelist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBSlidelist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBSlidelist addObject:[YHBSlidelist modelObjectWithDictionary:(NSDictionary *)receivedYHBSlidelist]];
    }

    self.slidelist = [NSArray arrayWithArray:parsedYHBSlidelist];
    NSObject *receivedYHBShoplist = [dict objectForKey:kYHBCompanyIndexShoplist];
    NSMutableArray *parsedYHBShoplist = [NSMutableArray array];
    if ([receivedYHBShoplist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBShoplist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBShoplist addObject:[YHBShoplist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBShoplist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBShoplist addObject:[YHBShoplist modelObjectWithDictionary:(NSDictionary *)receivedYHBShoplist]];
    }

    self.shoplist = [NSArray arrayWithArray:parsedYHBShoplist];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForTaglist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.taglist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTaglist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTaglist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTaglist] forKey:kYHBCompanyIndexTaglist];
    NSMutableArray *tempArrayForMalllist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.malllist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMalllist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMalllist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMalllist] forKey:kYHBCompanyIndexMalllist];
    NSMutableArray *tempArrayForHotlist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hotlist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHotlist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHotlist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHotlist] forKey:kYHBCompanyIndexHotlist];
    NSMutableArray *tempArrayForSlidelist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.slidelist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSlidelist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSlidelist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSlidelist] forKey:kYHBCompanyIndexSlidelist];
    NSMutableArray *tempArrayForShoplist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.shoplist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForShoplist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForShoplist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForShoplist] forKey:kYHBCompanyIndexShoplist];

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

    self.taglist = [aDecoder decodeObjectForKey:kYHBCompanyIndexTaglist];
    self.malllist = [aDecoder decodeObjectForKey:kYHBCompanyIndexMalllist];
    self.hotlist = [aDecoder decodeObjectForKey:kYHBCompanyIndexHotlist];
    self.slidelist = [aDecoder decodeObjectForKey:kYHBCompanyIndexSlidelist];
    self.shoplist = [aDecoder decodeObjectForKey:kYHBCompanyIndexShoplist];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_taglist forKey:kYHBCompanyIndexTaglist];
    [aCoder encodeObject:_malllist forKey:kYHBCompanyIndexMalllist];
    [aCoder encodeObject:_hotlist forKey:kYHBCompanyIndexHotlist];
    [aCoder encodeObject:_slidelist forKey:kYHBCompanyIndexSlidelist];
    [aCoder encodeObject:_shoplist forKey:kYHBCompanyIndexShoplist];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBCompanyIndex *copy = [[YHBCompanyIndex alloc] init];
    
    if (copy) {

        copy.taglist = [self.taglist copyWithZone:zone];
        copy.malllist = [self.malllist copyWithZone:zone];
        copy.hotlist = [self.hotlist copyWithZone:zone];
        copy.slidelist = [self.slidelist copyWithZone:zone];
        copy.shoplist = [self.shoplist copyWithZone:zone];
    }
    
    return copy;
}


@end
