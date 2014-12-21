//
//  YHBEditSupplyView.h
//  TestButton
//
//  Created by Johnny's on 14/11/18.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBVariousView.h"

@class YHBEditSupplyView;
@protocol YHBEditSupplyViewDelegate <NSObject>

- (void)touchDayLabel;

@end

@interface YHBEditSupplyView : UIScrollView<UITextFieldDelegate, UITextViewDelegate>
{
//    UITextField *titleTextField;
    UILabel *titleLabel;
    UITextField *priceTextField;
    UILabel *dayLabel;
    UILabel *catNameLabel;
    UITextView *contentTextView;
    UITapGestureRecognizer *tapTitleGesture;
    UITapGestureRecognizer *tapDayGesture;
    
    YHBVariousView *typeVariousView;
    CGRect oldFrame;
    UIScrollView *contentScrollView;
    CGRect oldScrollFrame;
}
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *price;
@property(nonatomic ,copy) NSString *content;
@property(nonatomic ,copy) NSString *typeIdentifier;
@property (nonatomic, assign) int typeid;

- (instancetype)initWithFrame:(CGRect)frame;
@end
