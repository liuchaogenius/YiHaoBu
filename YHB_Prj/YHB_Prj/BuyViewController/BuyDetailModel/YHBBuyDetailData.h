//
//  YHBBuyDetailData.h
//
//  Created by  C陈政旭 on 14/12/21
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBBuyDetailData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double favorite;
@property (nonatomic, strong) NSString *catid;
@property (nonatomic, strong) NSString *typename;
@property (nonatomic, strong) NSString *adddate;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, assign) double vip;
@property (nonatomic, assign) double userid;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *edittime;
@property (nonatomic, strong) NSString *catname;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *editdate;
@property (nonatomic, strong) NSArray *pic;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double itemid;
@property (nonatomic, assign) double hits;
@property (nonatomic, strong) NSString *typeid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
