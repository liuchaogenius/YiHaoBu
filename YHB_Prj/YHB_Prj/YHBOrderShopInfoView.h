//
//  YHBOrderShopInfoView.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/19.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kShopHeight 30

@protocol YHBOrderShopInfoDelegte<NSObject>

- (void)touchShopWithItemID:(NSInteger)itemID;

@end

@interface YHBOrderShopInfoView : UITableViewHeaderFooterView

@property (weak, nonatomic) id<YHBOrderShopInfoDelegte> delegate;

- (void)setUIWithCompany:(NSString *)com statusDes:(NSString *)des ItemID:(NSInteger)itemID;

@end
