//
//  YHBAddressListsCell.h
//  YHB_Prj
//
//  Created by yato_kami on 15/1/23.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellHeight 70
@interface YHBAddressListsCell : UITableViewCell

- (void)setUIWithName:(NSString *)aName Phone:(NSString *)aPhone address:(NSString *)aAdress isMain:(BOOL)isMain;

@end
