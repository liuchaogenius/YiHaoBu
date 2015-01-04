//
//  YHBSelllist.h
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBSelllist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *edittime;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, assign) double hits;
@property (nonatomic, strong) NSString *editdate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
