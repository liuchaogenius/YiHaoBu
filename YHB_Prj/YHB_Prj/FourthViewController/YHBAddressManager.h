//
//  YHBAddressManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHBAddressModel;
@interface YHBAddressManager : NSObject

- (void)getDefaultAddressWithToken:(NSString *)token WithSuccess:(void(^)(YHBAddressModel *model))sBlock failure:(void(^)(int redult))fBlock;

@end
