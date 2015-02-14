//
//  YHBBannerVeiw.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBBannerVeiw.h"
#import "UIImageView+WebCache.h"

@interface YHBBannerVeiw()

@property (assign, nonatomic) NSInteger imageNum;

@property (weak, nonatomic) UIPageControl *pageControl; //分页
@property (strong, nonatomic) UIScrollView *headScrollView;


@end

@implementation YHBBannerVeiw

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.isNeedCycle = NO;
    self.imageNum = 0;
    UITapGestureRecognizer *tapgz = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBanners)];
    [self addGestureRecognizer:tapgz];
    
    UIScrollView *headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width,self.height)];
    self.headScrollView = headScrollView;
    self.headScrollView.delegate = self;
    [headScrollView setBounces:YES];
    headScrollView.backgroundColor = [UIColor whiteColor];
    [headScrollView setShowsHorizontalScrollIndicator:NO];
    [headScrollView setContentSize:CGSizeMake(self.width, self.height)];
    [self addSubview:headScrollView];

    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
//    //设置image
//    //imageView.image = [UIImage imageNamed:@"bannerDefault"];
//    [headScrollView addSubview:imageView];
//    imageView.backgroundColor = [UIColor whiteColor];
    [headScrollView setPagingEnabled:YES];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setBounds:CGRectMake(0, 0, 150.0, 50.0)];
    [pageControl setCenter:CGPointMake(kMainScreenWidth/2, self.height - 10)];
    [pageControl setNumberOfPages:1];
    [pageControl setCurrentPage:0];
    pageControl.hidesForSinglePage = YES;
    [pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [pageControl setPageIndicatorTintColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    self.imageNum = 1;
    return self;
}

- (void)resetUIWithUrlStrArray:(NSArray *)urlArray
{
    NSInteger imageNum = urlArray.count;
    self.imageNum = imageNum;
    self.headScrollView.pagingEnabled = YES;
    [self.headScrollView removeSubviews];
    [self.headScrollView setContentSize:CGSizeMake((self.isNeedCycle?imageNum+2:imageNum) * kMainScreenWidth, self.headScrollView.height)];
    
    for (NSInteger i = 0; i < (self.isNeedCycle?imageNum+2:imageNum); i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kMainScreenWidth, 0, kMainScreenWidth, self.headScrollView.height)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds = YES;
        MLOG(@"%@",urlArray);
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlArray[_isNeedCycle ? (i-1+imageNum)%imageNum : i]] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        [self.headScrollView addSubview:imageView];
        imageView.tag = i;
    }
    if (urlArray.count == 1 && !_isNeedCycle) {
        self.headScrollView.contentSize = CGSizeMake(kMainScreenWidth+1, self.headScrollView.height);
    }
    [self.pageControl setNumberOfPages:imageNum];
    [self.pageControl setCurrentPage:0];
    if (self.isNeedCycle) {
        self.headScrollView.contentOffset = CGPointMake(kMainScreenWidth, 0);
    }else{
        self.headScrollView.bounces = YES;
        self.headScrollView.contentOffset = CGPointMake(0, 0);
    }
}

#pragma mark - Action
- (void)touchBanners
{
    NSInteger number = self.pageControl.currentPage;
    if (self.imageNum && [self.delegate respondsToSelector:@selector(touchBannerWithNum:)]) {
        [self.delegate touchBannerWithNum:number];
    }
}

#pragma mark - delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNo = scrollView.contentOffset.x / kMainScreenWidth;
    
    if (self.isNeedCycle) {
        if (pageNo+1 == self.imageNum+2) {
            self.headScrollView.contentOffset = CGPointMake(kMainScreenWidth, 0);
            pageNo = 0;
        }else if(pageNo == 0){
            self.headScrollView.contentOffset = CGPointMake(kMainScreenWidth*(self.imageNum), 0);
            pageNo = self.imageNum-1;
        }else{
            --pageNo;
        }
    }
    
    [self.pageControl setCurrentPage:pageNo];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.pageControl.currentPage == self.imageNum-1 && !self.isNeedCycle) {
        CGFloat offSetX = scrollView.contentOffset.x-kMainScreenWidth*self.pageControl.currentPage;
        if (offSetX > 20.0) {
            if ([self.delegate respondsToSelector:@selector(didScrollOverRight)]) {
                [self.delegate didScrollOverRight];
            }
        }
//        MLOG(@"didStop");
//        MLOG(@"x=%f,y=%f",scrollView.contentOffset.x-kMainScreenWidth*self.pageControl.currentPage,scrollView.contentOffset.y);
    }
}

@end
