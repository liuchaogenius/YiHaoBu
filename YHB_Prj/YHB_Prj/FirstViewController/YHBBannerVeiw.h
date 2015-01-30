//
//  YHBBannerVeiw.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHBBannerDelegate <NSObject>

- (void)touchBannerWithNum:(NSInteger)num;

@optional
- (void)didScrollOverRight;

@end

@interface YHBBannerVeiw : UIView<UIScrollViewDelegate>

@property (assign, nonatomic) BOOL isNeedCycle;

@property (weak, nonatomic) id<YHBBannerDelegate> delegate;

- (void)resetUIWithUrlStrArray:(NSArray *)urlArray;

@end
