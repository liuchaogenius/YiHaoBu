//
//  ConversationType.h
//  YHB_Prj
//
//  Created by Johnny's on 15/2/11.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMConversation.h"
#import "UserinfoBaseClass.h"

@interface ConversationType : NSObject

@property(nonatomic, strong) EMConversation *conversation;
@property(nonatomic, strong) UserinfoBaseClass *userInfo;

@end
