//
//  QuoteMeRslist.h
//
//  Created by  C陈政旭 on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QuoteMeRslist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *adddate;
@property (nonatomic, strong) NSString *typename;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *thumb;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
