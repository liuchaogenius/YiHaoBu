//
//  YHBBannerVeiw.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHBBannerDelegate <NSObject,UIScrollViewDelegate>

- (void)touchBannerWithNum:(NSInteger)num;

@end

@interface YHBBannerVeiw : UIView

@property (weak, nonatomic) UIPageControl *pageControl; //分页
@property (strong, nonatomic) UIScrollView *headScrollView;

@property (weak, nonatomic) id<YHBBannerDelegate> delegate;

@end
