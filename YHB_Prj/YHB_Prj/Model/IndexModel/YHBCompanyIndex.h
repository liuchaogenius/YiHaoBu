//
//  YHBCompanyIndex.h
//
//  Created by   on 14/12/23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBCompanyIndex : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *taglist;
@property (nonatomic, strong) NSArray *malllist;
@property (nonatomic, strong) NSArray *hotlist;
@property (nonatomic, strong) NSArray *slidelist;
@property (nonatomic, strong) NSArray *shoplist;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
