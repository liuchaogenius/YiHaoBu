//
//  UserinfoBaseClass.h
//
//  Created by  C陈政旭 on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserinfoBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *truename;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
