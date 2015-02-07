//
//  YHBOConfirmExpress.m
//
//  Created by   on 15/2/7
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOConfirmExpress.h"


NSString *const kYHBOConfirmExpressId = @"id";
NSString *const kYHBOConfirmExpressName = @"name";
NSString *const kYHBOConfirmExpressStep = @"step";
NSString *const kYHBOConfirmExpressStart = @"start";


@interface YHBOConfirmExpress ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOConfirmExpress

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize name = _name;
@synthesize step = _step;
@synthesize start = _start;


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
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kYHBOConfirmExpressId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kYHBOConfirmExpressName fromDictionary:dict];
            self.step = [self objectOrNilForKey:kYHBOConfirmExpressStep fromDictionary:dict];
            self.start = [self objectOrNilForKey:kYHBOConfirmExpressStart fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kYHBOConfirmExpressId];
    [mutableDict setValue:self.name forKey:kYHBOConfirmExpressName];
    [mutableDict setValue:self.step forKey:kYHBOConfirmExpressStep];
    [mutableDict setValue:self.start forKey:kYHBOConfirmExpressStart];

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

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kYHBOConfirmExpressId];
    self.name = [aDecoder decodeObjectForKey:kYHBOConfirmExpressName];
    self.step = [aDecoder decodeObjectForKey:kYHBOConfirmExpressStep];
    self.start = [aDecoder decodeObjectForKey:kYHBOConfirmExpressStart];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kYHBOConfirmExpressId];
    [aCoder encodeObject:_name forKey:kYHBOConfirmExpressName];
    [aCoder encodeObject:_step forKey:kYHBOConfirmExpressStep];
    [aCoder encodeObject:_start forKey:kYHBOConfirmExpressStart];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOConfirmExpress *copy = [[YHBOConfirmExpress alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.name = [self.name copyWithZone:zone];
        copy.step = [self.step copyWithZone:zone];
        copy.start = [self.start copyWithZone:zone];
    }
    
    return copy;
}


@end
