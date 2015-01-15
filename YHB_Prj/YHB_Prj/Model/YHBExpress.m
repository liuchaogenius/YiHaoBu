//
//  YHBExpress.m
//
//  Created by   on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBExpress.h"


NSString *const kYHBExpressName = @"name";
NSString *const kYHBExpressStart = @"start";
NSString *const kYHBExpressStep = @"step";


@interface YHBExpress ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBExpress

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
            self.name = [self objectOrNilForKey:kYHBExpressName fromDictionary:dict];
            self.start = [self objectOrNilForKey:kYHBExpressStart fromDictionary:dict];
            self.step = [self objectOrNilForKey:kYHBExpressStep fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kYHBExpressName];
    [mutableDict setValue:self.start forKey:kYHBExpressStart];
    [mutableDict setValue:self.step forKey:kYHBExpressStep];

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

    self.name = [aDecoder decodeObjectForKey:kYHBExpressName];
    self.start = [aDecoder decodeObjectForKey:kYHBExpressStart];
    self.step = [aDecoder decodeObjectForKey:kYHBExpressStep];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kYHBExpressName];
    [aCoder encodeObject:_start forKey:kYHBExpressStart];
    [aCoder encodeObject:_step forKey:kYHBExpressStep];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBExpress *copy = [[YHBExpress alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.start = [self.start copyWithZone:zone];
        copy.step = [self.step copyWithZone:zone];
    }
    
    return copy;
}


@end
