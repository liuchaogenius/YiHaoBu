//
//  YHBSupplyDetailView.h
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBSupplyDetailModel.h"

@interface YHBSupplyDetailView : UIView
{
    UITextView *detailTextView;
    UILabel *timeLabel;
    UILabel *personLabel;
    UILabel *nameLabel;
    UIView *bottomLineView;
}
- (instancetype)initWithFrame:(CGRect)frame;
- (void)setDetailWithModel:(YHBSupplyDetailModel *)aModel;
@end
