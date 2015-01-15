//
//  YHBSku.h
//
//  Created by   on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBSku : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *large;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double colorid;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *middle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
