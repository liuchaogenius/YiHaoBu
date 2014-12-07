//
//  YHBSupplyDetailModel.h
//
//  Created by  C陈政旭 on 14/12/7
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBSupplyDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *catname;
@property (nonatomic, assign) int userid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) int itemid;
@property (nonatomic, assign) int favorite;
@property (nonatomic, strong) NSString *typename;
@property (nonatomic, assign) int hits;
@property (nonatomic, strong) NSString *editdate;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, strong) NSArray *pic;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *catid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *adddate;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, assign) int vip;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *edittime;
@property (nonatomic, strong) NSString *typeid;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
