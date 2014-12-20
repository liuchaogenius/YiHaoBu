//
//  YHBFirstPageIndex.h
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBFirstPageIndex : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *selllist;
@property (nonatomic, strong) NSArray *malllist;
@property (nonatomic, strong) NSArray *slidelist;
@property (nonatomic, strong) NSArray *taglist;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
