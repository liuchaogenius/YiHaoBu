//
//  YHBMessageViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 15/1/29.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBMessageViewController.h"
#import "EMChatViewCell.h"
#import "EMChatTimeCell.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "YHBDataService.h"
#import "YHBGetPushSyslist.h"

@interface YHBMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation YHBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"系统消息"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.dataSource = [NSMutableArray new];
    
    YHBDataService *dataService = [YHBDataService sharedYHBDataSevice];
    NSArray *syslist = [dataService getSyslist];
    NSArray *resultList = [NSArray new];
    if (syslist.count>10)
    {
        NSRange range = NSMakeRange(syslist.count-10, 10);
        resultList = [syslist subarrayWithRange:range];
    }
    else
    {
        resultList = syslist;
    }
    for (YHBGetPushSyslist *model in resultList)
    {
        NSString *time = model.adddate;
        [self.dataSource addObject:time];
        MessageModel *messageModel = [MessageModel new];
        messageModel.isSender = NO;
        messageModel.type = eMessageBodyType_Text;
        messageModel.content = model.title;
        [self.dataSource addObject:messageModel];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    NSObject *obj = [self.dataSource objectAtIndex:row];
    if ([obj isKindOfClass:[NSString class]])
    {
        return 40;
    }
    else
    {
        return [EMChatViewCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:(MessageModel *)obj];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    if (row < self.dataSource.count)//|| row==self.dataSource.count)
    {
        id obj = [self.dataSource objectAtIndex:row];
        if ([obj isKindOfClass:[NSString class]])
        {
            EMChatTimeCell *timeCell = (EMChatTimeCell *)[tableView dequeueReusableCellWithIdentifier:@"MessageCellTime"];
            if (timeCell == nil) {
                timeCell = [[EMChatTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCellTime"];
                timeCell.backgroundColor = [UIColor clearColor];
                timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            timeCell.textLabel.text = (NSString *)obj;
            
            return timeCell;
        }
        else
        {
            MessageModel *model = (MessageModel *)obj;
            NSString *cellIdentifier = [EMChatViewCell cellIdentifierForMessageModel:model];
            EMChatViewCell *cell = (EMChatViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil)
            {
                cell = [[EMChatViewCell alloc] initWithMessageModel:model reuseIdentifier:cellIdentifier];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.messageModel = model;
            
            return cell;
        }
    }
    return nil;
}



#pragma mark 菊花
- (void)showFlower
{
    [SVProgressHUD show:YES offsetY:kMainScreenHeight/2.0];
}

- (void)dismissFlower
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
