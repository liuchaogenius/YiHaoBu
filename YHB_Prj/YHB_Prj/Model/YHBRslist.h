//
//  YHBRslist.h
//
//  Created by   on 14/12/30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBRslist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *typename;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *catname;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *editdate;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, assign) double vip;
@property (nonatomic, strong) NSString *edittime;
@property (nonatomic, assign) int hits;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
