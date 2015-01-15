//
//  YHBPivateManager.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/14.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
enum privateType
{
    private_sell = 0,
    private_buy,
    private_mall,
    private_company
};
@interface YHBPrivateManager : NSObject

- (void)privateOrDisPrivateWithItemID:(NSString *)itemID privateType:(NSInteger)privateType token:(NSString *)token Success:(void(^)())sBlock failure:(void(^)())fBlock;


@end
