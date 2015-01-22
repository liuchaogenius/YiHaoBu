//
//  YHBOConfirmModel.m
//
//  Created by   on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOConfirmModel.h"
#import "YHBOConfirmRslist.h"


NSString *const kYHBOConfirmModelRslist = @"rslist";
NSString *const kYHBOConfirmModelBuyerAddress = @"buyer_address";
NSString *const kYHBOConfirmModelBuyerName = @"buyer_name";
NSString *const kYHBOConfirmModelBuyerMobile = @"buyer_mobile";


@interface YHBOConfirmModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOConfirmModel

@synthesize rslist = _rslist;
@synthesize buyerAddress = _buyerAddress;
@synthesize buyerName = _buyerName;
@synthesize buyerMobile = _buyerMobile;


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
    NSObject *receivedYHBOConfirmRslist = [dict objectForKey:kYHBOConfirmModelRslist];
    NSMutableArray *parsedYHBOConfirmRslist = [NSMutableArray array];
    if ([receivedYHBOConfirmRslist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBOConfirmRslist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBOConfirmRslist addObject:[YHBOConfirmRslist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBOConfirmRslist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBOConfirmRslist addObject:[YHBOConfirmRslist modelObjectWithDictionary:(NSDictionary *)receivedYHBOConfirmRslist]];
    }

    self.rslist = [NSArray arrayWithArray:parsedYHBOConfirmRslist];
            self.buyerAddress = [self objectOrNilForKey:kYHBOConfirmModelBuyerAddress fromDictionary:dict];
            self.buyerName = [self objectOrNilForKey:kYHBOConfirmModelBuyerName fromDictionary:dict];
            self.buyerMobile = [self objectOrNilForKey:kYHBOConfirmModelBuyerMobile fromDictionary:dict];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRslist] forKey:kYHBOConfirmModelRslist];
    [mutableDict setValue:self.buyerAddress forKey:kYHBOConfirmModelBuyerAddress];
    [mutableDict setValue:self.buyerName forKey:kYHBOConfirmModelBuyerName];
    [mutableDict setValue:self.buyerMobile forKey:kYHBOConfirmModelBuyerMobile];

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

    self.rslist = [aDecoder decodeObjectForKey:kYHBOConfirmModelRslist];
    self.buyerAddress = [aDecoder decodeObjectForKey:kYHBOConfirmModelBuyerAddress];
    self.buyerName = [aDecoder decodeObjectForKey:kYHBOConfirmModelBuyerName];
    self.buyerMobile = [aDecoder decodeObjectForKey:kYHBOConfirmModelBuyerMobile];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_rslist forKey:kYHBOConfirmModelRslist];
    [aCoder encodeObject:_buyerAddress forKey:kYHBOConfirmModelBuyerAddress];
    [aCoder encodeObject:_buyerName forKey:kYHBOConfirmModelBuyerName];
    [aCoder encodeObject:_buyerMobile forKey:kYHBOConfirmModelBuyerMobile];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOConfirmModel *copy = [[YHBOConfirmModel alloc] init];
    
    if (copy) {

        copy.rslist = [self.rslist copyWithZone:zone];
        copy.buyerAddress = [self.buyerAddress copyWithZone:zone];
        copy.buyerName = [self.buyerName copyWithZone:zone];
        copy.buyerMobile = [self.buyerMobile copyWithZone:zone];
    }
    
    return copy;
}


@end
