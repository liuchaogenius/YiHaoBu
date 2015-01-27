//
//  YHBOConfirmModel.m
//
//  Created by   on 15/1/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOConfirmModel.h"
#import "YHBOConfirmRslist.h"


NSString *const kYHBOConfirmModelAddAddress = @"add_address";
NSString *const kYHBOConfirmModelAddItemid = @"add_itemid";
NSString *const kYHBOConfirmModelAddMobile = @"add_mobile";
NSString *const kYHBOConfirmModelRslist = @"rslist";
NSString *const kYHBOConfirmModelAddTruename = @"add_truename";


@interface YHBOConfirmModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOConfirmModel

@synthesize addAddress = _addAddress;
@synthesize addItemid = _addItemid;
@synthesize addMobile = _addMobile;
@synthesize rslist = _rslist;
@synthesize addTruename = _addTruename;


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
            self.addAddress = [self objectOrNilForKey:kYHBOConfirmModelAddAddress fromDictionary:dict];
            self.addItemid = [[self objectOrNilForKey:kYHBOConfirmModelAddItemid fromDictionary:dict] doubleValue];
            self.addMobile = [self objectOrNilForKey:kYHBOConfirmModelAddMobile fromDictionary:dict];
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
            self.addTruename = [self objectOrNilForKey:kYHBOConfirmModelAddTruename fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addAddress forKey:kYHBOConfirmModelAddAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addItemid] forKey:kYHBOConfirmModelAddItemid];
    [mutableDict setValue:self.addMobile forKey:kYHBOConfirmModelAddMobile];
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
    [mutableDict setValue:self.addTruename forKey:kYHBOConfirmModelAddTruename];

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

    self.addAddress = [aDecoder decodeObjectForKey:kYHBOConfirmModelAddAddress];
    self.addItemid = [aDecoder decodeDoubleForKey:kYHBOConfirmModelAddItemid];
    self.addMobile = [aDecoder decodeObjectForKey:kYHBOConfirmModelAddMobile];
    self.rslist = [aDecoder decodeObjectForKey:kYHBOConfirmModelRslist];
    self.addTruename = [aDecoder decodeObjectForKey:kYHBOConfirmModelAddTruename];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addAddress forKey:kYHBOConfirmModelAddAddress];
    [aCoder encodeDouble:_addItemid forKey:kYHBOConfirmModelAddItemid];
    [aCoder encodeObject:_addMobile forKey:kYHBOConfirmModelAddMobile];
    [aCoder encodeObject:_rslist forKey:kYHBOConfirmModelRslist];
    [aCoder encodeObject:_addTruename forKey:kYHBOConfirmModelAddTruename];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOConfirmModel *copy = [[YHBOConfirmModel alloc] init];
    
    if (copy) {

        copy.addAddress = [self.addAddress copyWithZone:zone];
        copy.addItemid = self.addItemid;
        copy.addMobile = [self.addMobile copyWithZone:zone];
        copy.rslist = [self.rslist copyWithZone:zone];
        copy.addTruename = [self.addTruename copyWithZone:zone];
    }
    
    return copy;
}


@end
