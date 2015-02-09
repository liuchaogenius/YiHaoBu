//
//  YHBBuyDetailData.m
//
//  Created by  C陈政旭 on 14/12/21
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "YHBBuyDetailData.h"
#import "YHBBuyDetailPic.h"


NSString *const kYHBBuyDetailDataFavorite = @"favorite";
NSString *const kYHBBuyDetailDataCatid = @"catid";
NSString *const kYHBBuyDetailDataTypename = @"typename";
NSString *const kYHBBuyDetailDataAdddate = @"adddate";
NSString *const kYHBBuyDetailDataTruename = @"truename";
NSString *const kYHBBuyDetailDataVip = @"vip";
NSString *const kYHBBuyDetailDataUserid = @"userid";
NSString *const kYHBBuyDetailDataAddtime = @"addtime";
NSString *const kYHBBuyDetailDataEdittime = @"edittime";
NSString *const kYHBBuyDetailDataCatname = @"catname";
NSString *const kYHBBuyDetailDataMobile = @"mobile";
NSString *const kYHBBuyDetailDataTitle = @"title";
NSString *const kYHBBuyDetailDataEditdate = @"editdate";
NSString *const kYHBBuyDetailDataPic = @"album";
NSString *const kYHBBuyDetailDataContent = @"introduce";
NSString *const kYHBBuyDetailDataItemid = @"itemid";
NSString *const kYHBBuyDetailDataHits = @"hits";
NSString *const kYHBBuyDetailDataTypeid = @"typeid";
NSString *const kYHBBuyDetailDataToday = @"today";


@interface YHBBuyDetailData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBBuyDetailData

