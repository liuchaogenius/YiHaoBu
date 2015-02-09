//
//  YHBBuyDetailData.m
//
//  Created by  C陈政旭 on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBBuyDetailData.h"
#import "YHBBuyDetailAlbum.h"


NSString *const kYHBBuyDetailDataCatname = @"catname";
NSString *const kYHBBuyDetailDataUserid = @"userid";
NSString *const kYHBBuyDetailDataTitle = @"title";
NSString *const kYHBBuyDetailDataAmount = @"amount";
NSString *const kYHBBuyDetailDataItemid = @"itemid";
NSString *const kYHBBuyDetailDataFavorite = @"favorite";
NSString *const kYHBBuyDetailDataTypename = @"typename";
NSString *const kYHBBuyDetailDataHits = @"hits";
NSString *const kYHBBuyDetailDataEditdate = @"editdate";
NSString *const kYHBBuyDetailDataToday = @"today";
NSString *const kYHBBuyDetailDataTruename = @"truename";
NSString *const kYHBBuyDetailDataAddtime = @"addtime";
NSString *const kYHBBuyDetailDataCatid = @"catid";
NSString *const kYHBBuyDetailDataMobile = @"mobile";
NSString *const kYHBBuyDetailDataAdddate = @"adddate";
NSString *const kYHBBuyDetailDataUnit = @"unit";
NSString *const kYHBBuyDetailDataVip = @"vip";
NSString *const kYHBBuyDetailDataTypeid = @"typeid";
NSString *const kYHBBuyDetailDataEdittime = @"edittime";
NSString *const kYHBBuyDetailDataAlbum = @"album";
NSString *const kYHBBuyDetailDataIntroduce = @"introduce";


@interface YHBBuyDetailData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBBuyDetailData

