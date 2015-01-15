//
//  YHBComment.h
//
//  Created by   on 15/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBComment : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, assign) double userid;
@property (nonatomic, strong) NSString *adddate;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, assign) double itemid;
@property (nonatomic, strong) NSString *comment;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
