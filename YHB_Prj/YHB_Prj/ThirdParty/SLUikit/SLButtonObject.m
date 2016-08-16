//
//  SLButtonObject.m
//  YHB_Prj
//
//  Created by  striveliu on 14/12/10.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "SLButtonObject.h"
#import <objc/runtime.h>
static char SLButtonTitle;
static char SLButtonTitleFont;

@implementation SLButtonObject
+ (void)setTitle:(NSString *)aTitle font:(UIFont *)aTitleFont
{
    objc_setAssociatedObject(self, &SLButtonTitle, aTitle, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &SLButtonTitleFont, aTitleFont, OBJC_ASSOCIATION_ASSIGN);
    
}

+ (void)getTitle
{
    NSString *title = nil;
    title = objc_getAssociatedObject(self, &SLButtonTitle);
    MLOG(@"%@",title);
}

+ (void)buttonItem:(UIButton *)aButon
{
    MLOG(@"buttonItem%d",aButon.tag);
}

+ (UIButton *)buildSLButton
{
    UIButton *butotn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    butotn.backgroundColor = [UIColor redColor];
    [butotn addTarget:[SLButtonObject class] action:@selector(buttonItem:) forControlEvents:UIControlEventTouchUpInside];
    return butotn;
}
@end
