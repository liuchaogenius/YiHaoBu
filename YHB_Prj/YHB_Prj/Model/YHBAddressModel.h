//
//  YHBAddressModel.h
//
//  Created by   on 15/1/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBAddressModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) double areaid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, assign) double ismain;
@property (nonatomic, assign) double itemid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
