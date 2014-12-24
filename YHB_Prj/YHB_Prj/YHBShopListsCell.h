//
//  YHBShopListsCell.h
//  YHB_Prj
//
//  Created by yato_kami on 14/12/24.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kslBlankWidth 10.0
#define kslImgHeight 55

@protocol YHBShopListCellDelegate <NSObject>

- (void)touchShopWithTag:(NSInteger)tag;

@end

@interface YHBShopListsCell : UITableViewCell

@property (weak, nonatomic) id<YHBShopListCellDelegate> delegate;

-(void)setCellWithShopListArray:(NSArray *)shopList;
- (void)clearImageButtons;

@end
