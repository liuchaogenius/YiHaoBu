//
//  YHBSupplyModel.m
//
//  Created by  C陈政旭 on 14/12/6
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBSupplyModel.h"


NSString *const kYHBSupplyModelTypename = @"typename";
NSString *const kYHBSupplyModelItemid = @"itemid";
NSString *const kYHBSupplyModelCatname = @"catname";
NSString *const kYHBSupplyModelTitle = @"title";
NSString *const kYHBSupplyModelEditdate = @"editdate";
NSString *const kYHBSupplyModelThumb = @"thumb";
NSString *const kYHBSupplyModelVip = @"vip";
NSString *const kYHBSupplyModelEdittime = @"edittime";
NSString *const kYHBSupplyModelAmount = @"amount";
NSString *const kYHBSupplyModelUnit = @"unit";
NSString *const kYHBSupplyModelToday = @"today";



@interface YHBSupplyModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBSupplyModel

@synthesize typename = _typename;
@synthesize itemid = _itemid;
@synthesize catname = _catname;
@synthesize title = _title;
@synthesize editdate = _editdate;
@synthesize thumb = _thumb;
@synthesize vip = _vip;
@synthesize edittime = _edittime;
@synthesize amount = _amount;
@synthesize unit = _unit;
@synthesize today = _today;


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
            self.typename = [self objectOrNilForKey:kYHBSupplyModelTypename fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBSupplyModelItemid fromDictionary:dict] intValue];
            self.catname = [self objectOrNilForKey:kYHBSupplyModelCatname fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBSupplyModelTitle fromDictionary:dict];
            self.editdate = [self objectOrNilForKey:kYHBSupplyModelEditdate fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBSupplyModelThumb fromDictionary:dict];
            self.vip = [[self objectOrNilForKey:kYHBSupplyModelVip fromDictionary:dict] intValue];
            self.edittime = [self objectOrNilForKey:kYHBSupplyModelEdittime fromDictionary:dict];
        self.amount = [self objectOrNilForKey:kYHBSupplyModelAmount fromDictionary:dict];
        self.unit = [self objectOrNilForKey:kYHBSupplyModelUnit fromDictionary:dict];
        self.today = [self objectOrNilForKey:kYHBSupplyModelToday fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.typename forKey:kYHBSupplyModelTypename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBSupplyModelItemid];
    [mutableDict setValue:self.catname forKey:kYHBSupplyModelCatname];
    [mutableDict setValue:self.title forKey:kYHBSupplyModelTitle];
    [mutableDict setValue:self.editdate forKey:kYHBSupplyModelEditdate];
    [mutableDict setValue:self.thumb forKey:kYHBSupplyModelThumb];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vip] forKey:kYHBSupplyModelVip];
    [mutableDict setValue:self.edittime forKey:kYHBSupplyModelEdittime];
    [mutableDict setValue:self.amount forKey:kYHBSupplyModelAmount];
    [mutableDict setValue:self.unit forKey:kYHBSupplyModelUnit];
    [mutableDict setValue:self.today forKey:kYHBSupplyModelToday];

    
    
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

    self.typename = [aDecoder decodeObjectForKey:kYHBSupplyModelTypename];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBSupplyModelItemid];
    self.catname = [aDecoder decodeObjectForKey:kYHBSupplyModelCatname];
    self.title = [aDecoder decodeObjectForKey:kYHBSupplyModelTitle];
    self.editdate = [aDecoder decodeObjectForKey:kYHBSupplyModelEditdate];
    self.thumb = [aDecoder decodeObjectForKey:kYHBSupplyModelThumb];
    self.vip = [aDecoder decodeDoubleForKey:kYHBSupplyModelVip];
    self.edittime = [aDecoder decodeObjectForKey:kYHBSupplyModelEdittime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_typename forKey:kYHBSupplyModelTypename];
    [aCoder encodeDouble:_itemid forKey:kYHBSupplyModelItemid];
    [aCoder encodeObject:_catname forKey:kYHBSupplyModelCatname];
    [aCoder encodeObject:_title forKey:kYHBSupplyModelTitle];
    [aCoder encodeObject:_editdate forKey:kYHBSupplyModelEditdate];
    [aCoder encodeObject:_thumb forKey:kYHBSupplyModelThumb];
    [aCoder encodeDouble:_vip forKey:kYHBSupplyModelVip];
    [aCoder encodeObject:_edittime forKey:kYHBSupplyModelEdittime];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBSupplyModel *copy = [[YHBSupplyModel alloc] init];
    
    if (copy) {

        copy.typename = [self.typename copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.catname = [self.catname copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.editdate = [self.editdate copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.vip = self.vip;
        copy.edittime = [self.edittime copyWithZone:zone];
    }
    
    return copy;
}


@end
