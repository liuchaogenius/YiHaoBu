//
//  YHBOrderFirstSectionView.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kOrderFSHeight 200
@protocol YHBOrderFSDelegate<NSObject>

- (void)touchLogicCell;//点击快递cell

@end

@interface YHBOrderFirstSectionView : UIView

@property (weak, nonatomic) id<YHBOrderFSDelegate> delegate;

- (void)setUIWithBuyer:(NSString *)buyer address:(NSString *)address moble:(NSString *)mobil statusDes:(NSString *)des isNeedLogicView:(BOOL)isNeed amount:(NSString *)money fee:(NSString *)fee;

@end
