//
//  YHBPage.h
//
//  Created by   on 14/12/30
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBPage : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double pageid;
@property (nonatomic, assign) double pagetotal;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
