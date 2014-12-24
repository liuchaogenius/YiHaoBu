//
//  YHBShopListsCell.m
//  YHB_Prj
//
//  Created by yato_kami on 14/12/24.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopListsCell.h"
#import "YHBShoplist.h"
#import "UIButton+WebCache.h"


@interface YHBShopListsCell()
@property (assign, nonatomic) CGFloat imageWidth;
@property (assign, nonatomic) NSInteger imgCount;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *usedButtonArray;
@end

@implementation YHBShopListsCell

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray arrayWithCapacity:16];
    }
    return _buttonArray;
}

- (NSMutableArray *)usedButtonArray
{
    if (_usedButtonArray) {
        _usedButtonArray = [NSMutableArray arrayWithCapacity:16];
    }
    return _usedButtonArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageWidth = (kMainScreenWidth-10*5)/4.0f;
        self.imgCount = 0;
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)clearImageButtons
{
    for (NSInteger i = self.usedButtonArray.count-1;i >= 0 ;i--) {
        UIButton *button = self.usedButtonArray[i];
        [self.buttonArray addObject:button];
        [self.usedButtonArray removeLastObject];
    }
}

-(void)setCellWithShopListArray:(NSArray *)shopList
{
    self.imgCount = shopList.count;
    if (self.imgCount > 0) {
        int rowNum = (int)self.imgCount/4 + 1;
        self.frame = CGRectMake(0, 0, kMainScreenWidth, 5+rowNum*(kslBlankWidth + kslImgHeight));
        for (int i = 0; i < self.imgCount; i++) {
            YHBShoplist *list = shopList[i];
            UIButton *button = [self dequeueReusableButton];
            button.frame = CGRectMake(kslBlankWidth+(i%4)*(_imageWidth+kslBlankWidth), 5+i/4*(kslImgHeight+kslBlankWidth), _imageWidth, kslImgHeight);
        
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:list.avatar] forState:UIControlStateNormal placeholderImage:nil];
            [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [self.contentView addSubview:button];
        }
    }
}

- (void)touchButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(touchShopWithTag:)]) {
        [self.delegate touchShopWithTag:sender.tag];
    }
}

- (UIButton *)dequeueReusableButton
{
    UIButton *button;
    if (self.buttonArray.count > 0) {
        button = self.buttonArray.lastObject;
        [self.buttonArray removeLastObject];
    }else{
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [kLineColor CGColor];
        button.backgroundColor = RGBCOLOR(230, 230, 230);
    }
    [self.usedButtonArray addObject:button];
    return button;
}

@end
