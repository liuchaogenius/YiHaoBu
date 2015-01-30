//
//  YHBGetPushData.h
//
//  Created by  C陈政旭 on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBGetPushData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *buylist;
@property (nonatomic, assign) double userid;
@property (nonatomic, strong) NSArray *syslist;
@property (nonatomic, strong) NSString *lasttime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
