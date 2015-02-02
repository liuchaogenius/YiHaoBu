//
//  IntroduceViewController.h
//  Hubanghu
//
//  Created by  striveliu on 14/11/26.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroduceViewController : BaseViewController
@property(nonatomic, assign)BOOL isSysPush;
@property(nonatomic, assign)BOOL isSysPresent;
- (void)setUrl:(NSString *)aLoadUrl title:(NSString *)aTitle;
@end
