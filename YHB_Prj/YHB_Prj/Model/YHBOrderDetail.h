//
//  YHBOrderDetail.h
//
//  Created by   on 15/1/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBOrderDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *naction;
@property (nonatomic, strong) NSString *seller;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *sendDays;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *updatetime;
@property (nonatomic, strong) NSString *buyerReason;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *buyerName;
@property (nonatomic, strong) NSString *sendNo;
@property (nonatomic, strong) NSString *sendUrl;
@property (nonatomic, strong) NSString *sendType;
@property (nonatomic, strong) NSString *buyerAddress;
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *sellcom;
@property (nonatomic, assign) double sellid;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *feeName;
@property (nonatomic, strong) NSString *buyerMobile;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, strong) NSString *tradeNo;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *sendTime;
@property (nonatomic, strong) NSString *refundReason;
@property (nonatomic, strong) NSString *dstatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
