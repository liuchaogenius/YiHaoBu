//
//  YHBOConfirmModel.h
//
//  Created by   on 15/1/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBOConfirmModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *rslist;
@property (nonatomic, strong) NSString *buyerAddress;
@property (nonatomic, strong) NSString *buyerName;
@property (nonatomic, strong) NSString *buyerMobile;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
