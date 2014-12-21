//
//  TitleTagViewController.h
//  YHB_Prj
//
//  Created by Johnny's on 14/12/18.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleTagManage.h"

@interface TitleTagViewController : BaseViewController
{
    TitleTagManage *manage;
}

- (void)useBlock:(void(^)(NSString *title))aBlock;
@end
