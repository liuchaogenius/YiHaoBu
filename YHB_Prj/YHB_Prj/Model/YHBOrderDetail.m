//
//  YHBOrderDetail.m
//
//  Created by   on 15/1/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOrderDetail.h"


NSString *const kYHBOrderDetailNaction = @"naction";
NSString *const kYHBOrderDetailSeller = @"seller";
NSString *const kYHBOrderDetailMoney = @"money";
NSString *const kYHBOrderDetailAmount = @"amount";
NSString *const kYHBOrderDetailTitle = @"title";
NSString *const kYHBOrderDetailSendDays = @"send_days";
NSString *const kYHBOrderDetailItemid = @"itemid";
NSString *const kYHBOrderDetailUpdatetime = @"updatetime";
NSString *const kYHBOrderDetailBuyerReason = @"buyer_reason";
NSString *const kYHBOrderDetailStatus = @"status";
NSString *const kYHBOrderDetailBuyerName = @"buyer_name";
NSString *const kYHBOrderDetailSendNo = @"send_no";
NSString *const kYHBOrderDetailSendUrl = @"send_url";
NSString *const kYHBOrderDetailSendType = @"send_type";
NSString *const kYHBOrderDetailBuyerAddress = @"buyer_address";
NSString *const kYHBOrderDetailOrderid = @"orderid";
NSString *const kYHBOrderDetailNumber = @"number";
NSString *const kYHBOrderDetailSellcom = @"sellcom";
NSString *const kYHBOrderDetailSellid = @"sellid";
NSString *const kYHBOrderDetailThumb = @"thumb";
NSString *const kYHBOrderDetailFeeName = @"fee_name";
NSString *const kYHBOrderDetailBuyerMobile = @"buyer_mobile";
NSString *const kYHBOrderDetailAddtime = @"addtime";
NSString *const kYHBOrderDetailNote = @"note";
NSString *const kYHBOrderDetailFee = @"fee";
NSString *const kYHBOrderDetailTradeNo = @"trade_no";
NSString *const kYHBOrderDetailPrice = @"price";
NSString *const kYHBOrderDetailSendTime = @"send_time";
NSString *const kYHBOrderDetailRefundReason = @"refund_reason";
NSString *const kYHBOrderDetailDstatus = @"dstatus";


@interface YHBOrderDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOrderDetail

