//
//  YHBShopCartExpress.m
//
//  Created by  C陈政旭 on 14/12/22
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBShopCartExpress.h"


NSString *const kYHBShopCartExpressName = @"name";
NSString *const kYHBShopCartExpressStart = @"start";
NSString *const kYHBShopCartExpressStep = @"step";


@interface YHBShopCartExpress ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBShopCartExpress

@synthesize name = _name;
@synthesize start = _start;
@synthesize step = _step;


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
            self.name = [self objectOrNilForKey:kYHBShopCartExpressName fromDictionary:dict];
            self.start = [self objectOrNilForKey:kYHBShopCartExpressStart fromDictionary:dict];
            self.step = [self objectOrNilForKey:kYHBShopCartExpressStep fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kYHBShopCartExpressName];
    [mutableDict setValue:self.start forKey:kYHBShopCartExpressStart];
    [mutableDict setValue:self.step forKey:kYHBShopCartExpressStep];

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

    self.name = [aDecoder decodeObjectForKey:kYHBShopCartExpressName];
    self.start = [aDecoder decodeObjectForKey:kYHBShopCartExpressStart];
    self.step = [aDecoder decodeObjectForKey:kYHBShopCartExpressStep];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kYHBShopCartExpressName];
    [aCoder encodeObject:_start forKey:kYHBShopCartExpressStart];
    [aCoder encodeObject:_step forKey:kYHBShopCartExpressStep];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBShopCartExpress *copy = [[YHBShopCartExpress alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.start = [self.start copyWithZone:zone];
        copy.step = [self.step copyWithZone:zone];
    }
    
    return copy;
}


@end
