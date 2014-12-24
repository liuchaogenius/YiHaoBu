//
//  YHBShoplist.h
//
//  Created by   on 14/12/23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBShoplist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *company;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *avatar;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
