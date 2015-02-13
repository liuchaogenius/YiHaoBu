//
//  BaseViewController.m
//  FW_Project
//
//  Created by  striveliu on 13-10-3.
//  Copyright (c) 2013年 striveliu. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewInteraction.h"

@interface BaseViewController ()
{
    UILabel *titleLabel;
}
@end

@implementation BaseViewController
@synthesize g_OffsetY;
//@synthesize backgroundimg;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self setNavgtionBarBg];
    if(kSystemVersion>=7.0)
    {
        self.navigationController.navigationBar.barTintColor = RGBCOLOR(249, 249, 249);
    }
    else
    {
        self.navigationController.navigationBar.tintColor = RGBCOLOR(249, 249, 249);
    }
    self.navigationController.navigationBar.alpha = 1;

    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    if (self != [self.navigationController.viewControllers objectAtIndex:0])
    {
        [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(back)];
    }

    if(kSystemVersion >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }

    if(self.navigationController)
    {
        if(self.navigationController.navigationBarHidden == YES)
        {
            if(kSystemVersion >= 7.0)
            {
                g_OffsetY = 20;
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
            }
            else
            {
                g_OffsetY = 0;
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20);
            }
        }
        else
        {
            if(kSystemVersion >= 7.0)
            {
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-self.navigationController.navigationBar.frame.size.height-20);
            }
            else
            {
                self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-self.navigationController.navigationBar.frame.size.height-20);
            }
        }
    }
    else
    {
        if(kSystemVersion >= 7.0)
        {
            g_OffsetY = 20;
            self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
        }
        else
        {
            g_OffsetY = 0;
            self.view.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20);
        }
    }
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setBackgroundimg:(UIImage *)aBackgroundimg
{
    if(aBackgroundimg)
    {
        _backgroundimg = [aBackgroundimg resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imgview.contentMode = UIViewContentModeScaleAspectFill;
        [imgview setImage:_backgroundimg];
        [self.view addSubview:imgview];
    }
}
- (void)setLeftButton:(UIImage *)aImg title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector
{
    CGRect buttonFrame = CGRectMake(-5, 0, 44, 44);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    button.backgroundColor = [UIColor clearColor];
    
    CGRect viewFrame = CGRectMake(0, 0, 88/2, 44);
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    if(aImg)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 11, 13, 22)];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        imageView.image = aImg;
        [view addSubview:imageView];
    }
    if(aTitle)
    {
        [button setTitle:aTitle forState:UIControlStateNormal];
    }
    [button addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    if(self.navigationController && self.navigationItem)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
}

- (void)settitleLabel:(NSString*)aTitle
{
    if(!titleLabel)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, self.navigationController.navigationBar.frame.size.height)];
        self.navigationItem.titleView = titleLabel;
    }
    titleLabel.center = self.navigationController.navigationBar.center;
    titleLabel.backgroundColor = kClearColor;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = kFont18;
    titleLabel.text = aTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)setRightButton:(UIImage *)aImg title:(NSString *)aTitle target:(id)aTarget action:(SEL)aSelector
{
    CGRect buttonFrame = CGRectMake(5, 0, 59.0f, 44.0f);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    
    
    CGRect viewFrame = CGRectMake(0, 0, 88/2, 44);
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    if(aImg)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 11, 25, 25)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        imageView.image = aImg;
        [view addSubview:imageView];
    }
    if(aTitle)
    {
        [button setTitle:aTitle forState:UIControlStateNormal];
    }
    
    
    [view addSubview:button];
    if(self.navigationController && self.navigationItem)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
    _rightButton = button;
}

- (void)pushView:(UIView*)aView
{
    [ViewInteraction viewPresentAnimationFromRight:self.view toView:aView];
}

- (void)popView:(UIView*)aView completeBlock:(void(^)(BOOL isComplete))aCompleteblock
{
    [ViewInteraction viewDissmissAnimationToRight:aView isRemove:NO completeBlock:^(BOOL isComplete) {
        aCompleteblock(isComplete);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
