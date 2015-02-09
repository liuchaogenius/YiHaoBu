//
//  YHBBuyDetailData.h
//
//  Created by  C陈政旭 on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBBuyDetailData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *catname;
@property (nonatomic, assign) double userid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, assign) double itemid;
@property (nonatomic, assign) double favorite;
@property (nonatomic, strong) NSString *typename;
@property (nonatomic, assign) double hits;
@property (nonatomic, strong) NSString *editdate;
@property (nonatomic, strong) NSString *today;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *catid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *adddate;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, assign) double vip;
@property (nonatomic, strong) NSString *typeid;
@property (nonatomic, strong) NSString *edittime;
@property (nonatomic, strong) NSArray *album;
@property (nonatomic, strong) NSString *introduce;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
