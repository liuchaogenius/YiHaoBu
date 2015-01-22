//
//  PriceDetailRslist.h
//
//  Created by  C陈政旭 on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PriceDetailRslist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *typename;
@property (nonatomic, assign) double userid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *adddate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
