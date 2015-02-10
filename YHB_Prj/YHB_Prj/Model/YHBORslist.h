//
//  YHBORslist.h
//
//  Created by   on 15/2/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBORslist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double sellid;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *feeName;
@property (nonatomic, strong) NSString *sellcom;
@property (nonatomic, strong) NSString *dstatus;
@property (nonatomic, strong) NSString *seller;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSArray *naction;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
