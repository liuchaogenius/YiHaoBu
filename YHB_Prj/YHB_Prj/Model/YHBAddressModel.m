//
//  YHBAddressModel.m
//
//  Created by   on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBAddressModel.h"


NSString *const kYHBAddressModelAddress = @"address";
NSString *const kYHBAddressModelAreaid = @"areaid";
NSString *const kYHBAddressModelMobile = @"mobile";
NSString *const kYHBAddressModelArea = @"area";
NSString *const kYHBAddressModelTruename = @"truename";
NSString *const kYHBAddressModelIsmain = @"ismain";
NSString *const kYHBAddressModelItemid = @"itemid";


@interface YHBAddressModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBAddressModel

@synthesize address = _address;
@synthesize areaid = _areaid;
@synthesize mobile = _mobile;
@synthesize area = _area;
@synthesize truename = _truename;
@synthesize ismain = _ismain;
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
            self.address = [self objectOrNilForKey:kYHBAddressModelAddress fromDictionary:dict];
            self.areaid = [[self objectOrNilForKey:kYHBAddressModelAreaid fromDictionary:dict] doubleValue];
            self.mobile = [self objectOrNilForKey:kYHBAddressModelMobile fromDictionary:dict];
            self.area = [self objectOrNilForKey:kYHBAddressModelArea fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBAddressModelTruename fromDictionary:dict];
            self.ismain = [[self objectOrNilForKey:kYHBAddressModelIsmain fromDictionary:dict] doubleValue];
            self.itemid = [[self objectOrNilForKey:kYHBAddressModelItemid fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.address forKey:kYHBAddressModelAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaid] forKey:kYHBAddressModelAreaid];
    [mutableDict setValue:self.mobile forKey:kYHBAddressModelMobile];
    [mutableDict setValue:self.area forKey:kYHBAddressModelArea];
    [mutableDict setValue:self.truename forKey:kYHBAddressModelTruename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ismain] forKey:kYHBAddressModelIsmain];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBAddressModelItemid];

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

    self.address = [aDecoder decodeObjectForKey:kYHBAddressModelAddress];
    self.areaid = [aDecoder decodeDoubleForKey:kYHBAddressModelAreaid];
    self.mobile = [aDecoder decodeObjectForKey:kYHBAddressModelMobile];
    self.area = [aDecoder decodeObjectForKey:kYHBAddressModelArea];
    self.truename = [aDecoder decodeObjectForKey:kYHBAddressModelTruename];
    self.ismain = [aDecoder decodeDoubleForKey:kYHBAddressModelIsmain];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBAddressModelItemid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_address forKey:kYHBAddressModelAddress];
    [aCoder encodeDouble:_areaid forKey:kYHBAddressModelAreaid];
    [aCoder encodeObject:_mobile forKey:kYHBAddressModelMobile];
    [aCoder encodeObject:_area forKey:kYHBAddressModelArea];
    [aCoder encodeObject:_truename forKey:kYHBAddressModelTruename];
    [aCoder encodeDouble:_ismain forKey:kYHBAddressModelIsmain];
    [aCoder encodeDouble:_itemid forKey:kYHBAddressModelItemid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBAddressModel *copy = [[YHBAddressModel alloc] init];
    
    if (copy) {

        copy.address = [self.address copyWithZone:zone];
        copy.areaid = self.areaid;
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.ismain = self.ismain;
        copy.itemid = self.itemid;
    }
    
    return copy;
}


@end
