//
//  PriceDetailContactView.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/22.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceDetailContactView : UIView
{
    UILabel *phoneLabel;
    UILabel *storeLabel;
    UIView *firstView;
    UIButton *secondView;
    UIButton *thirdView;
    NSString *phoneNumber;
    int itemId;
    void(^myBlock)(void);
}
@property(nonatomic, strong) UIButton *fourthView;
- (instancetype)initWithFrame:(CGRect)frame andBlock:(void(^)(void))aBlock;
- (void)setPhoneNumber:(NSString *)aNumber storeName:(NSString *)aName itemId:(int)aItemId;
@end
