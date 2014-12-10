//
//  YHBShopCartCartlist.h
//
//  Created by  C陈政旭 on 14/12/10
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBShopCartCartlist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *catname;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) int itemid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
