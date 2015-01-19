//
//  YHBOrderList.m
//
//  Created by   on 15/1/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOrderList.h"
#import "YHBORslist.h"
#import "YHBPage.h"


NSString *const kYHBOrderListRslist = @"rslist";
NSString *const kYHBOrderListPage = @"page";


@interface YHBOrderList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOrderList

@synthesize rslist = _rslist;
@synthesize page = _page;


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
    NSObject *receivedYHBRslist = [dict objectForKey:kYHBOrderListRslist];
    NSMutableArray *parsedYHBRslist = [NSMutableArray array];
    if ([receivedYHBRslist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBRslist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBRslist addObject:[YHBORslist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBRslist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBRslist addObject:[YHBORslist modelObjectWithDictionary:(NSDictionary *)receivedYHBRslist]];
    }

        self.rslist = parsedYHBRslist;
            self.page = [YHBPage modelObjectWithDictionary:[dict objectForKey:kYHBOrderListPage]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRslist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rslist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRslist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRslist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRslist] forKey:kYHBOrderListRslist];
    [mutableDict setValue:[self.page dictionaryRepresentation] forKey:kYHBOrderListPage];

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

    self.rslist = [aDecoder decodeObjectForKey:kYHBOrderListRslist];
    self.page = [aDecoder decodeObjectForKey:kYHBOrderListPage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_rslist forKey:kYHBOrderListRslist];
    [aCoder encodeObject:_page forKey:kYHBOrderListPage];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOrderList *copy = [[YHBOrderList alloc] init];
    
    if (copy) {

        copy.rslist = [self.rslist copyWithZone:zone];
        copy.page = [self.page copyWithZone:zone];
    }
    
    return copy;
}


@end
