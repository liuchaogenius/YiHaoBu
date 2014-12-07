//
//  YHBSupplyDetailModel.m
//
//  Created by  C陈政旭 on 14/12/7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBSupplyDetailModel.h"
#import "YHBSupplyDetailPic.h"


NSString *const kYHBSupplyDetailModelCatname = @"catname";
NSString *const kYHBSupplyDetailModelUserid = @"userid";
NSString *const kYHBSupplyDetailModelTitle = @"title";
NSString *const kYHBSupplyDetailModelItemid = @"itemid";
NSString *const kYHBSupplyDetailModelFavorite = @"favorite";
NSString *const kYHBSupplyDetailModelTypename = @"typename";
NSString *const kYHBSupplyDetailModelHits = @"hits";
NSString *const kYHBSupplyDetailModelEditdate = @"editdate";
NSString *const kYHBSupplyDetailModelTruename = @"truename";
NSString *const kYHBSupplyDetailModelPic = @"pic";
NSString *const kYHBSupplyDetailModelAddtime = @"addtime";
NSString *const kYHBSupplyDetailModelCatid = @"catid";
NSString *const kYHBSupplyDetailModelMobile = @"mobile";
NSString *const kYHBSupplyDetailModelAdddate = @"adddate";
NSString *const kYHBSupplyDetailModelUnit = @"unit";
NSString *const kYHBSupplyDetailModelVip = @"vip";
NSString *const kYHBSupplyDetailModelPrice = @"price";
NSString *const kYHBSupplyDetailModelEdittime = @"edittime";
NSString *const kYHBSupplyDetailModelTypeid = @"typeid";
NSString *const kYHBSupplyDetailModelContent = @"content";


@interface YHBSupplyDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBSupplyDetailModel

