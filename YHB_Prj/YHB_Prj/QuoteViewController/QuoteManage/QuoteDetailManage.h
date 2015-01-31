//
//  QuoteDetailManage.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/22.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuoteDetailManage : NSObject

- (void)getQuoteDetailForItemid:(int)aItemid succBlock:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(NSString *aStr))aFailBlock;
- (void)getNextQuoteArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock;
@end
