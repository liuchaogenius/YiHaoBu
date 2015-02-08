//
//  YHBOrderDetail.m
//
//  Created by   on 15/2/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "YHBOrderDetail.h"


NSString *const kYHBOrderDetailSendNo = @"send_no";
NSString *const kYHBOrderDetailNaction = @"naction";
NSString *const kYHBOrderDetailSellcom = @"sellcom";
NSString *const kYHBOrderDetailReceivedate = @"receivedate";
NSString *const kYHBOrderDetailAddtime = @"addtime";
NSString *const kYHBOrderDetailReceivetime = @"receivetime";
NSString *const kYHBOrderDetailSendDays = @"send_days";
NSString *const kYHBOrderDetailSendtime = @"sendtime";
NSString *const kYHBOrderDetailSellname = @"sellname";
NSString *const kYHBOrderDetailItemid = @"itemid";
NSString *const kYHBOrderDetailOrderid = @"orderid";
NSString *const kYHBOrderDetailFeeName = @"fee_name";
NSString *const kYHBOrderDetailThumb = @"thumb";
NSString *const kYHBOrderDetailRefundReason = @"refund_reason";
NSString *const kYHBOrderDetailSendUrl = @"send_url";
NSString *const kYHBOrderDetailNumber = @"number";
NSString *const kYHBOrderDetailPaydate = @"paydate";
NSString *const kYHBOrderDetailSenddate = @"senddate";
NSString *const kYHBOrderDetailSendTime = @"send_time";
NSString *const kYHBOrderDetailBuyerName = @"buyer_name";
NSString *const kYHBOrderDetailTradeNo = @"trade_no";
NSString *const kYHBOrderDetailStatus = @"status";
NSString *const kYHBOrderDetailAdddate = @"adddate";
NSString *const kYHBOrderDetailPrice = @"price";
NSString *const kYHBOrderDetailBuyerReason = @"buyer_reason";
NSString *const kYHBOrderDetailFee = @"fee";
NSString *const kYHBOrderDetailSendType = @"send_type";
NSString *const kYHBOrderDetailUpdatedate = @"updatedate";
NSString *const kYHBOrderDetailSellid = @"sellid";
NSString *const kYHBOrderDetailDstatus = @"dstatus";
NSString *const kYHBOrderDetailPaytime = @"paytime";
NSString *const kYHBOrderDetailBuyerAddress = @"buyer_address";
NSString *const kYHBOrderDetailTitle = @"title";
NSString *const kYHBOrderDetailMoney = @"money";
NSString *const kYHBOrderDetailUpdatetime = @"updatetime";
NSString *const kYHBOrderDetailBuyerMobile = @"buyer_mobile";
NSString *const kYHBOrderDetailNote = @"note";
NSString *const kYHBOrderDetailAmount = @"amount";


@interface YHBOrderDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation YHBOrderDetail

@synthesize sendNo = _sendNo;
@synthesize naction = _naction;
@synthesize sellcom = _sellcom;
@synthesize receivedate = _receivedate;
@synthesize addtime = _addtime;
@synthesize receivetime = _receivetime;
@synthesize sendDays = _sendDays;
@synthesize sendtime = _sendtime;
@synthesize sellname = _sellname;
@synthesize itemid = _itemid;
@synthesize orderid = _orderid;
@synthesize feeName = _feeName;
@synthesize thumb = _thumb;
@synthesize refundReason = _refundReason;
@synthesize sendUrl = _sendUrl;
@synthesize number = _number;
@synthesize paydate = _paydate;
@synthesize senddate = _senddate;
@synthesize sendTime = _sendTime;
@synthesize buyerName = _buyerName;
@synthesize tradeNo = _tradeNo;
@synthesize status = _status;
@synthesize adddate = _adddate;
@synthesize price = _price;
@synthesize buyerReason = _buyerReason;
@synthesize fee = _fee;
@synthesize sendType = _sendType;
@synthesize updatedate = _updatedate;
@synthesize sellid = _sellid;
@synthesize dstatus = _dstatus;
@synthesize paytime = _paytime;
@synthesize buyerAddress = _buyerAddress;
@synthesize title = _title;
@synthesize money = _money;
@synthesize updatetime = _updatetime;
@synthesize buyerMobile = _buyerMobile;
@synthesize note = _note;
@synthesize amount = _amount;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (NSMutableArray *)getDetailTextArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:8];
    if (self.orderid.length) {
        [array addObject:[@"订单编号：" stringByAppendingString:self.orderid]];
    }
    if (self.tradeNo.length) {
        [array addObject:[@"支付宝订单号：" stringByAppendingString:self.tradeNo]];
    }
    if (self.adddate.length) {
        [array addObject:[@"下单时间：" stringByAppendingString:self.adddate]];
    }
    if (self.updatedate.length) {
        [array addObject:[@"更新时间：" stringByAppendingString:self.updatedate]];
    }
    if (self.paydate.length) {
        [array addObject:[@"支付时间：" stringByAppendingString:self.paydate]];
    }
    if (self.senddate.length) {
        [array addObject:[@"发货时间：" stringByAppendingString:self.senddate]];
    }
    if (self.receivedate.length) {
        [array addObject:[@"收货时间：" stringByAppendingString:self.orderid]];
    }
    if (self.sendNo.length) {
        [array addObject:[@"物流编号：" stringByAppendingString:self.orderid]];
    }
    return array;
}

