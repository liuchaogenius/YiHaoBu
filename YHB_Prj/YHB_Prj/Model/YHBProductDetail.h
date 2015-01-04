//
//  YHBProductDetail.h
//
//  Created by   on 15/1/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBProductDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *catname;
@property (nonatomic, assign) double userid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *sku;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *express;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, assign) double itemid;
@property (nonatomic, assign) double favorite;
@property (nonatomic, strong) NSString *typename;
@property (nonatomic, assign) double hits;
@property (nonatomic, strong) NSString *editdate;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, strong) NSString *unit1;
@property (nonatomic, strong) NSArray *pic;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *catid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *adddate;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *star2;
@property (nonatomic, strong) NSString *typeid;
@property (nonatomic, strong) NSArray *comment;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *star1;
@property (nonatomic, strong) NSString *edittime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