@synthesize catname = _catname;
@synthesize userid = _userid;
@synthesize title = _title;
@synthesize amount = _amount;
@synthesize itemid = _itemid;
@synthesize favorite = _favorite;
@synthesize typename = _typename;
@synthesize hits = _hits;
@synthesize editdate = _editdate;
@synthesize today = _today;
@synthesize truename = _truename;
@synthesize addtime = _addtime;
@synthesize catid = _catid;
@synthesize mobile = _mobile;
@synthesize adddate = _adddate;
@synthesize unit = _unit;
@synthesize vip = _vip;
@synthesize typeid = _typeid;
@synthesize edittime = _edittime;
@synthesize album = _album;
@synthesize introduce = _introduce;


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
            self.catname = [self objectOrNilForKey:kYHBBuyDetailDataCatname fromDictionary:dict];
            self.userid = [[self objectOrNilForKey:kYHBBuyDetailDataUserid fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kYHBBuyDetailDataTitle fromDictionary:dict];
            self.amount = [self objectOrNilForKey:kYHBBuyDetailDataAmount fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBBuyDetailDataItemid fromDictionary:dict] doubleValue];
            self.favorite = [[self objectOrNilForKey:kYHBBuyDetailDataFavorite fromDictionary:dict] doubleValue];
            self.typename = [self objectOrNilForKey:kYHBBuyDetailDataTypename fromDictionary:dict];
            self.hits = [[self objectOrNilForKey:kYHBBuyDetailDataHits fromDictionary:dict] doubleValue];
            self.editdate = [self objectOrNilForKey:kYHBBuyDetailDataEditdate fromDictionary:dict];
            self.today = [self objectOrNilForKey:kYHBBuyDetailDataToday fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBBuyDetailDataTruename fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kYHBBuyDetailDataAddtime fromDictionary:dict];
            self.catid = [self objectOrNilForKey:kYHBBuyDetailDataCatid fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kYHBBuyDetailDataMobile fromDictionary:dict];
            self.adddate = [self objectOrNilForKey:kYHBBuyDetailDataAdddate fromDictionary:dict];
            self.unit = [self objectOrNilForKey:kYHBBuyDetailDataUnit fromDictionary:dict];
            self.vip = [[self objectOrNilForKey:kYHBBuyDetailDataVip fromDictionary:dict] doubleValue];
            self.typeid = [self objectOrNilForKey:kYHBBuyDetailDataTypeid fromDictionary:dict];
            self.edittime = [self objectOrNilForKey:kYHBBuyDetailDataEdittime fromDictionary:dict];
    NSObject *receivedYHBBuyDetailAlbum = [dict objectForKey:kYHBBuyDetailDataAlbum];
    NSMutableArray *parsedYHBBuyDetailAlbum = [NSMutableArray array];
    if ([receivedYHBBuyDetailAlbum isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBBuyDetailAlbum) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBBuyDetailAlbum addObject:[YHBBuyDetailAlbum modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBBuyDetailAlbum isKindOfClass:[NSDictionary class]]) {
       [parsedYHBBuyDetailAlbum addObject:[YHBBuyDetailAlbum modelObjectWithDictionary:(NSDictionary *)receivedYHBBuyDetailAlbum]];
    }

    self.album = [NSArray arrayWithArray:parsedYHBBuyDetailAlbum];
            self.introduce = [self objectOrNilForKey:kYHBBuyDetailDataIntroduce fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBBuyDetailDataCatname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBBuyDetailDataUserid];
    [mutableDict setValue:self.title forKey:kYHBBuyDetailDataTitle];
    [mutableDict setValue:self.amount forKey:kYHBBuyDetailDataAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBBuyDetailDataItemid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.favorite] forKey:kYHBBuyDetailDataFavorite];
    [mutableDict setValue:self.typename forKey:kYHBBuyDetailDataTypename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hits] forKey:kYHBBuyDetailDataHits];
    [mutableDict setValue:self.editdate forKey:kYHBBuyDetailDataEditdate];
    [mutableDict setValue:self.today forKey:kYHBBuyDetailDataToday];
    [mutableDict setValue:self.truename forKey:kYHBBuyDetailDataTruename];
    [mutableDict setValue:self.addtime forKey:kYHBBuyDetailDataAddtime];
    [mutableDict setValue:self.catid forKey:kYHBBuyDetailDataCatid];
    [mutableDict setValue:self.mobile forKey:kYHBBuyDetailDataMobile];
    [mutableDict setValue:self.adddate forKey:kYHBBuyDetailDataAdddate];
    [mutableDict setValue:self.unit forKey:kYHBBuyDetailDataUnit];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vip] forKey:kYHBBuyDetailDataVip];
    [mutableDict setValue:self.typeid forKey:kYHBBuyDetailDataTypeid];
    [mutableDict setValue:self.edittime forKey:kYHBBuyDetailDataEdittime];
    NSMutableArray *tempArrayForAlbum = [NSMutableArray array];
    for (NSObject *subArrayObject in self.album) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAlbum addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAlbum addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAlbum] forKey:kYHBBuyDetailDataAlbum];
    [mutableDict setValue:self.introduce forKey:kYHBBuyDetailDataIntroduce];

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

    self.catname = [aDecoder decodeObjectForKey:kYHBBuyDetailDataCatname];
    self.userid = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataUserid];
    self.title = [aDecoder decodeObjectForKey:kYHBBuyDetailDataTitle];
    self.amount = [aDecoder decodeObjectForKey:kYHBBuyDetailDataAmount];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataItemid];
    self.favorite = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataFavorite];
    self.typename = [aDecoder decodeObjectForKey:kYHBBuyDetailDataTypename];
    self.hits = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataHits];
    self.editdate = [aDecoder decodeObjectForKey:kYHBBuyDetailDataEditdate];
    self.today = [aDecoder decodeObjectForKey:kYHBBuyDetailDataToday];
    self.truename = [aDecoder decodeObjectForKey:kYHBBuyDetailDataTruename];
    self.addtime = [aDecoder decodeObjectForKey:kYHBBuyDetailDataAddtime];
    self.catid = [aDecoder decodeObjectForKey:kYHBBuyDetailDataCatid];
    self.mobile = [aDecoder decodeObjectForKey:kYHBBuyDetailDataMobile];
    self.adddate = [aDecoder decodeObjectForKey:kYHBBuyDetailDataAdddate];
    self.unit = [aDecoder decodeObjectForKey:kYHBBuyDetailDataUnit];
    self.vip = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataVip];
    self.typeid = [aDecoder decodeObjectForKey:kYHBBuyDetailDataTypeid];
    self.edittime = [aDecoder decodeObjectForKey:kYHBBuyDetailDataEdittime];
    self.album = [aDecoder decodeObjectForKey:kYHBBuyDetailDataAlbum];
    self.introduce = [aDecoder decodeObjectForKey:kYHBBuyDetailDataIntroduce];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_catname forKey:kYHBBuyDetailDataCatname];
    [aCoder encodeDouble:_userid forKey:kYHBBuyDetailDataUserid];
    [aCoder encodeObject:_title forKey:kYHBBuyDetailDataTitle];
    [aCoder encodeObject:_amount forKey:kYHBBuyDetailDataAmount];
    [aCoder encodeDouble:_itemid forKey:kYHBBuyDetailDataItemid];
    [aCoder encodeDouble:_favorite forKey:kYHBBuyDetailDataFavorite];
    [aCoder encodeObject:_typename forKey:kYHBBuyDetailDataTypename];
    [aCoder encodeDouble:_hits forKey:kYHBBuyDetailDataHits];
    [aCoder encodeObject:_editdate forKey:kYHBBuyDetailDataEditdate];
    [aCoder encodeObject:_today forKey:kYHBBuyDetailDataToday];
    [aCoder encodeObject:_truename forKey:kYHBBuyDetailDataTruename];
    [aCoder encodeObject:_addtime forKey:kYHBBuyDetailDataAddtime];
    [aCoder encodeObject:_catid forKey:kYHBBuyDetailDataCatid];
    [aCoder encodeObject:_mobile forKey:kYHBBuyDetailDataMobile];
    [aCoder encodeObject:_adddate forKey:kYHBBuyDetailDataAdddate];
    [aCoder encodeObject:_unit forKey:kYHBBuyDetailDataUnit];
    [aCoder encodeDouble:_vip forKey:kYHBBuyDetailDataVip];
    [aCoder encodeObject:_typeid forKey:kYHBBuyDetailDataTypeid];
    [aCoder encodeObject:_edittime forKey:kYHBBuyDetailDataEdittime];
    [aCoder encodeObject:_album forKey:kYHBBuyDetailDataAlbum];
    [aCoder encodeObject:_introduce forKey:kYHBBuyDetailDataIntroduce];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBBuyDetailData *copy = [[YHBBuyDetailData alloc] init];
    
    if (copy) {

        copy.catname = [self.catname copyWithZone:zone];
        copy.userid = self.userid;
        copy.title = [self.title copyWithZone:zone];
        copy.amount = [self.amount copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.favorite = self.favorite;
        copy.typename = [self.typename copyWithZone:zone];
        copy.hits = self.hits;
        copy.editdate = [self.editdate copyWithZone:zone];
        copy.today = [self.today copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.catid = [self.catid copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.unit = [self.unit copyWithZone:zone];
        copy.vip = self.vip;
        copy.typeid = [self.typeid copyWithZone:zone];
        copy.edittime = [self.edittime copyWithZone:zone];
        copy.album = [self.album copyWithZone:zone];
        copy.introduce = [self.introduce copyWithZone:zone];
    }
    
    return copy;
}


@end
