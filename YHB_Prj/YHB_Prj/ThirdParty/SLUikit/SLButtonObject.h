//
//  SLButtonObject.h
//  YHB_Prj
//
//  Created by  striveliu on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLButtonObject : NSObject
+ (void)setTitle:(NSString *)aTitle font:(UIFont *)aTitleFont;
+ (void)setImg:(UIImage *)aImg;
+ (void)setBackgroundImg:(UIImage *)aBackImg;
+ (void)setButtonRelativeRect:(UIView *)aRelative
                          top:(float)aTop
                         left:(float)aLeft
                       bottom:(float)aBottom
                        right:(float)aRight
                        width:(float)aWidth
                       height:(float)aHeight;
+ (void)setButtonTouchUpInsidBlock:(void(^)(UIButton *aButton))aBlock;
+ (UIButton *)buildSLButton;
@end
