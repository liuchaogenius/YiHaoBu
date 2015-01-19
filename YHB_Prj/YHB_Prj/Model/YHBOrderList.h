//
//  YHBOrderList.h
//
//  Created by   on 15/1/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHBPage;

@interface YHBOrderList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSMutableArray *rslist;
@property (nonatomic, strong) YHBPage *page;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
