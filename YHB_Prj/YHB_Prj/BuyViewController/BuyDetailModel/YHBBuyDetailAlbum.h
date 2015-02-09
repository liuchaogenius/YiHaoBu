//
//  YHBBuyDetailAlbum.h
//
//  Created by  C陈政旭 on 15/2/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YHBBuyDetailAlbum : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *large;
@property (nonatomic, strong) NSString *middle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
