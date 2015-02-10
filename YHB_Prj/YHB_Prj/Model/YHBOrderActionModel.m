//
//  YHBOrderActionModel.m
//  YHB_Prj
//
//  Created by yato_kami on 15/2/10.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderActionModel.h"

@implementation YHBOrderActionModel

+ (NSString *)getTitleOfNextStepForNactionStr:(NSString *)str
{
    if ([str isEqualToString:@"close"]) {
        return @"取消订单";
    }else if([str isEqualToString:@"pay"]) {
        return @"付款";
    }else if ([str isEqualToString:@"receive"]) {
        return @"立即收货";
    }else if ([str isEqualToString:@"comment"]) {
        return @"评价";
    }else if ([str isEqualToString:@"refund"]) {
        return nil;
    }
    return nil;
}

@end
