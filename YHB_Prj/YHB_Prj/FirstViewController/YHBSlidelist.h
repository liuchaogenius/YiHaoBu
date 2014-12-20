//
//  YHBSlidelist.h
//
//  Created by   on 14/12/19
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBSlidelist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *linkurl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
