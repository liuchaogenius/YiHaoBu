//
//  YHBPublishSupplyViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBPublishSupplyViewController : BaseViewController
{
    UILabel *titleLabel;
    UITextField *priceTextField;
    UILabel *dayLabel;
    UILabel *catNameLabel;
    UITextView *contentTextView;
    UITapGestureRecognizer *tapTitleGesture;
    UITapGestureRecognizer *tapDayGesture;
}
@end
