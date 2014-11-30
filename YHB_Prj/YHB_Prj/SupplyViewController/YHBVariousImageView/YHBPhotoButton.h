//
//  YHBPhotoButton.h
//  TestButton
//
//  Created by Johnny's on 14/11/17.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBPhotoButton : UIButton
@property(nonatomic, assign) BOOL isSelected;
@property(nonatomic, strong) UIView *maskingView;

- (instancetype)initWithFrame:(CGRect)frame;
@end
