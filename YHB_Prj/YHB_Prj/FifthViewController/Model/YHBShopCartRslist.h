//
//  YHBShopCartRslist.h
//
//  Created by  C陈政旭 on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBShopCartRslist : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) int userid;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, strong) NSMutableArray *cartlist;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
