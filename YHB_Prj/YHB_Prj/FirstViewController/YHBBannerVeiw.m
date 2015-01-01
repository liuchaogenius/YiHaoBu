//
//  YHBBannerVeiw.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBBannerVeiw.h"

@implementation YHBBannerVeiw

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    
    UITapGestureRecognizer *tapgz = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBanners)];
    [self addGestureRecognizer:tapgz];
    
    UIScrollView *headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width,self.height)];
    self.headScrollView = headScrollView;
    [headScrollView setBounces:NO];
    headScrollView.backgroundColor = [UIColor whiteColor];
    [headScrollView setShowsHorizontalScrollIndicator:NO];
    [headScrollView setContentSize:CGSizeMake(self.width, self.height)];
    [self addSubview:headScrollView];

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    //设置image
    imageView.image = [UIImage imageNamed:@"bannerDefault"];
    [headScrollView addSubview:imageView];
    imageView.backgroundColor = [UIColor whiteColor];
    [headScrollView setPagingEnabled:YES];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setBounds:CGRectMake(0, 0, 150.0, 50.0)];
    [pageControl setBounds:CGRectMake(0, 0, 150.0, 50.0)];
    [pageControl setCenter:CGPointMake(kMainScreenWidth/2, self.height - 10)];
    [pageControl setNumberOfPages:1];
    [pageControl setCurrentPage:0];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [pageControl setPageIndicatorTintColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.7 alpha:0.8]];
    [self addSubview:pageControl];
    self.pageControl = pageControl;

    return self;
}

#pragma mark - Action
- (void)touchBanners
{
    NSInteger number = self.pageControl.currentPage;
    if ([self.delegate respondsToSelector:@selector(touchBannerWithNum:)]) {
        [self.delegate touchBannerWithNum:number];
    }
}



@end
