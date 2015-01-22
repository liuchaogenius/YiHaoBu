//
//  YHBOConfirmRslist.m
//
//  Created by   on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOConfirmRslist.h"
#import "YHBOConfirmMalllist.h"


NSString *const kYHBOConfirmRslistSeller = @"seller";
NSString *const kYHBOConfirmRslistSellid = @"sellid";
NSString *const kYHBOConfirmRslistMalllist = @"malllist";
NSString *const kYHBOConfirmRslistSellcom = @"sellcom";
NSString *const kYHBOConfirmRslistItemid = @"itemid";


@interface YHBOConfirmRslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOConfirmRslist

@synthesize seller = _seller;
@synthesize sellid = _sellid;
@synthesize malllist = _malllist;
@synthesize sellcom = _sellcom;
@synthesize itemid = _itemid;


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
            self.seller = [self objectOrNilForKey:kYHBOConfirmRslistSeller fromDictionary:dict];
            self.sellid = [[self objectOrNilForKey:kYHBOConfirmRslistSellid fromDictionary:dict] doubleValue];
    NSObject *receivedYHBOConfirmMalllist = [dict objectForKey:kYHBOConfirmRslistMalllist];
    NSMutableArray *parsedYHBOConfirmMalllist = [NSMutableArray array];
    if ([receivedYHBOConfirmMalllist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBOConfirmMalllist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBOConfirmMalllist addObject:[YHBOConfirmMalllist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBOConfirmMalllist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBOConfirmMalllist addObject:[YHBOConfirmMalllist modelObjectWithDictionary:(NSDictionary *)receivedYHBOConfirmMalllist]];
    }

    self.malllist = [NSArray arrayWithArray:parsedYHBOConfirmMalllist];
            self.sellcom = [self objectOrNilForKey:kYHBOConfirmRslistSellcom fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBOConfirmRslistItemid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.seller forKey:kYHBOConfirmRslistSeller];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sellid] forKey:kYHBOConfirmRslistSellid];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMalllist] forKey:kYHBOConfirmRslistMalllist];
    [mutableDict setValue:self.sellcom forKey:kYHBOConfirmRslistSellcom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBOConfirmRslistItemid];

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

    self.seller = [aDecoder decodeObjectForKey:kYHBOConfirmRslistSeller];
    self.sellid = [aDecoder decodeDoubleForKey:kYHBOConfirmRslistSellid];
    self.malllist = [aDecoder decodeObjectForKey:kYHBOConfirmRslistMalllist];
    self.sellcom = [aDecoder decodeObjectForKey:kYHBOConfirmRslistSellcom];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBOConfirmRslistItemid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_seller forKey:kYHBOConfirmRslistSeller];
    [aCoder encodeDouble:_sellid forKey:kYHBOConfirmRslistSellid];
    [aCoder encodeObject:_malllist forKey:kYHBOConfirmRslistMalllist];
    [aCoder encodeObject:_sellcom forKey:kYHBOConfirmRslistSellcom];
    [aCoder encodeDouble:_itemid forKey:kYHBOConfirmRslistItemid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOConfirmRslist *copy = [[YHBOConfirmRslist alloc] init];
    
    if (copy) {

        copy.seller = [self.seller copyWithZone:zone];
        copy.sellid = self.sellid;
        copy.malllist = [self.malllist copyWithZone:zone];
        copy.sellcom = [self.sellcom copyWithZone:zone];
        copy.itemid = self.itemid;
    }
    
    return copy;
}


@end
