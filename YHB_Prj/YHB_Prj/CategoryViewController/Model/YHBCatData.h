//
//  YHBCatData.h
//
//  Created by  C陈政旭 on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBCatData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *catname;
@property (nonatomic, assign) double catid;
@property (nonatomic, strong) NSArray *subcate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
