//
//  QuoteRslist.h
//
//  Created by  C陈政旭 on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QuoteRslist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *adddate;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, assign) double new;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