@synthesize catname = _catname;
@synthesize userid = _userid;
@synthesize title = _title;
@synthesize itemid = _itemid;
@synthesize favorite = _favorite;
@synthesize typename = _typename;
@synthesize hits = _hits;
@synthesize editdate = _editdate;
@synthesize truename = _truename;
@synthesize pic = _pic;
@synthesize addtime = _addtime;
@synthesize catid = _catid;
@synthesize mobile = _mobile;
@synthesize adddate = _adddate;
@synthesize unit = _unit;
@synthesize vip = _vip;
@synthesize price = _price;
@synthesize edittime = _edittime;
@synthesize typeid = _typeid;
@synthesize content = _content;


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
            self.catname = [self objectOrNilForKey:kYHBSupplyDetailModelCatname fromDictionary:dict];
            self.userid = [[self objectOrNilForKey:kYHBSupplyDetailModelUserid fromDictionary:dict] intValue];
            self.title = [self objectOrNilForKey:kYHBSupplyDetailModelTitle fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBSupplyDetailModelItemid fromDictionary:dict] intValue];
            self.favorite = [[self objectOrNilForKey:kYHBSupplyDetailModelFavorite fromDictionary:dict] intValue];
            self.typename = [self objectOrNilForKey:kYHBSupplyDetailModelTypename fromDictionary:dict];
            self.hits = [[self objectOrNilForKey:kYHBSupplyDetailModelHits fromDictionary:dict] intValue];
            self.editdate = [self objectOrNilForKey:kYHBSupplyDetailModelEditdate fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBSupplyDetailModelTruename fromDictionary:dict];
    NSObject *receivedYHBSupplyDetailPic = [dict objectForKey:kYHBSupplyDetailModelPic];
    NSMutableArray *parsedYHBSupplyDetailPic = [NSMutableArray array];
    if ([receivedYHBSupplyDetailPic isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBSupplyDetailPic) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBSupplyDetailPic addObject:[YHBSupplyDetailPic modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBSupplyDetailPic isKindOfClass:[NSDictionary class]]) {
       [parsedYHBSupplyDetailPic addObject:[YHBSupplyDetailPic modelObjectWithDictionary:(NSDictionary *)receivedYHBSupplyDetailPic]];
    }

    self.pic = [NSArray arrayWithArray:parsedYHBSupplyDetailPic];
            self.addtime = [self objectOrNilForKey:kYHBSupplyDetailModelAddtime fromDictionary:dict];
            self.catid = [self objectOrNilForKey:kYHBSupplyDetailModelCatid fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kYHBSupplyDetailModelMobile fromDictionary:dict];
            self.adddate = [self objectOrNilForKey:kYHBSupplyDetailModelAdddate fromDictionary:dict];
            self.unit = [self objectOrNilForKey:kYHBSupplyDetailModelUnit fromDictionary:dict];
            self.vip = [[self objectOrNilForKey:kYHBSupplyDetailModelVip fromDictionary:dict] intValue];
            self.price = [self objectOrNilForKey:kYHBSupplyDetailModelPrice fromDictionary:dict];
            self.edittime = [self objectOrNilForKey:kYHBSupplyDetailModelEdittime fromDictionary:dict];
            self.typeid = [self objectOrNilForKey:kYHBSupplyDetailModelTypeid fromDictionary:dict];
            self.content = [self objectOrNilForKey:kYHBSupplyDetailModelContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBSupplyDetailModelCatname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBSupplyDetailModelUserid];
    [mutableDict setValue:self.title forKey:kYHBSupplyDetailModelTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBSupplyDetailModelItemid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.favorite] forKey:kYHBSupplyDetailModelFavorite];
    [mutableDict setValue:self.typename forKey:kYHBSupplyDetailModelTypename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hits] forKey:kYHBSupplyDetailModelHits];
    [mutableDict setValue:self.editdate forKey:kYHBSupplyDetailModelEditdate];
    [mutableDict setValue:self.truename forKey:kYHBSupplyDetailModelTruename];
    NSMutableArray *tempArrayForPic = [NSMutableArray array];
    for (NSObject *subArrayObject in self.pic) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPic addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPic addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPic] forKey:kYHBSupplyDetailModelPic];
    [mutableDict setValue:self.addtime forKey:kYHBSupplyDetailModelAddtime];
    [mutableDict setValue:self.catid forKey:kYHBSupplyDetailModelCatid];
    [mutableDict setValue:self.mobile forKey:kYHBSupplyDetailModelMobile];
    [mutableDict setValue:self.adddate forKey:kYHBSupplyDetailModelAdddate];
    [mutableDict setValue:self.unit forKey:kYHBSupplyDetailModelUnit];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vip] forKey:kYHBSupplyDetailModelVip];
    [mutableDict setValue:self.price forKey:kYHBSupplyDetailModelPrice];
    [mutableDict setValue:self.edittime forKey:kYHBSupplyDetailModelEdittime];
    [mutableDict setValue:self.typeid forKey:kYHBSupplyDetailModelTypeid];
    [mutableDict setValue:self.content forKey:kYHBSupplyDetailModelContent];

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

    self.catname = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelCatname];
    self.userid = [aDecoder decodeDoubleForKey:kYHBSupplyDetailModelUserid];
    self.title = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelTitle];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBSupplyDetailModelItemid];
    self.favorite = [aDecoder decodeDoubleForKey:kYHBSupplyDetailModelFavorite];
    self.typename = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelTypename];
    self.hits = [aDecoder decodeDoubleForKey:kYHBSupplyDetailModelHits];
    self.editdate = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelEditdate];
    self.truename = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelTruename];
    self.pic = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelPic];
    self.addtime = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelAddtime];
    self.catid = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelCatid];
    self.mobile = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelMobile];
    self.adddate = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelAdddate];
    self.unit = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelUnit];
    self.vip = [aDecoder decodeDoubleForKey:kYHBSupplyDetailModelVip];
    self.price = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelPrice];
    self.edittime = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelEdittime];
    self.typeid = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelTypeid];
    self.content = [aDecoder decodeObjectForKey:kYHBSupplyDetailModelContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_catname forKey:kYHBSupplyDetailModelCatname];
    [aCoder encodeDouble:_userid forKey:kYHBSupplyDetailModelUserid];
    [aCoder encodeObject:_title forKey:kYHBSupplyDetailModelTitle];
    [aCoder encodeDouble:_itemid forKey:kYHBSupplyDetailModelItemid];
    [aCoder encodeDouble:_favorite forKey:kYHBSupplyDetailModelFavorite];
    [aCoder encodeObject:_typename forKey:kYHBSupplyDetailModelTypename];
    [aCoder encodeDouble:_hits forKey:kYHBSupplyDetailModelHits];
    [aCoder encodeObject:_editdate forKey:kYHBSupplyDetailModelEditdate];
    [aCoder encodeObject:_truename forKey:kYHBSupplyDetailModelTruename];
    [aCoder encodeObject:_pic forKey:kYHBSupplyDetailModelPic];
    [aCoder encodeObject:_addtime forKey:kYHBSupplyDetailModelAddtime];
    [aCoder encodeObject:_catid forKey:kYHBSupplyDetailModelCatid];
    [aCoder encodeObject:_mobile forKey:kYHBSupplyDetailModelMobile];
    [aCoder encodeObject:_adddate forKey:kYHBSupplyDetailModelAdddate];
    [aCoder encodeObject:_unit forKey:kYHBSupplyDetailModelUnit];
    [aCoder encodeDouble:_vip forKey:kYHBSupplyDetailModelVip];
    [aCoder encodeObject:_price forKey:kYHBSupplyDetailModelPrice];
    [aCoder encodeObject:_edittime forKey:kYHBSupplyDetailModelEdittime];
    [aCoder encodeObject:_typeid forKey:kYHBSupplyDetailModelTypeid];
    [aCoder encodeObject:_content forKey:kYHBSupplyDetailModelContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBSupplyDetailModel *copy = [[YHBSupplyDetailModel alloc] init];
    
    if (copy) {

        copy.catname = [self.catname copyWithZone:zone];
        copy.userid = self.userid;
        copy.title = [self.title copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.favorite = self.favorite;
        copy.typename = [self.typename copyWithZone:zone];
        copy.hits = self.hits;
        copy.editdate = [self.editdate copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.pic = [self.pic copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.catid = [self.catid copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.unit = [self.unit copyWithZone:zone];
        copy.vip = self.vip;
        copy.price = [self.price copyWithZone:zone];
        copy.edittime = [self.edittime copyWithZone:zone];
        copy.typeid = [self.typeid copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
