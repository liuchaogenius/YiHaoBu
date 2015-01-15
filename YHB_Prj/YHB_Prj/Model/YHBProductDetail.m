//
//  YHBProductDetail.m
//
//  Created by   on 15/1/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBProductDetail.h"
#import "YHBSku.h"
#import "YHBExpress.h"
#import "YHBAlbum.h"
#import "YHBComment.h"


NSString *const kYHBDataCatname = @"catname";
NSString *const kYHBDataUserid = @"userid";
NSString *const kYHBDataPrice = @"price";
NSString *const kYHBDataSku = @"sku";
NSString *const kYHBDataTitle = @"title";
NSString *const kYHBDataExpress = @"express";
NSString *const kYHBDataCompany = @"company";
NSString *const kYHBDataItemid = @"itemid";
NSString *const kYHBDataEdittime = @"edittime";
NSString *const kYHBDataFavorite = @"favorite";
NSString *const kYHBDataTypename = @"typename";
NSString *const kYHBDataHits = @"hits";
NSString *const kYHBDataEditdate = @"editdate";
NSString *const kYHBDataTruename = @"truename";
NSString *const kYHBDataUnit1 = @"unit1";
NSString *const kYHBDataAddtime = @"addtime";
NSString *const kYHBDataCatid = @"catid";
NSString *const kYHBDataMobile = @"mobile";
NSString *const kYHBDataAdddate = @"adddate";
NSString *const kYHBDataUnit = @"unit";
NSString *const kYHBDataAvatar = @"avatar";
NSString *const kYHBDataStar2 = @"star2";
NSString *const kYHBDataTypeid = @"typeid";
NSString *const kYHBDataAlbum = @"album";
NSString *const kYHBDataComment = @"comment";
NSString *const kYHBDataStar1 = @"star1";
NSString *const kYHBDataContent = @"content";


@interface YHBProductDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBProductDetail

@synthesize catname = _catname;
@synthesize userid = _userid;
@synthesize price = _price;
@synthesize sku = _sku;
@synthesize title = _title;
@synthesize express = _express;
@synthesize company = _company;
@synthesize itemid = _itemid;
@synthesize edittime = _edittime;
@synthesize favorite = _favorite;
@synthesize typename = _typename;
@synthesize hits = _hits;
@synthesize editdate = _editdate;
@synthesize truename = _truename;
@synthesize unit1 = _unit1;
@synthesize addtime = _addtime;
@synthesize catid = _catid;
@synthesize mobile = _mobile;
@synthesize adddate = _adddate;
@synthesize unit = _unit;
@synthesize avatar = _avatar;
@synthesize star2 = _star2;
@synthesize typeid = _typeid;
@synthesize album = _album;
@synthesize comment = _comment;
@synthesize star1 = _star1;
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
        self.catname = [self objectOrNilForKey:kYHBDataCatname fromDictionary:dict];
        self.userid = [[self objectOrNilForKey:kYHBDataUserid fromDictionary:dict] doubleValue];
        self.price = [self objectOrNilForKey:kYHBDataPrice fromDictionary:dict];
        NSObject *receivedYHBSku = [dict objectForKey:kYHBDataSku];
        NSMutableArray *parsedYHBSku = [NSMutableArray array];
        if ([receivedYHBSku isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedYHBSku) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedYHBSku addObject:[YHBSku modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedYHBSku isKindOfClass:[NSDictionary class]]) {
            [parsedYHBSku addObject:[YHBSku modelObjectWithDictionary:(NSDictionary *)receivedYHBSku]];
        }
        
        self.sku = [NSArray arrayWithArray:parsedYHBSku];
        self.title = [self objectOrNilForKey:kYHBDataTitle fromDictionary:dict];
        NSObject *receivedYHBExpress = [dict objectForKey:kYHBDataExpress];
        NSMutableArray *parsedYHBExpress = [NSMutableArray array];
        if ([receivedYHBExpress isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedYHBExpress) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedYHBExpress addObject:[YHBExpress modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedYHBExpress isKindOfClass:[NSDictionary class]]) {
            [parsedYHBExpress addObject:[YHBExpress modelObjectWithDictionary:(NSDictionary *)receivedYHBExpress]];
        }
        
        self.express = [NSArray arrayWithArray:parsedYHBExpress];
        self.company = [self objectOrNilForKey:kYHBDataCompany fromDictionary:dict];
        self.itemid = [[self objectOrNilForKey:kYHBDataItemid fromDictionary:dict] doubleValue];
        self.edittime = [self objectOrNilForKey:kYHBDataEdittime fromDictionary:dict];
        self.favorite = [[self objectOrNilForKey:kYHBDataFavorite fromDictionary:dict] doubleValue];
        self.typename = [self objectOrNilForKey:kYHBDataTypename fromDictionary:dict];
        self.hits = [[self objectOrNilForKey:kYHBDataHits fromDictionary:dict] doubleValue];
        self.editdate = [self objectOrNilForKey:kYHBDataEditdate fromDictionary:dict];
        self.truename = [self objectOrNilForKey:kYHBDataTruename fromDictionary:dict];
        self.unit1 = [self objectOrNilForKey:kYHBDataUnit1 fromDictionary:dict];
        self.addtime = [self objectOrNilForKey:kYHBDataAddtime fromDictionary:dict];
        self.catid = [self objectOrNilForKey:kYHBDataCatid fromDictionary:dict];
        self.mobile = [self objectOrNilForKey:kYHBDataMobile fromDictionary:dict];
        self.adddate = [self objectOrNilForKey:kYHBDataAdddate fromDictionary:dict];
        self.unit = [self objectOrNilForKey:kYHBDataUnit fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kYHBDataAvatar fromDictionary:dict];
        self.star2 = [self objectOrNilForKey:kYHBDataStar2 fromDictionary:dict];
        self.typeid = [self objectOrNilForKey:kYHBDataTypeid fromDictionary:dict];
        NSObject *receivedYHBAlbum = [dict objectForKey:kYHBDataAlbum];
        NSMutableArray *parsedYHBAlbum = [NSMutableArray array];
        if ([receivedYHBAlbum isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedYHBAlbum) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedYHBAlbum addObject:[YHBAlbum modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedYHBAlbum isKindOfClass:[NSDictionary class]]) {
            [parsedYHBAlbum addObject:[YHBAlbum modelObjectWithDictionary:(NSDictionary *)receivedYHBAlbum]];
        }
        
        self.album = [NSArray arrayWithArray:parsedYHBAlbum];
        NSObject *receivedYHBComment = [dict objectForKey:kYHBDataComment];
        NSMutableArray *parsedYHBComment = [NSMutableArray array];
        if ([receivedYHBComment isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedYHBComment) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedYHBComment addObject:[YHBComment modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedYHBComment isKindOfClass:[NSDictionary class]]) {
            [parsedYHBComment addObject:[YHBComment modelObjectWithDictionary:(NSDictionary *)receivedYHBComment]];
        }
        
        self.comment = [NSArray arrayWithArray:parsedYHBComment];
        self.star1 = [self objectOrNilForKey:kYHBDataStar1 fromDictionary:dict];
        self.content = [self objectOrNilForKey:kYHBDataContent fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBDataCatname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBDataUserid];
    [mutableDict setValue:self.price forKey:kYHBDataPrice];
    NSMutableArray *tempArrayForSku = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sku) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSku addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSku addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSku] forKey:kYHBDataSku];
    [mutableDict setValue:self.title forKey:kYHBDataTitle];
    NSMutableArray *tempArrayForExpress = [NSMutableArray array];
    for (NSObject *subArrayObject in self.express) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForExpress addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForExpress addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForExpress] forKey:kYHBDataExpress];
    [mutableDict setValue:self.company forKey:kYHBDataCompany];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBDataItemid];
    [mutableDict setValue:self.edittime forKey:kYHBDataEdittime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.favorite] forKey:kYHBDataFavorite];
    [mutableDict setValue:self.typename forKey:kYHBDataTypename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hits] forKey:kYHBDataHits];
    [mutableDict setValue:self.editdate forKey:kYHBDataEditdate];
    [mutableDict setValue:self.truename forKey:kYHBDataTruename];
    [mutableDict setValue:self.unit1 forKey:kYHBDataUnit1];
    [mutableDict setValue:self.addtime forKey:kYHBDataAddtime];
    [mutableDict setValue:self.catid forKey:kYHBDataCatid];
    [mutableDict setValue:self.mobile forKey:kYHBDataMobile];
    [mutableDict setValue:self.adddate forKey:kYHBDataAdddate];
    [mutableDict setValue:self.unit forKey:kYHBDataUnit];
    [mutableDict setValue:self.avatar forKey:kYHBDataAvatar];
    [mutableDict setValue:self.star2 forKey:kYHBDataStar2];
    [mutableDict setValue:self.typeid forKey:kYHBDataTypeid];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAlbum] forKey:kYHBDataAlbum];
    NSMutableArray *tempArrayForComment = [NSMutableArray array];
    for (NSObject *subArrayObject in self.comment) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForComment addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForComment addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComment] forKey:kYHBDataComment];
    [mutableDict setValue:self.star1 forKey:kYHBDataStar1];
    [mutableDict setValue:self.content forKey:kYHBDataContent];
    
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
    
    self.catname = [aDecoder decodeObjectForKey:kYHBDataCatname];
    self.userid = [aDecoder decodeDoubleForKey:kYHBDataUserid];
    self.price = [aDecoder decodeObjectForKey:kYHBDataPrice];
    self.sku = [aDecoder decodeObjectForKey:kYHBDataSku];
    self.title = [aDecoder decodeObjectForKey:kYHBDataTitle];
    self.express = [aDecoder decodeObjectForKey:kYHBDataExpress];
    self.company = [aDecoder decodeObjectForKey:kYHBDataCompany];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBDataItemid];
    self.edittime = [aDecoder decodeObjectForKey:kYHBDataEdittime];
    self.favorite = [aDecoder decodeDoubleForKey:kYHBDataFavorite];
    self.typename = [aDecoder decodeObjectForKey:kYHBDataTypename];
    self.hits = [aDecoder decodeDoubleForKey:kYHBDataHits];
    self.editdate = [aDecoder decodeObjectForKey:kYHBDataEditdate];
    self.truename = [aDecoder decodeObjectForKey:kYHBDataTruename];
    self.unit1 = [aDecoder decodeObjectForKey:kYHBDataUnit1];
    self.addtime = [aDecoder decodeObjectForKey:kYHBDataAddtime];
    self.catid = [aDecoder decodeObjectForKey:kYHBDataCatid];
    self.mobile = [aDecoder decodeObjectForKey:kYHBDataMobile];
    self.adddate = [aDecoder decodeObjectForKey:kYHBDataAdddate];
    self.unit = [aDecoder decodeObjectForKey:kYHBDataUnit];
    self.avatar = [aDecoder decodeObjectForKey:kYHBDataAvatar];
    self.star2 = [aDecoder decodeObjectForKey:kYHBDataStar2];
    self.typeid = [aDecoder decodeObjectForKey:kYHBDataTypeid];
    self.album = [aDecoder decodeObjectForKey:kYHBDataAlbum];
    self.comment = [aDecoder decodeObjectForKey:kYHBDataComment];
    self.star1 = [aDecoder decodeObjectForKey:kYHBDataStar1];
    self.content = [aDecoder decodeObjectForKey:kYHBDataContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_catname forKey:kYHBDataCatname];
    [aCoder encodeDouble:_userid forKey:kYHBDataUserid];
    [aCoder encodeObject:_price forKey:kYHBDataPrice];
    [aCoder encodeObject:_sku forKey:kYHBDataSku];
    [aCoder encodeObject:_title forKey:kYHBDataTitle];
    [aCoder encodeObject:_express forKey:kYHBDataExpress];
    [aCoder encodeObject:_company forKey:kYHBDataCompany];
    [aCoder encodeDouble:_itemid forKey:kYHBDataItemid];
    [aCoder encodeObject:_edittime forKey:kYHBDataEdittime];
    [aCoder encodeDouble:_favorite forKey:kYHBDataFavorite];
    [aCoder encodeObject:_typename forKey:kYHBDataTypename];
    [aCoder encodeDouble:_hits forKey:kYHBDataHits];
    [aCoder encodeObject:_editdate forKey:kYHBDataEditdate];
    [aCoder encodeObject:_truename forKey:kYHBDataTruename];
    [aCoder encodeObject:_unit1 forKey:kYHBDataUnit1];
    [aCoder encodeObject:_addtime forKey:kYHBDataAddtime];
    [aCoder encodeObject:_catid forKey:kYHBDataCatid];
    [aCoder encodeObject:_mobile forKey:kYHBDataMobile];
    [aCoder encodeObject:_adddate forKey:kYHBDataAdddate];
    [aCoder encodeObject:_unit forKey:kYHBDataUnit];
    [aCoder encodeObject:_avatar forKey:kYHBDataAvatar];
    [aCoder encodeObject:_star2 forKey:kYHBDataStar2];
    [aCoder encodeObject:_typeid forKey:kYHBDataTypeid];
    [aCoder encodeObject:_album forKey:kYHBDataAlbum];
    [aCoder encodeObject:_comment forKey:kYHBDataComment];
    [aCoder encodeObject:_star1 forKey:kYHBDataStar1];
    [aCoder encodeObject:_content forKey:kYHBDataContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBProductDetail *copy = [[YHBProductDetail alloc] init];
    
    if (copy) {
        
        copy.catname = [self.catname copyWithZone:zone];
        copy.userid = self.userid;
        copy.price = [self.price copyWithZone:zone];
        copy.sku = [self.sku copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.express = [self.express copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.edittime = [self.edittime copyWithZone:zone];
        copy.favorite = self.favorite;
        copy.typename = [self.typename copyWithZone:zone];
        copy.hits = self.hits;
        copy.editdate = [self.editdate copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.unit1 = [self.unit1 copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.catid = [self.catid copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.unit = [self.unit copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.star2 = [self.star2 copyWithZone:zone];
        copy.typeid = [self.typeid copyWithZone:zone];
        copy.album = [self.album copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.star1 = [self.star1 copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