@synthesize favorite = _favorite;
@synthesize catid = _catid;
@synthesize typename = _typename;
@synthesize adddate = _adddate;
@synthesize truename = _truename;
@synthesize vip = _vip;
@synthesize userid = _userid;
@synthesize addtime = _addtime;
@synthesize edittime = _edittime;
@synthesize catname = _catname;
@synthesize mobile = _mobile;
@synthesize title = _title;
@synthesize editdate = _editdate;
@synthesize pic = _pic;
@synthesize content = _content;
@synthesize itemid = _itemid;
@synthesize hits = _hits;
@synthesize typeid = _typeid;
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
        self.today = [[self objectOrNilForKey:kYHBBuyDetailDataToday fromDictionary:dict] intValue];
            self.favorite = [[self objectOrNilForKey:kYHBBuyDetailDataFavorite fromDictionary:dict] doubleValue];
            self.catid = [self objectOrNilForKey:kYHBBuyDetailDataCatid fromDictionary:dict];
            self.typename = [self objectOrNilForKey:kYHBBuyDetailDataTypename fromDictionary:dict];
            self.adddate = [self objectOrNilForKey:kYHBBuyDetailDataAdddate fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBBuyDetailDataTruename fromDictionary:dict];
            self.vip = [[self objectOrNilForKey:kYHBBuyDetailDataVip fromDictionary:dict] doubleValue];
            self.userid = [[self objectOrNilForKey:kYHBBuyDetailDataUserid fromDictionary:dict] doubleValue];
            self.addtime = [self objectOrNilForKey:kYHBBuyDetailDataAddtime fromDictionary:dict];
            self.edittime = [self objectOrNilForKey:kYHBBuyDetailDataEdittime fromDictionary:dict];
            self.catname = [self objectOrNilForKey:kYHBBuyDetailDataCatname fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kYHBBuyDetailDataMobile fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBBuyDetailDataTitle fromDictionary:dict];
            self.editdate = [self objectOrNilForKey:kYHBBuyDetailDataEditdate fromDictionary:dict];
    NSObject *receivedYHBBuyDetailPic = [dict objectForKey:kYHBBuyDetailDataPic];
    NSMutableArray *parsedYHBBuyDetailPic = [NSMutableArray array];
    if ([receivedYHBBuyDetailPic isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBBuyDetailPic) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBBuyDetailPic addObject:[YHBBuyDetailPic modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBBuyDetailPic isKindOfClass:[NSDictionary class]]) {
       [parsedYHBBuyDetailPic addObject:[YHBBuyDetailPic modelObjectWithDictionary:(NSDictionary *)receivedYHBBuyDetailPic]];
    }

    self.pic = [NSArray arrayWithArray:parsedYHBBuyDetailPic];
            self.content = [self objectOrNilForKey:kYHBBuyDetailDataContent fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBBuyDetailDataItemid fromDictionary:dict] doubleValue];
            self.hits = [[self objectOrNilForKey:kYHBBuyDetailDataHits fromDictionary:dict] doubleValue];
            self.typeid = [self objectOrNilForKey:kYHBBuyDetailDataTypeid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.favorite] forKey:kYHBBuyDetailDataFavorite];
    [mutableDict setValue:self.catid forKey:kYHBBuyDetailDataCatid];
    [mutableDict setValue:self.typename forKey:kYHBBuyDetailDataTypename];
    [mutableDict setValue:self.adddate forKey:kYHBBuyDetailDataAdddate];
    [mutableDict setValue:self.truename forKey:kYHBBuyDetailDataTruename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vip] forKey:kYHBBuyDetailDataVip];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBBuyDetailDataUserid];
    [mutableDict setValue:self.addtime forKey:kYHBBuyDetailDataAddtime];
    [mutableDict setValue:self.edittime forKey:kYHBBuyDetailDataEdittime];
    [mutableDict setValue:self.catname forKey:kYHBBuyDetailDataCatname];
    [mutableDict setValue:self.mobile forKey:kYHBBuyDetailDataMobile];
    [mutableDict setValue:self.title forKey:kYHBBuyDetailDataTitle];
    [mutableDict setValue:self.editdate forKey:kYHBBuyDetailDataEditdate];
    [mutableDict setValue:[NSNumber numberWithInt:self.today] forKey:kYHBBuyDetailDataToday];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPic] forKey:kYHBBuyDetailDataPic];
    [mutableDict setValue:self.content forKey:kYHBBuyDetailDataContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBBuyDetailDataItemid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hits] forKey:kYHBBuyDetailDataHits];
    [mutableDict setValue:self.typeid forKey:kYHBBuyDetailDataTypeid];

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

    self.favorite = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataFavorite];
    self.catid = [aDecoder decodeObjectForKey:kYHBBuyDetailDataCatid];
    self.typename = [aDecoder decodeObjectForKey:kYHBBuyDetailDataTypename];
    self.adddate = [aDecoder decodeObjectForKey:kYHBBuyDetailDataAdddate];
    self.truename = [aDecoder decodeObjectForKey:kYHBBuyDetailDataTruename];
    self.vip = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataVip];
    self.userid = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataUserid];
    self.addtime = [aDecoder decodeObjectForKey:kYHBBuyDetailDataAddtime];
    self.edittime = [aDecoder decodeObjectForKey:kYHBBuyDetailDataEdittime];
    self.catname = [aDecoder decodeObjectForKey:kYHBBuyDetailDataCatname];
    self.mobile = [aDecoder decodeObjectForKey:kYHBBuyDetailDataMobile];
    self.title = [aDecoder decodeObjectForKey:kYHBBuyDetailDataTitle];
    self.editdate = [aDecoder decodeObjectForKey:kYHBBuyDetailDataEditdate];
    self.pic = [aDecoder decodeObjectForKey:kYHBBuyDetailDataPic];
    self.content = [aDecoder decodeObjectForKey:kYHBBuyDetailDataContent];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataItemid];
    self.hits = [aDecoder decodeDoubleForKey:kYHBBuyDetailDataHits];
    self.typeid = [aDecoder decodeObjectForKey:kYHBBuyDetailDataTypeid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_favorite forKey:kYHBBuyDetailDataFavorite];
    [aCoder encodeObject:_catid forKey:kYHBBuyDetailDataCatid];
    [aCoder encodeObject:_typename forKey:kYHBBuyDetailDataTypename];
    [aCoder encodeObject:_adddate forKey:kYHBBuyDetailDataAdddate];
    [aCoder encodeObject:_truename forKey:kYHBBuyDetailDataTruename];
    [aCoder encodeDouble:_vip forKey:kYHBBuyDetailDataVip];
    [aCoder encodeDouble:_userid forKey:kYHBBuyDetailDataUserid];
    [aCoder encodeObject:_addtime forKey:kYHBBuyDetailDataAddtime];
    [aCoder encodeObject:_edittime forKey:kYHBBuyDetailDataEdittime];
    [aCoder encodeObject:_catname forKey:kYHBBuyDetailDataCatname];
    [aCoder encodeObject:_mobile forKey:kYHBBuyDetailDataMobile];
    [aCoder encodeObject:_title forKey:kYHBBuyDetailDataTitle];
    [aCoder encodeObject:_editdate forKey:kYHBBuyDetailDataEditdate];
    [aCoder encodeObject:_pic forKey:kYHBBuyDetailDataPic];
    [aCoder encodeObject:_content forKey:kYHBBuyDetailDataContent];
    [aCoder encodeDouble:_itemid forKey:kYHBBuyDetailDataItemid];
    [aCoder encodeDouble:_hits forKey:kYHBBuyDetailDataHits];
    [aCoder encodeObject:_typeid forKey:kYHBBuyDetailDataTypeid];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBBuyDetailData *copy = [[YHBBuyDetailData alloc] init];
    
    if (copy) {

        copy.favorite = self.favorite;
        copy.catid = [self.catid copyWithZone:zone];
        copy.typename = [self.typename copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.vip = self.vip;
        copy.userid = self.userid;
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.edittime = [self.edittime copyWithZone:zone];
        copy.catname = [self.catname copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.editdate = [self.editdate copyWithZone:zone];
        copy.pic = [self.pic copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.hits = self.hits;
        copy.typeid = [self.typeid copyWithZone:zone];
    }
    
    return copy;
}


@end
