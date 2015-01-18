//
//  YHBSortTagsCell.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTagHeight 30
#define kBlankWidth 10
@protocol YHBSortTagDelegate <NSObject>

- (void)deleteSortTagWithTag:(NSInteger)tag;

@end

@interface YHBSortTagsCell : UITableViewCell

@property (weak, nonatomic) id<YHBSortTagDelegate> delegate;
- (void)setUIWithCateArray:(NSMutableArray *)array;

@end
