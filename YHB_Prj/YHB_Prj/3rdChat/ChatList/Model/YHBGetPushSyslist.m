//
//  YHBGetPushSyslist.m
//
//  Created by  C陈政旭 on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBGetPushSyslist.h"


NSString *const kYHBGetPushSyslistTitle = @"title";
NSString *const kYHBGetPushSyslistAddtime = @"addtime";
NSString *const kYHBGetPushSyslistAdddate = @"adddate";


@interface YHBGetPushSyslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBGetPushSyslist

@synthesize title = _title;
@synthesize addtime = _addtime;
@synthesize adddate = _adddate;


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
            self.title = [self objectOrNilForKey:kYHBGetPushSyslistTitle fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kYHBGetPushSyslistAddtime fromDictionary:dict];
            self.adddate = [self objectOrNilForKey:kYHBGetPushSyslistAdddate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kYHBGetPushSyslistTitle];
    [mutableDict setValue:self.addtime forKey:kYHBGetPushSyslistAddtime];
    [mutableDict setValue:self.adddate forKey:kYHBGetPushSyslistAdddate];

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

    self.title = [aDecoder decodeObjectForKey:kYHBGetPushSyslistTitle];
    self.addtime = [aDecoder decodeObjectForKey:kYHBGetPushSyslistAddtime];
    self.adddate = [aDecoder decodeObjectForKey:kYHBGetPushSyslistAdddate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kYHBGetPushSyslistTitle];
    [aCoder encodeObject:_addtime forKey:kYHBGetPushSyslistAddtime];
    [aCoder encodeObject:_adddate forKey:kYHBGetPushSyslistAdddate];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBGetPushSyslist *copy = [[YHBGetPushSyslist alloc] init];
    
    if (copy) {

        copy.title = [self.title copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
    }
    
    return copy;
}


@end
