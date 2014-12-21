//
//  YHBContactView.h
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBContactView : UIView<UIAlertViewDelegate>
{
    UILabel *phoneLabel;
    UILabel *storeLabel;
    UIView *firstView;
    UIButton *secondView;
    UIButton *thirdView;
    UIButton *fourthView;
    NSString *phoneNumber;
    int itemId;
}

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setPhoneNumber:(NSString *)aNumber storeName:(NSString *)aName itemId:(int)aItemId isVip:(int)aisVip;
@end
