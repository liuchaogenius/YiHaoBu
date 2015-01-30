//
//  YHBGetPushData.m
//
//  Created by  C陈政旭 on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBGetPushData.h"
#import "YHBGetPushBuylist.h"
#import "YHBGetPushSyslist.h"


NSString *const kYHBGetPushDataBuylist = @"buylist";
NSString *const kYHBGetPushDataUserid = @"userid";
NSString *const kYHBGetPushDataSyslist = @"syslist";
NSString *const kYHBGetPushDataLasttime = @"lasttime";


@interface YHBGetPushData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBGetPushData

@synthesize buylist = _buylist;
@synthesize userid = _userid;
@synthesize syslist = _syslist;
@synthesize lasttime = _lasttime;


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
    NSObject *receivedYHBGetPushBuylist = [dict objectForKey:kYHBGetPushDataBuylist];
    NSMutableArray *parsedYHBGetPushBuylist = [NSMutableArray array];
    if ([receivedYHBGetPushBuylist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBGetPushBuylist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBGetPushBuylist addObject:[YHBGetPushBuylist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBGetPushBuylist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBGetPushBuylist addObject:[YHBGetPushBuylist modelObjectWithDictionary:(NSDictionary *)receivedYHBGetPushBuylist]];
    }

    self.buylist = [NSArray arrayWithArray:parsedYHBGetPushBuylist];
            self.userid = [[self objectOrNilForKey:kYHBGetPushDataUserid fromDictionary:dict] doubleValue];
    NSObject *receivedYHBGetPushSyslist = [dict objectForKey:kYHBGetPushDataSyslist];
    NSMutableArray *parsedYHBGetPushSyslist = [NSMutableArray array];
    if ([receivedYHBGetPushSyslist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBGetPushSyslist) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBGetPushSyslist addObject:[YHBGetPushSyslist modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBGetPushSyslist isKindOfClass:[NSDictionary class]]) {
       [parsedYHBGetPushSyslist addObject:[YHBGetPushSyslist modelObjectWithDictionary:(NSDictionary *)receivedYHBGetPushSyslist]];
    }

    self.syslist = [NSArray arrayWithArray:parsedYHBGetPushSyslist];
            self.lasttime = [self objectOrNilForKey:kYHBGetPushDataLasttime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForBuylist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.buylist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBuylist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBuylist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBuylist] forKey:kYHBGetPushDataBuylist];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBGetPushDataUserid];
    NSMutableArray *tempArrayForSyslist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.syslist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSyslist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSyslist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSyslist] forKey:kYHBGetPushDataSyslist];
    [mutableDict setValue:self.lasttime forKey:kYHBGetPushDataLasttime];

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

    self.buylist = [aDecoder decodeObjectForKey:kYHBGetPushDataBuylist];
    self.userid = [aDecoder decodeDoubleForKey:kYHBGetPushDataUserid];
    self.syslist = [aDecoder decodeObjectForKey:kYHBGetPushDataSyslist];
    self.lasttime = [aDecoder decodeObjectForKey:kYHBGetPushDataLasttime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_buylist forKey:kYHBGetPushDataBuylist];
    [aCoder encodeDouble:_userid forKey:kYHBGetPushDataUserid];
    [aCoder encodeObject:_syslist forKey:kYHBGetPushDataSyslist];
    [aCoder encodeObject:_lasttime forKey:kYHBGetPushDataLasttime];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBGetPushData *copy = [[YHBGetPushData alloc] init];
    
    if (copy) {

        copy.buylist = [self.buylist copyWithZone:zone];
        copy.userid = self.userid;
        copy.syslist = [self.syslist copyWithZone:zone];
        copy.lasttime = [self.lasttime copyWithZone:zone];
    }
    
    return copy;
}


@end
