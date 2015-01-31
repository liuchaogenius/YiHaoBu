//
//  LookQuoteManage.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/21.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookQuoteManage : NSObject

- (void)getQuoteArray:(void(^)(NSMutableArray *aArray))aSuccBlock andFail:(void(^)(NSString *aStr))aFailBlock isMe:(BOOL)aBool;
- (void)getNextQuoteArray:(void (^)(NSMutableArray *aArray))aSuccBlock andFail:(void (^)(NSString *aStr))aFailBlock;
@end
