//
//  YHBProductManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/3.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHBProductDetail;
@interface YHBProductManager : NSObject

- (void)getProductDetailInfoWithProductID:(NSInteger)productID token:(NSString *)token Success : (void(^)(YHBProductDetail *model))sBlock failure:(void(^)(NSString *error))fBlock;

@end
