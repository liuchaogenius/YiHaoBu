//
//  YHBProductDetail.m
//
//  Created by   on 15/1/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBProductDetail.h"
#import "YHBSku.h"
#import "YHBExpress.h"
#import "YHBPic.h"
#import "YHBComment.h"


NSString *const kYHBProductDetailCatname = @"catname";
NSString *const kYHBProductDetailUserid = @"userid";
NSString *const kYHBProductDetailContent = @"content";
NSString *const kYHBProductDetailSku = @"sku";
NSString *const kYHBProductDetailTitle = @"title";
NSString *const kYHBProductDetailExpress = @"express";
NSString *const kYHBProductDetailCompany = @"company";
NSString *const kYHBProductDetailItemid = @"itemid";
NSString *const kYHBProductDetailFavorite = @"favorite";
NSString *const kYHBProductDetailTypename = @"typename";
NSString *const kYHBProductDetailHits = @"hits";
NSString *const kYHBProductDetailEditdate = @"editdate";
NSString *const kYHBProductDetailTruename = @"truename";
NSString *const kYHBProductDetailUnit1 = @"unit1";
NSString *const kYHBProductDetailPic = @"pic";
NSString *const kYHBProductDetailAddtime = @"addtime";
NSString *const kYHBProductDetailCatid = @"catid";
NSString *const kYHBProductDetailMobile = @"mobile";
NSString *const kYHBProductDetailAdddate = @"adddate";
NSString *const kYHBProductDetailUnit = @"unit";
NSString *const kYHBProductDetailAvatar = @"avatar";
NSString *const kYHBProductDetailStar2 = @"star2";
NSString *const kYHBProductDetailTypeid = @"typeid";
NSString *const kYHBProductDetailComment = @"comment";
NSString *const kYHBProductDetailPrice = @"price";
NSString *const kYHBProductDetailStar1 = @"star1";
NSString *const kYHBProductDetailEdittime = @"edittime";


@interface YHBProductDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBProductDetail

