//
//  YHBOConfirmExpress.m
//
//  Created by   on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOConfirmExpress.h"


NSString *const kYHBOConfirmExpressName = @"name";
NSString *const kYHBOConfirmExpressStart = @"start";
NSString *const kYHBOConfirmExpressStep = @"step";


@interface YHBOConfirmExpress ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOConfirmExpress

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
            self.name = [self objectOrNilForKey:kYHBOConfirmExpressName fromDictionary:dict];
            self.start = [self objectOrNilForKey:kYHBOConfirmExpressStart fromDictionary:dict];
            self.step = [self objectOrNilForKey:kYHBOConfirmExpressStep fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kYHBOConfirmExpressName];
    [mutableDict setValue:self.start forKey:kYHBOConfirmExpressStart];
    [mutableDict setValue:self.step forKey:kYHBOConfirmExpressStep];

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

    self.name = [aDecoder decodeObjectForKey:kYHBOConfirmExpressName];
    self.start = [aDecoder decodeObjectForKey:kYHBOConfirmExpressStart];
    self.step = [aDecoder decodeObjectForKey:kYHBOConfirmExpressStep];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kYHBOConfirmExpressName];
    [aCoder encodeObject:_start forKey:kYHBOConfirmExpressStart];
    [aCoder encodeObject:_step forKey:kYHBOConfirmExpressStep];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOConfirmExpress *copy = [[YHBOConfirmExpress alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.start = [self.start copyWithZone:zone];
        copy.step = [self.step copyWithZone:zone];
    }
    
    return copy;
}


@end
