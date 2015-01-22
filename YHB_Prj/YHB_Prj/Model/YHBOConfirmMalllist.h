//
//  YHBOConfirmMalllist.h
//
//  Created by   on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBOConfirmMalllist : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double typeid;
@property (nonatomic, strong) NSString *unit1;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *skuname;
@property (nonatomic, strong) NSArray *express;
@property (nonatomic, assign) double skuid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
