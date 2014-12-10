//
//  YHBShopCartRslist.m
//
//  Created by  C陈政旭 on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBShopCartRslist.h"
#import "YHBShopCartCartlist.h"


NSString *const kYHBShopCartRslistUserid = @"userid";
NSString *const kYHBShopCartRslistCompany = @"company";
NSString *const kYHBShopCartRslistTruename = @"truename";
NSString *const kYHBShopCartRslistCartlist = @"cartlist";


@interface YHBShopCartRslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBShopCartRslist

@synthesize userid = _userid;
@synthesize company = _company;
@synthesize truename = _truename;
@synthesize cartlist = _cartlist;


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
            self.userid = [[self objectOrNilForKey:kYHBShopCartRslistUserid fromDictionary:dict] intValue];
            self.company = [self objectOrNilForKey:kYHBShopCartRslistCompany fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBShopCartRslistTruename fromDictionary:dict];
    NSObject *receivedYHBShopCartCartlist = [dict objectForKey:kYHBShopCartRslistCartlist];
    NSMutableArray *parsedYHBShopCartCartlist = [NSMutableArray array];
    if ([receivedYHBShopCartCartlist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBShopCartCartlist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBShopCartCartlist addObject:[YHBShopCartCartlist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBShopCartCartlist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBShopCartCartlist addObject:[YHBShopCartCartlist modelObjectWithDictionary:(NSDictionary *)receivedYHBShopCartCartlist]];
    }

    self.cartlist = [NSArray arrayWithArray:parsedYHBShopCartCartlist];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBShopCartRslistUserid];
    [mutableDict setValue:self.company forKey:kYHBShopCartRslistCompany];
    [mutableDict setValue:self.truename forKey:kYHBShopCartRslistTruename];
    NSMutableArray *tempArrayForCartlist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.cartlist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCartlist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCartlist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCartlist] forKey:kYHBShopCartRslistCartlist];

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

    self.userid = [aDecoder decodeDoubleForKey:kYHBShopCartRslistUserid];
    self.company = [aDecoder decodeObjectForKey:kYHBShopCartRslistCompany];
    self.truename = [aDecoder decodeObjectForKey:kYHBShopCartRslistTruename];
    self.cartlist = [aDecoder decodeObjectForKey:kYHBShopCartRslistCartlist];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_userid forKey:kYHBShopCartRslistUserid];
    [aCoder encodeObject:_company forKey:kYHBShopCartRslistCompany];
    [aCoder encodeObject:_truename forKey:kYHBShopCartRslistTruename];
    [aCoder encodeObject:_cartlist forKey:kYHBShopCartRslistCartlist];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBShopCartRslist *copy = [[YHBShopCartRslist alloc] init];
    
    if (copy) {

        copy.userid = self.userid;
        copy.company = [self.company copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.cartlist = [self.cartlist copyWithZone:zone];
    }
    
    return copy;
}


@end
