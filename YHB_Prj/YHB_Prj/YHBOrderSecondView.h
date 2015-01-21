//
//  YHBOrderSecondView.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kSecondHeight 
@protocol YHBOrderSecondViewDelegate <NSObject>

- (void)touchCommunicateBtnWithTag:(NSInteger)tag;

@end

@interface YHBOrderSecondView : UIView

@property (weak, nonatomic) id<YHBOrderSecondViewDelegate> delegate;
- (void)setUIWithSellCom:(NSString *)sellCom Title:(NSString *)title Price:(NSString *)price Number:(NSString *)number fee:(NSString *)fee Money:(NSString *)money thumb:(NSString *)thumb;

@end
