//
//  YHBCRslist.h
//
//  Created by   on 15/1/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBCRslist : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double userid;
@property (nonatomic, strong) NSString *star1;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, assign) double groupid;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *star2;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
