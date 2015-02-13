//
//  YHBHotTagsCell.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/20.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHotTagCellHeight 75
#define kTagRowNum 5
@protocol YHBHotTagsDelegate <NSObject>

- (void)touchHotTagsWithTag:(NSInteger)tag;

@end

@interface YHBHotTagsCell : UITableViewCell

@property (strong, nonatomic) NSMutableArray *tagsArray;
//@property (strong, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) id<YHBHotTagsDelegate> delegate;

@end
