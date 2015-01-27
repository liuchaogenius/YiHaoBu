//
//  YHBOConfirmModel.h
//
//  Created by   on 15/1/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBOConfirmModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addAddress;
@property (nonatomic, assign) double addItemid;
@property (nonatomic, strong) NSString *addMobile;
@property (nonatomic, strong) NSArray *rslist;
@property (nonatomic, strong) NSString *addTruename;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