- (NSString *)getTitleOfNextStepForIndex:(int)index
{
    if (self.naction.count > index) {
        NSString *str = self.naction[index];
        if ([str isEqualToString:@"close"]) {
            return @"取消订单";
        }else if([str isEqualToString:@"pay"]) {
            return @"付款";
        }else if ([str isEqualToString:@"receive"]) {
            return @"立即收货";
        }else if ([str isEqualToString:@"comment"]) {
            return @"评价";
        }
    }
    return nil;
}


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.sendNo = [self objectOrNilForKey:kYHBOrderDetailSendNo fromDictionary:dict];
            self.naction = [self objectOrNilForKey:kYHBOrderDetailNaction fromDictionary:dict];
            self.sellcom = [self objectOrNilForKey:kYHBOrderDetailSellcom fromDictionary:dict];
            self.receivedate = [self objectOrNilForKey:kYHBOrderDetailReceivedate fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kYHBOrderDetailAddtime fromDictionary:dict];
            self.receivetime = [self objectOrNilForKey:kYHBOrderDetailReceivetime fromDictionary:dict];
            self.sendDays = [self objectOrNilForKey:kYHBOrderDetailSendDays fromDictionary:dict];
            self.sendtime = [self objectOrNilForKey:kYHBOrderDetailSendtime fromDictionary:dict];
            self.sellname = [self objectOrNilForKey:kYHBOrderDetailSellname fromDictionary:dict];
            self.itemid = [[self objectOrNilForKey:kYHBOrderDetailItemid fromDictionary:dict] doubleValue];
            self.orderid = [self objectOrNilForKey:kYHBOrderDetailOrderid fromDictionary:dict];
            self.feeName = [self objectOrNilForKey:kYHBOrderDetailFeeName fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kYHBOrderDetailThumb fromDictionary:dict];
            self.refundReason = [self objectOrNilForKey:kYHBOrderDetailRefundReason fromDictionary:dict];
            self.sendUrl = [self objectOrNilForKey:kYHBOrderDetailSendUrl fromDictionary:dict];
            self.number = [self objectOrNilForKey:kYHBOrderDetailNumber fromDictionary:dict];
            self.paydate = [self objectOrNilForKey:kYHBOrderDetailPaydate fromDictionary:dict];
            self.senddate = [self objectOrNilForKey:kYHBOrderDetailSenddate fromDictionary:dict];
            self.sendTime = [self objectOrNilForKey:kYHBOrderDetailSendTime fromDictionary:dict];
            self.buyerName = [self objectOrNilForKey:kYHBOrderDetailBuyerName fromDictionary:dict];
            self.tradeNo = [self objectOrNilForKey:kYHBOrderDetailTradeNo fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kYHBOrderDetailStatus fromDictionary:dict] doubleValue];
            self.adddate = [self objectOrNilForKey:kYHBOrderDetailAdddate fromDictionary:dict];
            self.price = [self objectOrNilForKey:kYHBOrderDetailPrice fromDictionary:dict];
            self.buyerReason = [self objectOrNilForKey:kYHBOrderDetailBuyerReason fromDictionary:dict];
            self.fee = [self objectOrNilForKey:kYHBOrderDetailFee fromDictionary:dict];
            self.sendType = [self objectOrNilForKey:kYHBOrderDetailSendType fromDictionary:dict];
            self.updatedate = [self objectOrNilForKey:kYHBOrderDetailUpdatedate fromDictionary:dict];
            self.sellid = [[self objectOrNilForKey:kYHBOrderDetailSellid fromDictionary:dict] doubleValue];
            self.dstatus = [self objectOrNilForKey:kYHBOrderDetailDstatus fromDictionary:dict];
            self.paytime = [self objectOrNilForKey:kYHBOrderDetailPaytime fromDictionary:dict];
            self.buyerAddress = [self objectOrNilForKey:kYHBOrderDetailBuyerAddress fromDictionary:dict];
            self.title = [self objectOrNilForKey:kYHBOrderDetailTitle fromDictionary:dict];
            self.money = [self objectOrNilForKey:kYHBOrderDetailMoney fromDictionary:dict];
            self.updatetime = [self objectOrNilForKey:kYHBOrderDetailUpdatetime fromDictionary:dict];
            self.buyerMobile = [self objectOrNilForKey:kYHBOrderDetailBuyerMobile fromDictionary:dict];
            self.note = [self objectOrNilForKey:kYHBOrderDetailNote fromDictionary:dict];
            self.amount = [self objectOrNilForKey:kYHBOrderDetailAmount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.sendNo forKey:kYHBOrderDetailSendNo];
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
    [mutableDict setValue:self.sellcom forKey:kYHBOrderDetailSellcom];
    [mutableDict setValue:self.receivedate forKey:kYHBOrderDetailReceivedate];
    [mutableDict setValue:self.addtime forKey:kYHBOrderDetailAddtime];
    [mutableDict setValue:self.receivetime forKey:kYHBOrderDetailReceivetime];
    [mutableDict setValue:self.sendDays forKey:kYHBOrderDetailSendDays];
    [mutableDict setValue:self.sendtime forKey:kYHBOrderDetailSendtime];
    [mutableDict setValue:self.sellname forKey:kYHBOrderDetailSellname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemid] forKey:kYHBOrderDetailItemid];
    [mutableDict setValue:self.orderid forKey:kYHBOrderDetailOrderid];
    [mutableDict setValue:self.feeName forKey:kYHBOrderDetailFeeName];
    [mutableDict setValue:self.thumb forKey:kYHBOrderDetailThumb];
    [mutableDict setValue:self.refundReason forKey:kYHBOrderDetailRefundReason];
    [mutableDict setValue:self.sendUrl forKey:kYHBOrderDetailSendUrl];
    [mutableDict setValue:self.number forKey:kYHBOrderDetailNumber];
    [mutableDict setValue:self.paydate forKey:kYHBOrderDetailPaydate];
    [mutableDict setValue:self.senddate forKey:kYHBOrderDetailSenddate];
    [mutableDict setValue:self.sendTime forKey:kYHBOrderDetailSendTime];
    [mutableDict setValue:self.buyerName forKey:kYHBOrderDetailBuyerName];
    [mutableDict setValue:self.tradeNo forKey:kYHBOrderDetailTradeNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kYHBOrderDetailStatus];
    [mutableDict setValue:self.adddate forKey:kYHBOrderDetailAdddate];
    [mutableDict setValue:self.price forKey:kYHBOrderDetailPrice];
    [mutableDict setValue:self.buyerReason forKey:kYHBOrderDetailBuyerReason];
    [mutableDict setValue:self.fee forKey:kYHBOrderDetailFee];
    [mutableDict setValue:self.sendType forKey:kYHBOrderDetailSendType];
    [mutableDict setValue:self.updatedate forKey:kYHBOrderDetailUpdatedate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sellid] forKey:kYHBOrderDetailSellid];
    [mutableDict setValue:self.dstatus forKey:kYHBOrderDetailDstatus];
    [mutableDict setValue:self.paytime forKey:kYHBOrderDetailPaytime];
    [mutableDict setValue:self.buyerAddress forKey:kYHBOrderDetailBuyerAddress];
    [mutableDict setValue:self.title forKey:kYHBOrderDetailTitle];
    [mutableDict setValue:self.money forKey:kYHBOrderDetailMoney];
    [mutableDict setValue:self.updatetime forKey:kYHBOrderDetailUpdatetime];
    [mutableDict setValue:self.buyerMobile forKey:kYHBOrderDetailBuyerMobile];
    [mutableDict setValue:self.note forKey:kYHBOrderDetailNote];
    [mutableDict setValue:self.amount forKey:kYHBOrderDetailAmount];

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

    self.sendNo = [aDecoder decodeObjectForKey:kYHBOrderDetailSendNo];
    self.naction = [aDecoder decodeObjectForKey:kYHBOrderDetailNaction];
    self.sellcom = [aDecoder decodeObjectForKey:kYHBOrderDetailSellcom];
    self.receivedate = [aDecoder decodeObjectForKey:kYHBOrderDetailReceivedate];
    self.addtime = [aDecoder decodeObjectForKey:kYHBOrderDetailAddtime];
    self.receivetime = [aDecoder decodeObjectForKey:kYHBOrderDetailReceivetime];
    self.sendDays = [aDecoder decodeObjectForKey:kYHBOrderDetailSendDays];
    self.sendtime = [aDecoder decodeObjectForKey:kYHBOrderDetailSendtime];
    self.sellname = [aDecoder decodeObjectForKey:kYHBOrderDetailSellname];
    self.itemid = [aDecoder decodeDoubleForKey:kYHBOrderDetailItemid];
    self.orderid = [aDecoder decodeObjectForKey:kYHBOrderDetailOrderid];
    self.feeName = [aDecoder decodeObjectForKey:kYHBOrderDetailFeeName];
    self.thumb = [aDecoder decodeObjectForKey:kYHBOrderDetailThumb];
    self.refundReason = [aDecoder decodeObjectForKey:kYHBOrderDetailRefundReason];
    self.sendUrl = [aDecoder decodeObjectForKey:kYHBOrderDetailSendUrl];
    self.number = [aDecoder decodeObjectForKey:kYHBOrderDetailNumber];
    self.paydate = [aDecoder decodeObjectForKey:kYHBOrderDetailPaydate];
    self.senddate = [aDecoder decodeObjectForKey:kYHBOrderDetailSenddate];
    self.sendTime = [aDecoder decodeObjectForKey:kYHBOrderDetailSendTime];
    self.buyerName = [aDecoder decodeObjectForKey:kYHBOrderDetailBuyerName];
    self.tradeNo = [aDecoder decodeObjectForKey:kYHBOrderDetailTradeNo];
    self.status = [aDecoder decodeDoubleForKey:kYHBOrderDetailStatus];
    self.adddate = [aDecoder decodeObjectForKey:kYHBOrderDetailAdddate];
    self.price = [aDecoder decodeObjectForKey:kYHBOrderDetailPrice];
    self.buyerReason = [aDecoder decodeObjectForKey:kYHBOrderDetailBuyerReason];
    self.fee = [aDecoder decodeObjectForKey:kYHBOrderDetailFee];
    self.sendType = [aDecoder decodeObjectForKey:kYHBOrderDetailSendType];
    self.updatedate = [aDecoder decodeObjectForKey:kYHBOrderDetailUpdatedate];
    self.sellid = [aDecoder decodeDoubleForKey:kYHBOrderDetailSellid];
    self.dstatus = [aDecoder decodeObjectForKey:kYHBOrderDetailDstatus];
    self.paytime = [aDecoder decodeObjectForKey:kYHBOrderDetailPaytime];
    self.buyerAddress = [aDecoder decodeObjectForKey:kYHBOrderDetailBuyerAddress];
    self.title = [aDecoder decodeObjectForKey:kYHBOrderDetailTitle];
    self.money = [aDecoder decodeObjectForKey:kYHBOrderDetailMoney];
    self.updatetime = [aDecoder decodeObjectForKey:kYHBOrderDetailUpdatetime];
    self.buyerMobile = [aDecoder decodeObjectForKey:kYHBOrderDetailBuyerMobile];
    self.note = [aDecoder decodeObjectForKey:kYHBOrderDetailNote];
    self.amount = [aDecoder decodeObjectForKey:kYHBOrderDetailAmount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sendNo forKey:kYHBOrderDetailSendNo];
    [aCoder encodeObject:_naction forKey:kYHBOrderDetailNaction];
    [aCoder encodeObject:_sellcom forKey:kYHBOrderDetailSellcom];
    [aCoder encodeObject:_receivedate forKey:kYHBOrderDetailReceivedate];
    [aCoder encodeObject:_addtime forKey:kYHBOrderDetailAddtime];
    [aCoder encodeObject:_receivetime forKey:kYHBOrderDetailReceivetime];
    [aCoder encodeObject:_sendDays forKey:kYHBOrderDetailSendDays];
    [aCoder encodeObject:_sendtime forKey:kYHBOrderDetailSendtime];
    [aCoder encodeObject:_sellname forKey:kYHBOrderDetailSellname];
    [aCoder encodeDouble:_itemid forKey:kYHBOrderDetailItemid];
    [aCoder encodeObject:_orderid forKey:kYHBOrderDetailOrderid];
    [aCoder encodeObject:_feeName forKey:kYHBOrderDetailFeeName];
    [aCoder encodeObject:_thumb forKey:kYHBOrderDetailThumb];
    [aCoder encodeObject:_refundReason forKey:kYHBOrderDetailRefundReason];
    [aCoder encodeObject:_sendUrl forKey:kYHBOrderDetailSendUrl];
    [aCoder encodeObject:_number forKey:kYHBOrderDetailNumber];
    [aCoder encodeObject:_paydate forKey:kYHBOrderDetailPaydate];
    [aCoder encodeObject:_senddate forKey:kYHBOrderDetailSenddate];
    [aCoder encodeObject:_sendTime forKey:kYHBOrderDetailSendTime];
    [aCoder encodeObject:_buyerName forKey:kYHBOrderDetailBuyerName];
    [aCoder encodeObject:_tradeNo forKey:kYHBOrderDetailTradeNo];
    [aCoder encodeDouble:_status forKey:kYHBOrderDetailStatus];
    [aCoder encodeObject:_adddate forKey:kYHBOrderDetailAdddate];
    [aCoder encodeObject:_price forKey:kYHBOrderDetailPrice];
    [aCoder encodeObject:_buyerReason forKey:kYHBOrderDetailBuyerReason];
    [aCoder encodeObject:_fee forKey:kYHBOrderDetailFee];
    [aCoder encodeObject:_sendType forKey:kYHBOrderDetailSendType];
    [aCoder encodeObject:_updatedate forKey:kYHBOrderDetailUpdatedate];
    [aCoder encodeDouble:_sellid forKey:kYHBOrderDetailSellid];
    [aCoder encodeObject:_dstatus forKey:kYHBOrderDetailDstatus];
    [aCoder encodeObject:_paytime forKey:kYHBOrderDetailPaytime];
    [aCoder encodeObject:_buyerAddress forKey:kYHBOrderDetailBuyerAddress];
    [aCoder encodeObject:_title forKey:kYHBOrderDetailTitle];
    [aCoder encodeObject:_money forKey:kYHBOrderDetailMoney];
    [aCoder encodeObject:_updatetime forKey:kYHBOrderDetailUpdatetime];
    [aCoder encodeObject:_buyerMobile forKey:kYHBOrderDetailBuyerMobile];
    [aCoder encodeObject:_note forKey:kYHBOrderDetailNote];
    [aCoder encodeObject:_amount forKey:kYHBOrderDetailAmount];
}

