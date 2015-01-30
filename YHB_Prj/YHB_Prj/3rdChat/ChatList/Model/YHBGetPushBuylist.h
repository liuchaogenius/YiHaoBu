//
//  YHBGetPushBuylist.h
//
//  Created by  C陈政旭 on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBGetPushBuylist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *adddate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *edittime;
@property (nonatomic, assign) double itemid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
