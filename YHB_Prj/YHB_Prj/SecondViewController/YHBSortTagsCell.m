//
//  YHBSortTagsCell.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/17.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBSortTagsCell.h"
#import "YHBTagView.h"
#import "YHBCatSubcate.h"
#define kBlankWidth 10
#define kTagHeight 30
#define kBtnHeight 28
#define kTagWidth ((kMainScreenWidth - 5*kBlankWidth)/4.0)

@interface YHBSortTagsCell ()

@property (strong, nonatomic) NSMutableArray *reuseTvArray;//复用数组

@end

@implementation YHBSortTagsCell

- (NSMutableArray *)reuseTvArray
{
    if (!_reuseTvArray) {
        _reuseTvArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _reuseTvArray;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setUIWithCateArray:(NSMutableArray *)array
{
    [self.contentView removeSubviews];
    if (!array) {
        self.height = 0;
    }
    for (int i = 0; i < array.count; i++) {
        YHBCatSubcate *cate = array[i];
        YHBTagView *view = [self dequeseViewWithIndex:i];
        view.frame = CGRectMake(10+i%4*(10+kTagWidth), 10+i/4*(10+kTagHeight), kTagWidth, kTagHeight);
        view.titleLabel.text = cate.catname;
        view.delButton.tag = (NSInteger)cate.catid;
        [self.contentView addSubview:view];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)touchDelButton : (UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteSortTagWithTag:)]) {
        [self.delegate deleteSortTagWithTag:sender.tag];
    }
}

- (YHBTagView *)dequeseViewWithIndex:(NSInteger)index
{
    if (self.reuseTvArray.count > index) {
        return self.reuseTvArray[index];
    }else{
        YHBTagView *view = [[YHBTagView alloc] initWithFrame:CGRectMake(0, 0, kTagWidth, kTagHeight)];
        [view.delButton addTarget:self action:@selector(touchDelButton:) forControlEvents:UIControlEventTouchUpInside];
        return view;
    }
}

@end