@synthesize catname = _catname;
@synthesize userid = _userid;
@synthesize content = _content;
@synthesize sku = _sku;
@synthesize title = _title;
@synthesize express = _express;
@synthesize company = _company;
@synthesize itemid = _itemid;
@synthesize favorite = _favorite;
@synthesize typename = _typename;
@synthesize hits = _hits;
@synthesize editdate = _editdate;
@synthesize truename = _truename;
@synthesize unit1 = _unit1;
@synthesize pic = _pic;
@synthesize addtime = _addtime;
@synthesize catid = _catid;
@synthesize mobile = _mobile;
@synthesize adddate = _adddate;
@synthesize unit = _unit;
@synthesize avatar = _avatar;
@synthesize star2 = _star2;
@synthesize typeid = _typeid;
@synthesize comment = _comment;
@synthesize price = _price;
@synthesize star1 = _star1;
@synthesize edittime = _edittime;


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
            self.catname = [self objectOrNilForKey:kYHBProductDetailCatname fromDictionary:dict];
            self.userid = [[self objectOrNilForKey:kYHBProductDetailUserid fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kYHBProductDetailContent fromDictionary:dict];
    NSObject *receivedYHBSku = [dict objectForKey:kYHBProductDetailSku];
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
            self.title = [self objectOrNilForKey:kYHBProductDetailTitle fromDictionary:dict];
    NSObject *receivedYHBExpress = [dict objectForKey:kYHBProductDetailExpress];
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
            self.company = [self objectOrNilForKey:kYHBProductDetailCompany fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBProductDetailItemid fromDictionary:dict] doubleValue];
            self.favorite = [[self objectOrNilForKey:kYHBProductDetailFavorite fromDictionary:dict] doubleValue];
            self.typename = [self objectOrNilForKey:kYHBProductDetailTypename fromDictionary:dict];
            self.hits = [[self objectOrNilForKey:kYHBProductDetailHits fromDictionary:dict] doubleValue];
            self.editdate = [self objectOrNilForKey:kYHBProductDetailEditdate fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kYHBProductDetailTruename fromDictionary:dict];
            self.unit1 = [self objectOrNilForKey:kYHBProductDetailUnit1 fromDictionary:dict];
    NSObject *receivedYHBPic = [dict objectForKey:kYHBProductDetailPic];
    NSMutableArray *parsedYHBPic = [NSMutableArray array];
    if ([receivedYHBPic isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedYHBPic) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedYHBPic addObject:[YHBPic modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedYHBPic isKindOfClass:[NSDictionary class]]) {
       [parsedYHBPic addObject:[YHBPic modelObjectWithDictionary:(NSDictionary *)receivedYHBPic]];
    }

    self.pic = [NSArray arrayWithArray:parsedYHBPic];
            self.addtime = [self objectOrNilForKey:kYHBProductDetailAddtime fromDictionary:dict];
            self.catid = [self objectOrNilForKey:kYHBProductDetailCatid fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kYHBProductDetailMobile fromDictionary:dict];
            self.adddate = [self objectOrNilForKey:kYHBProductDetailAdddate fromDictionary:dict];
            self.unit = [self objectOrNilForKey:kYHBProductDetailUnit fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:kYHBProductDetailAvatar fromDictionary:dict];
            self.star2 = [self objectOrNilForKey:kYHBProductDetailStar2 fromDictionary:dict];
            self.typeid = [self objectOrNilForKey:kYHBProductDetailTypeid fromDictionary:dict];
    NSObject *receivedYHBComment = [dict objectForKey:kYHBProductDetailComment];
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
            self.price = [self objectOrNilForKey:kYHBProductDetailPrice fromDictionary:dict];
            self.star1 = [self objectOrNilForKey:kYHBProductDetailStar1 fromDictionary:dict];
            self.edittime = [self objectOrNilForKey:kYHBProductDetailEdittime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.catname forKey:kYHBProductDetailCatname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userid] forKey:kYHBProductDetailUserid];
    [mutableDict setValue:self.content forKey:kYHBProductDetailContent];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSku] forKey:kYHBProductDetailSku];
    [mutableDict setValue:self.title forKey:kYHBProductDetailTitle];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForExpress] forKey:kYHBProductDetailExpress];
    [mutableDict setValue:self.company forKey:kYHBProductDetailCompany];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBProductDetailItemid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.favorite] forKey:kYHBProductDetailFavorite];
    [mutableDict setValue:self.typename forKey:kYHBProductDetailTypename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hits] forKey:kYHBProductDetailHits];
    [mutableDict setValue:self.editdate forKey:kYHBProductDetailEditdate];
    [mutableDict setValue:self.truename forKey:kYHBProductDetailTruename];
    [mutableDict setValue:self.unit1 forKey:kYHBProductDetailUnit1];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPic] forKey:kYHBProductDetailPic];
    [mutableDict setValue:self.addtime forKey:kYHBProductDetailAddtime];
    [mutableDict setValue:self.catid forKey:kYHBProductDetailCatid];
    [mutableDict setValue:self.mobile forKey:kYHBProductDetailMobile];
    [mutableDict setValue:self.adddate forKey:kYHBProductDetailAdddate];
    [mutableDict setValue:self.unit forKey:kYHBProductDetailUnit];
    [mutableDict setValue:self.avatar forKey:kYHBProductDetailAvatar];
    [mutableDict setValue:self.star2 forKey:kYHBProductDetailStar2];
    [mutableDict setValue:self.typeid forKey:kYHBProductDetailTypeid];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComment] forKey:kYHBProductDetailComment];
    [mutableDict setValue:self.price forKey:kYHBProductDetailPrice];
    [mutableDict setValue:self.star1 forKey:kYHBProductDetailStar1];
    [mutableDict setValue:self.edittime forKey:kYHBProductDetailEdittime];

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

    self.catname = [aDecoder decodeObjectForKey:kYHBProductDetailCatname];
    self.userid = [aDecoder decodeDoubleForKey:kYHBProductDetailUserid];
    self.content = [aDecoder decodeObjectForKey:kYHBProductDetailContent];
    self.sku = [aDecoder decodeObjectForKey:kYHBProductDetailSku];
    self.title = [aDecoder decodeObjectForKey:kYHBProductDetailTitle];
    self.express = [aDecoder decodeObjectForKey:kYHBProductDetailExpress];
    self.company = [aDecoder decodeObjectForKey:kYHBProductDetailCompany];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBProductDetailItemid];
    self.favorite = [aDecoder decodeDoubleForKey:kYHBProductDetailFavorite];
    self.typename = [aDecoder decodeObjectForKey:kYHBProductDetailTypename];
    self.hits = [aDecoder decodeDoubleForKey:kYHBProductDetailHits];
    self.editdate = [aDecoder decodeObjectForKey:kYHBProductDetailEditdate];
    self.truename = [aDecoder decodeObjectForKey:kYHBProductDetailTruename];
    self.unit1 = [aDecoder decodeObjectForKey:kYHBProductDetailUnit1];
    self.pic = [aDecoder decodeObjectForKey:kYHBProductDetailPic];
    self.addtime = [aDecoder decodeObjectForKey:kYHBProductDetailAddtime];
    self.catid = [aDecoder decodeObjectForKey:kYHBProductDetailCatid];
    self.mobile = [aDecoder decodeObjectForKey:kYHBProductDetailMobile];
    self.adddate = [aDecoder decodeObjectForKey:kYHBProductDetailAdddate];
    self.unit = [aDecoder decodeObjectForKey:kYHBProductDetailUnit];
    self.avatar = [aDecoder decodeObjectForKey:kYHBProductDetailAvatar];
    self.star2 = [aDecoder decodeObjectForKey:kYHBProductDetailStar2];
    self.typeid = [aDecoder decodeObjectForKey:kYHBProductDetailTypeid];
    self.comment = [aDecoder decodeObjectForKey:kYHBProductDetailComment];
    self.price = [aDecoder decodeObjectForKey:kYHBProductDetailPrice];
    self.star1 = [aDecoder decodeObjectForKey:kYHBProductDetailStar1];
    self.edittime = [aDecoder decodeObjectForKey:kYHBProductDetailEdittime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_catname forKey:kYHBProductDetailCatname];
    [aCoder encodeDouble:_userid forKey:kYHBProductDetailUserid];
    [aCoder encodeObject:_content forKey:kYHBProductDetailContent];
    [aCoder encodeObject:_sku forKey:kYHBProductDetailSku];
    [aCoder encodeObject:_title forKey:kYHBProductDetailTitle];
    [aCoder encodeObject:_express forKey:kYHBProductDetailExpress];
    [aCoder encodeObject:_company forKey:kYHBProductDetailCompany];
    [aCoder encodeDouble:_itemid forKey:kYHBProductDetailItemid];
    [aCoder encodeDouble:_favorite forKey:kYHBProductDetailFavorite];
    [aCoder encodeObject:_typename forKey:kYHBProductDetailTypename];
    [aCoder encodeDouble:_hits forKey:kYHBProductDetailHits];
    [aCoder encodeObject:_editdate forKey:kYHBProductDetailEditdate];
    [aCoder encodeObject:_truename forKey:kYHBProductDetailTruename];
    [aCoder encodeObject:_unit1 forKey:kYHBProductDetailUnit1];
    [aCoder encodeObject:_pic forKey:kYHBProductDetailPic];
    [aCoder encodeObject:_addtime forKey:kYHBProductDetailAddtime];
    [aCoder encodeObject:_catid forKey:kYHBProductDetailCatid];
    [aCoder encodeObject:_mobile forKey:kYHBProductDetailMobile];
    [aCoder encodeObject:_adddate forKey:kYHBProductDetailAdddate];
    [aCoder encodeObject:_unit forKey:kYHBProductDetailUnit];
    [aCoder encodeObject:_avatar forKey:kYHBProductDetailAvatar];
    [aCoder encodeObject:_star2 forKey:kYHBProductDetailStar2];
    [aCoder encodeObject:_typeid forKey:kYHBProductDetailTypeid];
    [aCoder encodeObject:_comment forKey:kYHBProductDetailComment];
    [aCoder encodeObject:_price forKey:kYHBProductDetailPrice];
    [aCoder encodeObject:_star1 forKey:kYHBProductDetailStar1];
    [aCoder encodeObject:_edittime forKey:kYHBProductDetailEdittime];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBProductDetail *copy = [[YHBProductDetail alloc] init];
    
    if (copy) {

        copy.catname = [self.catname copyWithZone:zone];
        copy.userid = self.userid;
        copy.content = [self.content copyWithZone:zone];
        copy.sku = [self.sku copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.express = [self.express copyWithZone:zone];
        copy.company = [self.company copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.favorite = self.favorite;
        copy.typename = [self.typename copyWithZone:zone];
        copy.hits = self.hits;
        copy.editdate = [self.editdate copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.unit1 = [self.unit1 copyWithZone:zone];
        copy.pic = [self.pic copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.catid = [self.catid copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.unit = [self.unit copyWithZone:zone];
        copy.avatar = [self.avatar copyWithZone:zone];
        copy.star2 = [self.star2 copyWithZone:zone];
        copy.typeid = [self.typeid copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.star1 = [self.star1 copyWithZone:zone];
        copy.edittime = [self.edittime copyWithZone:zone];
    }
    
    return copy;
}


@end
