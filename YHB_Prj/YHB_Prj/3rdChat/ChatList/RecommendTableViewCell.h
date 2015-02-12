//
//  RecommendTableViewCell.h
//  YHB_Prj
//
//  Created by Johnny's on 15/1/30.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBGetPushBuylist.h"

@interface RecommendTableViewCell : UITableViewCell

- (void)setCellWithModel:(YHBGetPushBuylist *)aModel;
+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)hideRedView;
@end
