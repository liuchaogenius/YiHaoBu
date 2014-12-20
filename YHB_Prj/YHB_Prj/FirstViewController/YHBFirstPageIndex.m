//
//  YHBFirstPageIndex.m
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBFirstPageIndex.h"
#import "YHBSelllist.h"
#import "YHBMalllist.h"
#import "YHBSlidelist.h"


NSString *const kYHBFirstPageIndexSelllist = @"selllist";
NSString *const kYHBFirstPageIndexMalllist = @"malllist";
NSString *const kYHBFirstPageIndexSlidelist = @"slidelist";
NSString *const kYHBFirstPageIndexTaglist = @"taglist";


@interface YHBFirstPageIndex ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBFirstPageIndex

@synthesize selllist = _selllist;
@synthesize malllist = _malllist;
@synthesize slidelist = _slidelist;
@synthesize taglist = _taglist;


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
    NSObject *receivedYHBSelllist = [dict objectForKey:kYHBFirstPageIndexSelllist];
    NSMutableArray *parsedYHBSelllist = [NSMutableArray array];
    if ([receivedYHBSelllist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBSelllist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBSelllist addObject:[YHBSelllist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBSelllist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBSelllist addObject:[YHBSelllist modelObjectWithDictionary:(NSDictionary *)receivedYHBSelllist]];
    }

    self.selllist = [NSArray arrayWithArray:parsedYHBSelllist];
    NSObject *receivedYHBMalllist = [dict objectForKey:kYHBFirstPageIndexMalllist];
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
    NSObject *receivedYHBSlidelist = [dict objectForKey:kYHBFirstPageIndexSlidelist];
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
            self.taglist = [self objectOrNilForKey:kYHBFirstPageIndexTaglist fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSelllist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.selllist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSelllist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSelllist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSelllist] forKey:kYHBFirstPageIndexSelllist];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMalllist] forKey:kYHBFirstPageIndexMalllist];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSlidelist] forKey:kYHBFirstPageIndexSlidelist];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTaglist] forKey:kYHBFirstPageIndexTaglist];

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

    self.selllist = [aDecoder decodeObjectForKey:kYHBFirstPageIndexSelllist];
    self.malllist = [aDecoder decodeObjectForKey:kYHBFirstPageIndexMalllist];
    self.slidelist = [aDecoder decodeObjectForKey:kYHBFirstPageIndexSlidelist];
    self.taglist = [aDecoder decodeObjectForKey:kYHBFirstPageIndexTaglist];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_selllist forKey:kYHBFirstPageIndexSelllist];
    [aCoder encodeObject:_malllist forKey:kYHBFirstPageIndexMalllist];
    [aCoder encodeObject:_slidelist forKey:kYHBFirstPageIndexSlidelist];
    [aCoder encodeObject:_taglist forKey:kYHBFirstPageIndexTaglist];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBFirstPageIndex *copy = [[YHBFirstPageIndex alloc] init];
    
    if (copy) {

        copy.selllist = [self.selllist copyWithZone:zone];
        copy.malllist = [self.malllist copyWithZone:zone];
        copy.slidelist = [self.slidelist copyWithZone:zone];
        copy.taglist = [self.taglist copyWithZone:zone];
    }
    
    return copy;
}


@end
