//
//  YHBORslist.m
//
//  Created by   on 15/2/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBORslist.h"


NSString *const kYHBORslistThumb = @"thumb";
NSString *const kYHBORslistMoney = @"money";
NSString *const kYHBORslistAmount = @"amount";
NSString *const kYHBORslistAddtime = @"addtime";
NSString *const kYHBORslistFee = @"fee";
NSString *const kYHBORslistTitle = @"title";
NSString *const kYHBORslistSellid = @"sellid";
NSString *const kYHBORslistPrice = @"price";
NSString *const kYHBORslistOrderid = @"orderid";
NSString *const kYHBORslistNumber = @"number";
NSString *const kYHBORslistItemid = @"itemid";
NSString *const kYHBORslistFeeName = @"fee_name";
NSString *const kYHBORslistSellcom = @"sellcom";
NSString *const kYHBORslistDstatus = @"dstatus";
NSString *const kYHBORslistSeller = @"seller";
NSString *const kYHBORslistStatus = @"status";
NSString *const kYHBORslistNaction = @"naction";


@interface YHBORslist ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBORslist

@synthesize thumb = _thumb;
@synthesize money = _money;
@synthesize amount = _amount;
@synthesize addtime = _addtime;
@synthesize fee = _fee;
@synthesize title = _title;
@synthesize sellid = _sellid;
@synthesize price = _price;
@synthesize orderid = _orderid;
@synthesize number = _number;
@synthesize itemid = _itemid;
@synthesize feeName = _feeName;
@synthesize sellcom = _sellcom;
@synthesize dstatus = _dstatus;
@synthesize seller = _seller;
@synthesize status = _status;
@synthesize naction = _naction;


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
            self.thumb = [self objectOrNilForKey:kYHBORslistThumb fromDictionary:dict];
            self.money = [self objectOrNilForKey:kYHBORslistMoney fromDictionary:dict];
            self.amount = [self objectOrNilForKey:kYHBORslistAmount fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kYHBORslistAddtime fromDictionary:dict];
            self.fee = [self objectOrNilForKey:kYHBORslistFee fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBORslistTitle fromDictionary:dict];
            self.sellid = [[self objectOrNilForKey:kYHBORslistSellid fromDictionary:dict] doubleValue];
            self.price = [self objectOrNilForKey:kYHBORslistPrice fromDictionary:dict];
            self.orderid = [self objectOrNilForKey:kYHBORslistOrderid fromDictionary:dict];
            self.number = [self objectOrNilForKey:kYHBORslistNumber fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBORslistItemid fromDictionary:dict] doubleValue];
            self.feeName = [self objectOrNilForKey:kYHBORslistFeeName fromDictionary:dict];
            self.sellcom = [self objectOrNilForKey:kYHBORslistSellcom fromDictionary:dict];
            self.dstatus = [self objectOrNilForKey:kYHBORslistDstatus fromDictionary:dict];
            self.seller = [self objectOrNilForKey:kYHBORslistSeller fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kYHBORslistStatus fromDictionary:dict] doubleValue];
            self.naction = [self objectOrNilForKey:kYHBORslistNaction fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.thumb forKey:kYHBORslistThumb];
    [mutableDict setValue:self.money forKey:kYHBORslistMoney];
    [mutableDict setValue:self.amount forKey:kYHBORslistAmount];
    [mutableDict setValue:self.addtime forKey:kYHBORslistAddtime];
    [mutableDict setValue:self.fee forKey:kYHBORslistFee];
    [mutableDict setValue:self.title forKey:kYHBORslistTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sellid] forKey:kYHBORslistSellid];
    [mutableDict setValue:self.price forKey:kYHBORslistPrice];
    [mutableDict setValue:self.orderid forKey:kYHBORslistOrderid];
    [mutableDict setValue:self.number forKey:kYHBORslistNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBORslistItemid];
    [mutableDict setValue:self.feeName forKey:kYHBORslistFeeName];
    [mutableDict setValue:self.sellcom forKey:kYHBORslistSellcom];
    [mutableDict setValue:self.dstatus forKey:kYHBORslistDstatus];
    [mutableDict setValue:self.seller forKey:kYHBORslistSeller];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kYHBORslistStatus];
    NSMutableArray *tempArrayForNaction = [NSMutableArray array];
    for (NSObject *subArrayObject in self.naction) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNaction addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNaction addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNaction] forKey:kYHBORslistNaction];

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

    self.thumb = [aDecoder decodeObjectForKey:kYHBORslistThumb];
    self.money = [aDecoder decodeObjectForKey:kYHBORslistMoney];
    self.amount = [aDecoder decodeObjectForKey:kYHBORslistAmount];
    self.addtime = [aDecoder decodeObjectForKey:kYHBORslistAddtime];
    self.fee = [aDecoder decodeObjectForKey:kYHBORslistFee];
    self.title = [aDecoder decodeObjectForKey:kYHBORslistTitle];
    self.sellid = [aDecoder decodeDoubleForKey:kYHBORslistSellid];
    self.price = [aDecoder decodeObjectForKey:kYHBORslistPrice];
    self.orderid = [aDecoder decodeObjectForKey:kYHBORslistOrderid];
    self.number = [aDecoder decodeObjectForKey:kYHBORslistNumber];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBORslistItemid];
    self.feeName = [aDecoder decodeObjectForKey:kYHBORslistFeeName];
    self.sellcom = [aDecoder decodeObjectForKey:kYHBORslistSellcom];
    self.dstatus = [aDecoder decodeObjectForKey:kYHBORslistDstatus];
    self.seller = [aDecoder decodeObjectForKey:kYHBORslistSeller];
    self.status = [aDecoder decodeDoubleForKey:kYHBORslistStatus];
    self.naction = [aDecoder decodeObjectForKey:kYHBORslistNaction];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_thumb forKey:kYHBORslistThumb];
    [aCoder encodeObject:_money forKey:kYHBORslistMoney];
    [aCoder encodeObject:_amount forKey:kYHBORslistAmount];
    [aCoder encodeObject:_addtime forKey:kYHBORslistAddtime];
    [aCoder encodeObject:_fee forKey:kYHBORslistFee];
    [aCoder encodeObject:_title forKey:kYHBORslistTitle];
    [aCoder encodeDouble:_sellid forKey:kYHBORslistSellid];
    [aCoder encodeObject:_price forKey:kYHBORslistPrice];
    [aCoder encodeObject:_orderid forKey:kYHBORslistOrderid];
    [aCoder encodeObject:_number forKey:kYHBORslistNumber];
    [aCoder encodeDouble:_itemid forKey:kYHBORslistItemid];
    [aCoder encodeObject:_feeName forKey:kYHBORslistFeeName];
    [aCoder encodeObject:_sellcom forKey:kYHBORslistSellcom];
    [aCoder encodeObject:_dstatus forKey:kYHBORslistDstatus];
    [aCoder encodeObject:_seller forKey:kYHBORslistSeller];
    [aCoder encodeDouble:_status forKey:kYHBORslistStatus];
    [aCoder encodeObject:_naction forKey:kYHBORslistNaction];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBORslist *copy = [[YHBORslist alloc] init];
    
    if (copy) {

        copy.thumb = [self.thumb copyWithZone:zone];
        copy.money = [self.money copyWithZone:zone];
        copy.amount = [self.amount copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.fee = [self.fee copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.sellid = self.sellid;
        copy.price = [self.price copyWithZone:zone];
        copy.orderid = [self.orderid copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.feeName = [self.feeName copyWithZone:zone];
        copy.sellcom = [self.sellcom copyWithZone:zone];
        copy.dstatus = [self.dstatus copyWithZone:zone];
        copy.seller = [self.seller copyWithZone:zone];
        copy.status = self.status;
        copy.naction = [self.naction copyWithZone:zone];
    }
    
    return copy;
}


@end
