//
//  YHBOConfirmRslist.h
//
//  Created by   on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBOConfirmRslist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *seller;
@property (nonatomic, assign) double sellid;
@property (nonatomic, strong) NSArray *malllist;
@property (nonatomic, strong) NSString *sellcom;
@property (nonatomic, assign) double itemid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
