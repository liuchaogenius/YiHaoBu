//
//  ChangeCountView.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/13.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeCountView : UIView
{
    UILabel *countLabel;
}
@property (nonatomic, assign) int count;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setCountLabel:(int)aCount;
@end
