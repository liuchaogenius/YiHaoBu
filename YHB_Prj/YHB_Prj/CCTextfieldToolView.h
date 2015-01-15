//
//  CCTextfieldToolView.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/14.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTextFieldToolHeight 25
typedef void (^unary_operation_confirm)();
typedef void (^unary_operation_cancel)();

@interface CCTextfieldToolView : UIView

+ (instancetype)sharedView;

- (void)showToolWithY:(CGFloat)y comfirmBlock: (unary_operation_confirm)cBlock cancelBlock:(unary_operation_cancel)cancleBlock;

@end
