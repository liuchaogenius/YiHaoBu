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
@property (nonatomic, assign) float count;
@property(nonatomic, strong) void(^ myBlock)(float aCount);
- (instancetype)initWithFrame:(CGRect)frame andChangeBlock:(void(^)(float aCount))aChangeBlock;
- (void)setCountLabel:(float)aCount;
@end
