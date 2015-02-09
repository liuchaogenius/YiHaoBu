//
//  UserinfoBaseClass.m
//
//  Created by  C陈政旭 on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserinfoBaseClass.h"


NSString *const kUserinfoBaseClassAvatar = @"avatar";
NSString *const kUserinfoBaseClassTruename = @"truename";


@interface UserinfoBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserinfoBaseClass

@synthesize avatar = _avatar;
@synthesize truename = _truename;


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
            self.avatar = [self objectOrNilForKey:kUserinfoBaseClassAvatar fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kUserinfoBaseClassTruename fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.avatar forKey:kUserinfoBaseClassAvatar];
    [mutableDict setValue:self.truename forKey:kUserinfoBaseClassTruename];

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

    self.avatar = [aDecoder decodeObjectForKey:kUserinfoBaseClassAvatar];
    self.truename = [aDecoder decodeObjectForKey:kUserinfoBaseClassTruename];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_avatar forKey:kUserinfoBaseClassAvatar];
    [aCoder encodeObject:_truename forKey:kUserinfoBaseClassTruename];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserinfoBaseClass *copy = [[UserinfoBaseClass alloc] init];
    
    if (copy) {

        copy.avatar = [self.avatar copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
    }
    
    return copy;
}


@end
