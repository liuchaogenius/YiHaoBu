//
//  YHBShopsListCell.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBShopsListCell : UITableViewCell

- (void)setUIWithImage:(NSString *)urlStr title:(NSString *)title Name:(NSString *)name Star1:(NSString *)star1 Star2:(NSString *)star2 GroupID:(int)groupID;

- (void)setUIWithImage:(NSString *)urlStr title:(NSString *)title Name:(NSString *)name GroupID:(int)groupID;

@end