- (id)copyWithZone:(NSZone *)zone
{
    YHBOrderDetail *copy = [[YHBOrderDetail alloc] init];
    
    if (copy) {

        copy.sendNo = [self.sendNo copyWithZone:zone];
        copy.naction = [self.naction copyWithZone:zone];
        copy.sellcom = [self.sellcom copyWithZone:zone];
        copy.receivedate = [self.receivedate copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.receivetime = [self.receivetime copyWithZone:zone];
        copy.sendDays = [self.sendDays copyWithZone:zone];
        copy.sendtime = [self.sendtime copyWithZone:zone];
        copy.sellname = [self.sellname copyWithZone:zone];
        copy.itemid = self.itemid;
        copy.orderid = [self.orderid copyWithZone:zone];
        copy.feeName = [self.feeName copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.refundReason = [self.refundReason copyWithZone:zone];
        copy.sendUrl = [self.sendUrl copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.paydate = [self.paydate copyWithZone:zone];
        copy.senddate = [self.senddate copyWithZone:zone];
        copy.sendTime = [self.sendTime copyWithZone:zone];
        copy.buyerName = [self.buyerName copyWithZone:zone];
        copy.tradeNo = [self.tradeNo copyWithZone:zone];
        copy.status = self.status;
        copy.adddate = [self.adddate copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.buyerReason = [self.buyerReason copyWithZone:zone];
        copy.fee = [self.fee copyWithZone:zone];
        copy.sendType = [self.sendType copyWithZone:zone];
        copy.updatedate = [self.updatedate copyWithZone:zone];
        copy.sellid = self.sellid;
        copy.dstatus = [self.dstatus copyWithZone:zone];
        copy.paytime = [self.paytime copyWithZone:zone];
        copy.buyerAddress = [self.buyerAddress copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.money = [self.money copyWithZone:zone];
        copy.updatetime = [self.updatetime copyWithZone:zone];
        copy.buyerMobile = [self.buyerMobile copyWithZone:zone];
        copy.note = [self.note copyWithZone:zone];
        copy.amount = [self.amount copyWithZone:zone];
    }
    
    return copy;
}


@end