@synthesize naction = _naction;
@synthesize seller = _seller;
@synthesize money = _money;
@synthesize amount = _amount;
@synthesize title = _title;
@synthesize sendDays = _sendDays;
@synthesize itemid = _itemid;
@synthesize updatetime = _updatetime;
@synthesize buyerReason = _buyerReason;
@synthesize status = _status;
@synthesize buyerName = _buyerName;
@synthesize sendNo = _sendNo;
@synthesize sendUrl = _sendUrl;
@synthesize sendType = _sendType;
@synthesize buyerAddress = _buyerAddress;
@synthesize orderid = _orderid;
@synthesize number = _number;
@synthesize sellcom = _sellcom;
@synthesize sellid = _sellid;
@synthesize thumb = _thumb;
@synthesize feeName = _feeName;
@synthesize buyerMobile = _buyerMobile;
@synthesize addtime = _addtime;
@synthesize note = _note;
@synthesize fee = _fee;
@synthesize tradeNo = _tradeNo;
@synthesize price = _price;
@synthesize sendTime = _sendTime;
@synthesize refundReason = _refundReason;
@synthesize dstatus = _dstatus;


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
        self.naction = [self objectOrNilForKey:kYHBOrderDetailNaction fromDictionary:dict];
        self.seller = [self objectOrNilForKey:kYHBOrderDetailSeller fromDictionary:dict];
        self.money = [self objectOrNilForKey:kYHBOrderDetailMoney fromDictionary:dict];
        self.amount = [self objectOrNilForKey:kYHBOrderDetailAmount fromDictionary:dict];
        self.title = [self objectOrNilForKey:kYHBOrderDetailTitle fromDictionary:dict];
        self.sendDays = [self objectOrNilForKey:kYHBOrderDetailSendDays fromDictionary:dict];
        self.itemid = [[self objectOrNilForKey:kYHBOrderDetailItemid fromDictionary:dict] doubleValue];
        self.updatetime = [self objectOrNilForKey:kYHBOrderDetailUpdatetime fromDictionary:dict];
        self.buyerReason = [self objectOrNilForKey:kYHBOrderDetailBuyerReason fromDictionary:dict];
        self.status = [[self objectOrNilForKey:kYHBOrderDetailStatus fromDictionary:dict] doubleValue];
        self.buyerName = [self objectOrNilForKey:kYHBOrderDetailBuyerName fromDictionary:dict];
        self.sendNo = [self objectOrNilForKey:kYHBOrderDetailSendNo fromDictionary:dict];
        self.sendUrl = [self objectOrNilForKey:kYHBOrderDetailSendUrl fromDictionary:dict];
        self.sendType = [self objectOrNilForKey:kYHBOrderDetailSendType fromDictionary:dict];
        self.buyerAddress = [self objectOrNilForKey:kYHBOrderDetailBuyerAddress fromDictionary:dict];
        self.orderid = [self objectOrNilForKey:kYHBOrderDetailOrderid fromDictionary:dict];
        self.number = [self objectOrNilForKey:kYHBOrderDetailNumber fromDictionary:dict];
        self.sellcom = [self objectOrNilForKey:kYHBOrderDetailSellcom fromDictionary:dict];
        self.sellid = [[self objectOrNilForKey:kYHBOrderDetailSellid fromDictionary:dict] doubleValue];
        self.thumb = [self objectOrNilForKey:kYHBOrderDetailThumb fromDictionary:dict];
        self.feeName = [self objectOrNilForKey:kYHBOrderDetailFeeName fromDictionary:dict];
        self.buyerMobile = [self objectOrNilForKey:kYHBOrderDetailBuyerMobile fromDictionary:dict];
        self.addtime = [self objectOrNilForKey:kYHBOrderDetailAddtime fromDictionary:dict];
        self.note = [self objectOrNilForKey:kYHBOrderDetailNote fromDictionary:dict];
        self.fee = [self objectOrNilForKey:kYHBOrderDetailFee fromDictionary:dict];
        self.tradeNo = [self objectOrNilForKey:kYHBOrderDetailTradeNo fromDictionary:dict];
        self.price = [self objectOrNilForKey:kYHBOrderDetailPrice fromDictionary:dict];
        self.sendTime = [self objectOrNilForKey:kYHBOrderDetailSendTime fromDictionary:dict];
        self.refundReason = [self objectOrNilForKey:kYHBOrderDetailRefundReason fromDictionary:dict];
        self.dstatus = [self objectOrNilForKey:kYHBOrderDetailDstatus fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNaction] forKey:kYHBOrderDetailNaction];
    [mutableDict setValue:self.seller forKey:kYHBOrderDetailSeller];
    [mutableDict setValue:self.money forKey:kYHBOrderDetailMoney];
    [mutableDict setValue:self.amount forKey:kYHBOrderDetailAmount];
    [mutableDict setValue:self.title forKey:kYHBOrderDetailTitle];
    [mutableDict setValue:self.sendDays forKey:kYHBOrderDetailSendDays];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBOrderDetailItemid];
    [mutableDict setValue:self.updatetime forKey:kYHBOrderDetailUpdatetime];
    [mutableDict setValue:self.buyerReason forKey:kYHBOrderDetailBuyerReason];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kYHBOrderDetailStatus];
    [mutableDict setValue:self.buyerName forKey:kYHBOrderDetailBuyerName];
    [mutableDict setValue:self.sendNo forKey:kYHBOrderDetailSendNo];
    [mutableDict setValue:self.sendUrl forKey:kYHBOrderDetailSendUrl];
    [mutableDict setValue:self.sendType forKey:kYHBOrderDetailSendType];
    [mutableDict setValue:self.buyerAddress forKey:kYHBOrderDetailBuyerAddress];
    [mutableDict setValue:self.orderid forKey:kYHBOrderDetailOrderid];
    [mutableDict setValue:self.number forKey:kYHBOrderDetailNumber];
    [mutableDict setValue:self.sellcom forKey:kYHBOrderDetailSellcom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sellid] forKey:kYHBOrderDetailSellid];
    [mutableDict setValue:self.thumb forKey:kYHBOrderDetailThumb];
    [mutableDict setValue:self.feeName forKey:kYHBOrderDetailFeeName];
    [mutableDict setValue:self.buyerMobile forKey:kYHBOrderDetailBuyerMobile];
    [mutableDict setValue:self.addtime forKey:kYHBOrderDetailAddtime];
    [mutableDict setValue:self.note forKey:kYHBOrderDetailNote];
    [mutableDict setValue:self.fee forKey:kYHBOrderDetailFee];
    [mutableDict setValue:self.tradeNo forKey:kYHBOrderDetailTradeNo];
    [mutableDict setValue:self.price forKey:kYHBOrderDetailPrice];
    [mutableDict setValue:self.sendTime forKey:kYHBOrderDetailSendTime];
    [mutableDict setValue:self.refundReason forKey:kYHBOrderDetailRefundReason];
    [mutableDict setValue:self.dstatus forKey:kYHBOrderDetailDstatus];
    
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
    
    self.naction = [aDecoder decodeObjectForKey:kYHBOrderDetailNaction];
    self.seller = [aDecoder decodeObjectForKey:kYHBOrderDetailSeller];
    self.money = [aDecoder decodeObjectForKey:kYHBOrderDetailMoney];
    self.amount = [aDecoder decodeObjectForKey:kYHBOrderDetailAmount];
    self.title = [aDecoder decodeObjectForKey:kYHBOrderDetailTitle];
    self.sendDays = [aDecoder decodeObjectForKey:kYHBOrderDetailSendDays];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBOrderDetailItemid];
    self.updatetime = [aDecoder decodeObjectForKey:kYHBOrderDetailUpdatetime];
    self.buyerReason = [aDecoder decodeObjectForKey:kYHBOrderDetailBuyerReason];
    self.status = [aDecoder decodeDoubleForKey:kYHBOrderDetailStatus];
    self.buyerName = [aDecoder decodeObjectForKey:kYHBOrderDetailBuyerName];
    self.sendNo = [aDecoder decodeObjectForKey:kYHBOrderDetailSendNo];
    self.sendUrl = [aDecoder decodeObjectForKey:kYHBOrderDetailSendUrl];
    self.sendType = [aDecoder decodeObjectForKey:kYHBOrderDetailSendType];
    self.buyerAddress = [aDecoder decodeObjectForKey:kYHBOrderDetailBuyerAddress];
    self.orderid = [aDecoder decodeObjectForKey:kYHBOrderDetailOrderid];
    self.number = [aDecoder decodeObjectForKey:kYHBOrderDetailNumber];
    self.sellcom = [aDecoder decodeObjectForKey:kYHBOrderDetailSellcom];
    self.sellid = [aDecoder decodeDoubleForKey:kYHBOrderDetailSellid];
    self.thumb = [aDecoder decodeObjectForKey:kYHBOrderDetailThumb];
    self.feeName = [aDecoder decodeObjectForKey:kYHBOrderDetailFeeName];
    self.buyerMobile = [aDecoder decodeObjectForKey:kYHBOrderDetailBuyerMobile];
    self.addtime = [aDecoder decodeObjectForKey:kYHBOrderDetailAddtime];
    self.note = [aDecoder decodeObjectForKey:kYHBOrderDetailNote];
    self.fee = [aDecoder decodeObjectForKey:kYHBOrderDetailFee];
    self.tradeNo = [aDecoder decodeObjectForKey:kYHBOrderDetailTradeNo];
    self.price = [aDecoder decodeObjectForKey:kYHBOrderDetailPrice];
    self.sendTime = [aDecoder decodeObjectForKey:kYHBOrderDetailSendTime];
    self.refundReason = [aDecoder decodeObjectForKey:kYHBOrderDetailRefundReason];
    self.dstatus = [aDecoder decodeObjectForKey:kYHBOrderDetailDstatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_naction forKey:kYHBOrderDetailNaction];
    [aCoder encodeObject:_seller forKey:kYHBOrderDetailSeller];
    [aCoder encodeObject:_money forKey:kYHBOrderDetailMoney];
    [aCoder encodeObject:_amount forKey:kYHBOrderDetailAmount];
    [aCoder encodeObject:_title forKey:kYHBOrderDetailTitle];
    [aCoder encodeObject:_sendDays forKey:kYHBOrderDetailSendDays];
    [aCoder encodeDouble:_itemid forKey:kYHBOrderDetailItemid];
    [aCoder encodeObject:_updatetime forKey:kYHBOrderDetailUpdatetime];
    [aCoder encodeObject:_buyerReason forKey:kYHBOrderDetailBuyerReason];
    [aCoder encodeDouble:_status forKey:kYHBOrderDetailStatus];
    [aCoder encodeObject:_buyerName forKey:kYHBOrderDetailBuyerName];
    [aCoder encodeObject:_sendNo forKey:kYHBOrderDetailSendNo];
    [aCoder encodeObject:_sendUrl forKey:kYHBOrderDetailSendUrl];
    [aCoder encodeObject:_sendType forKey:kYHBOrderDetailSendType];
    [aCoder encodeObject:_buyerAddress forKey:kYHBOrderDetailBuyerAddress];
    [aCoder encodeObject:_orderid forKey:kYHBOrderDetailOrderid];
    [aCoder encodeObject:_number forKey:kYHBOrderDetailNumber];
    [aCoder encodeObject:_sellcom forKey:kYHBOrderDetailSellcom];
    [aCoder encodeDouble:_sellid forKey:kYHBOrderDetailSellid];
    [aCoder encodeObject:_thumb forKey:kYHBOrderDetailThumb];
    [aCoder encodeObject:_feeName forKey:kYHBOrderDetailFeeName];
    [aCoder encodeObject:_buyerMobile forKey:kYHBOrderDetailBuyerMobile];
    [aCoder encodeObject:_addtime forKey:kYHBOrderDetailAddtime];
    [aCoder encodeObject:_note forKey:kYHBOrderDetailNote];
    [aCoder encodeObject:_fee forKey:kYHBOrderDetailFee];
    [aCoder encodeObject:_tradeNo forKey:kYHBOrderDetailTradeNo];
    [aCoder encodeObject:_price forKey:kYHBOrderDetailPrice];
    [aCoder encodeObject:_sendTime forKey:kYHBOrderDetailSendTime];
    [aCoder encodeObject:_refundReason forKey:kYHBOrderDetailRefundReason];
    [aCoder encodeObject:_dstatus forKey:kYHBOrderDetailDstatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOrderDetail *copy = [[YHBOrderDetail alloc] init];
    
    if (copy) {
        
        copy.naction = [self.naction copyWithZone:zone];
        copy.seller = [self.seller copyWithZone:zone];
        copy.money = [self.money copyWithZone:zone];
        copy.amount = [self.amount copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.sendDays = [self.sendDays copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.updatetime = [self.updatetime copyWithZone:zone];
        copy.buyerReason = [self.buyerReason copyWithZone:zone];
        copy.status = self.status;
        copy.buyerName = [self.buyerName copyWithZone:zone];
        copy.sendNo = [self.sendNo copyWithZone:zone];
        copy.sendUrl = [self.sendUrl copyWithZone:zone];
        copy.sendType = [self.sendType copyWithZone:zone];
        copy.buyerAddress = [self.buyerAddress copyWithZone:zone];
        copy.orderid = [self.orderid copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.sellcom = [self.sellcom copyWithZone:zone];
        copy.sellid = self.sellid;
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.feeName = [self.feeName copyWithZone:zone];
        copy.buyerMobile = [self.buyerMobile copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.note = [self.note copyWithZone:zone];
        copy.fee = [self.fee copyWithZone:zone];
        copy.tradeNo = [self.tradeNo copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.sendTime = [self.sendTime copyWithZone:zone];
        copy.refundReason = [self.refundReason copyWithZone:zone];
        copy.dstatus = [self.dstatus copyWithZone:zone];
    }
    
    return copy;
}


@end
