/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "ChatListViewController.h"
#import "SRRefreshView.h"
#import "ChatListCell.h"
//#import "EMSearchBar.h"
#import "NSDate+Category.h"
//#import "RealtimeSearchUtil.h"
#import "ChatViewController.h"
//#import "EMSearchDisplayController.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "YHBMessageViewController.h"
#import "YHBRecommendViewController.h"
#import "YHBGetPushManage.h"
#import "SVProgressHUD.h"
#import "YHBDataService.h"
#import "YHBGetPushBuylist.h"
#import "YHBGetPushSyslist.h"
#import "GetUserNameManage.h"
#import "UserinfoBaseClass.h"

@interface ChatListViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate,SRRefreshDelegate, UISearchBarDelegate, IChatManagerDelegate>

@property (strong, nonatomic) NSMutableArray        *dataSource;
@property (strong, nonatomic) NSMutableArray        *dataArray;
@property (strong, nonatomic) GetUserNameManage *manage;

@property (strong, nonatomic) UITableView           *tableView;
//@property (nonatomic, strong) EMSearchBar           *searchBar;
@property (nonatomic, strong) SRRefreshView         *slimeView;
@property (nonatomic, strong) UIView                *networkStateView;
@property(nonatomic, strong) YHBGetPushManage *netManage;
@property(nonatomic, strong) NSMutableArray *pushArray;
//@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation ChatListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    self.manage = [[GetUserNameManage alloc] init];

//    [self.view addSubview:self.searchBar];
    [self settitleLabel:@"消息"];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self networkStateView];
    
//    [self searchController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshGetPush];
    [self refreshDataSource];
    [self registerNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (void)refreshGetPush
{
    [self.netManage getPushSucc:^(NSMutableArray *aArray) {
        self.pushArray = [NSMutableArray new];
        self.pushArray = aArray;
        NSMutableArray *buylist = [self.pushArray objectAtIndex:0];
        NSMutableArray *syslist = [self.pushArray objectAtIndex:1];
        if (buylist)
        {
            NSMutableArray *newBuyList = [NSMutableArray new];
            for (YHBGetPushBuylist *model in buylist)
            {
                model.isread = @"NO";
                [newBuyList addObject:model];
            }
            [[YHBDataService sharedYHBDataSevice] saveBuyList:newBuyList];
        }
        if (syslist)
        {
            [[YHBDataService sharedYHBDataSevice] saveSysList:syslist];
        }
    } andFail:^(NSString *aStr) {
        [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
    }];
}

#pragma mark - getter

- (YHBGetPushManage *)netManage
{
    if (!_netManage) {
        _netManage = [[YHBGetPushManage alloc] init];
    }
    return _netManage;
}

- (SRRefreshView *)slimeView
{
    if (!_slimeView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
        _slimeView.backgroundColor = [UIColor whiteColor];
    }
    
    return _slimeView;
}

//- (UISearchBar *)searchBar
//{
//    if (!_searchBar) {
//        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
//        _searchBar.delegate = self;
//        _searchBar.placeholder = @"搜索";
//        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
//    }
//    
//    return _searchBar;
//}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(239, 239, 239);
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
    }
    
    return _tableView;
}

//- (EMSearchDisplayController *)searchController
//{
//    if (_searchController == nil) {
//        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
//        _searchController.delegate = self;
//        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        
//        __weak ChatListViewController *weakSelf = self;
//        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
//            static NSString *CellIdentifier = @"ChatListCell";
//            ChatListCell *cell = (ChatListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            
//            // Configure the cell...
//            if (cell == nil) {
//                cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            }
//            
//            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
//            cell.name = conversation.chatter;
//            if (!conversation.isGroup) {
//                cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
//            }
//            else{
//                NSString *imageName = @"groupPublicHeader";
//                NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
//                for (EMGroup *group in groupArray) {
//                    if ([group.groupId isEqualToString:conversation.chatter]) {
//                        cell.name = group.groupSubject;
//                        imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
//                        break;
//                    }
//                }
//                cell.placeholderImage = [UIImage imageNamed:imageName];
//            }
//            cell.detailMsg = [weakSelf subTitleMessageByConversation:conversation];
//            cell.time = [weakSelf lastMessageTimeByConversation:conversation];
//            cell.unreadCount = [weakSelf unreadMessageCountByConversation:conversation];
//            if (indexPath.row % 2 == 1) {
//                cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
//            }else{
//                cell.contentView.backgroundColor = [UIColor whiteColor];
//            }
//            return cell;
//        }];
//        
//        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
//            return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
//        }];
//        
//        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//            [weakSelf.searchController.searchBar endEditing:YES];
//            
//            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
//            ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:conversation.chatter isGroup:conversation.isGroup];
//            chatVC.title = conversation.chatter;
//            [weakSelf.navigationController pushViewController:chatVC animated:YES];
//        }];
//    }
//    
//    return _searchController;
//}

- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"当前网络连接失败";
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - private

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSArray* sorte = [conversations sortedArrayUsingComparator:
           ^(EMConversation *obj1, EMConversation* obj2){
               EMMessage *message1 = [obj1 latestMessage];
               EMMessage *message2 = [obj2 latestMessage];
               if(message1.timestamp > message2.timestamp) {
                   return(NSComparisonResult)NSOrderedAscending;
               }else {
                   return(NSComparisonResult)NSOrderedDescending;
               }
           }];
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = @"[图片]";
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                if (lastMessage.ext)
                {
                    ret = @"商品链接";
                }
                else
                {
                    NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                                convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                    ret = didReceiveText;
                }
            } break;
            case eMessageBodyType_Voice:{
                ret = @"[声音]";
            } break;
            case eMessageBodyType_Location: {
                ret = @"[位置]";
            } break;
            case eMessageBodyType_Video: {
                ret = @"[视频]";
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}

#pragma mark - TableViewDelegate & TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0)
    {
        ChatListCell *cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell0"];
        cell.name = @"系统消息";
        cell.placeholderImage = [UIImage imageNamed:@"xiaoxi"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YHBDataService *dataService = [YHBDataService sharedYHBDataSevice];
        NSArray *syslist = [dataService getSyslist];
        NSString *detailStr;
        NSString *timeStr;
        if (syslist.count>0)
        {
            YHBGetPushSyslist *model = [syslist lastObject];
            detailStr = model.title;
            timeStr = [model.adddate substringWithRange:NSMakeRange(0, 10)];
        }
        else
        {
            detailStr = @"无消息";
            timeStr = @"";
        }
        cell.detailMsg = detailStr;
        cell.time = timeStr;

        return cell;
    }
    else if(indexPath.row==1)
    {
        ChatListCell *cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        cell.name = @"商机推荐";
        cell.placeholderImage = [UIImage imageNamed:@"dingyue"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YHBDataService *dataService = [YHBDataService sharedYHBDataSevice];
        NSArray *buylist = [dataService getBuylist];
        NSString *detailStr;
        NSString *timeStr;
        if (buylist.count>0)
        {
            YHBGetPushSyslist *model = [buylist objectAtIndex:0];
            detailStr = model.title;
            timeStr = [model.adddate substringWithRange:NSMakeRange(0, 10)];
        }
        else
        {
            detailStr = @"无消息";
            timeStr = @"";
        }
        cell.detailMsg = detailStr;
        cell.time = timeStr;
        
        return cell;
    }
    else
    {
        static NSString *identify = @"chatListCell";
        ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (!cell) {
            cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row-2];
        UserinfoBaseClass *model = [self.dataArray objectAtIndex:indexPath.row-2];
        cell.name = model.truename;
        cell.imageURL = [NSURL URLWithString:model.avatar];
        if (!conversation.isGroup) {
            cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
        }
        else{
            NSString *imageName = @"groupPublicHeader";
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    cell.name = group.groupSubject;
                    imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                    break;
                }
            }
            cell.placeholderImage = [UIImage imageNamed:imageName];
        }
        cell.detailMsg = [self subTitleMessageByConversation:conversation];
        cell.time = [self lastMessageTimeByConversation:conversation];
        cell.unreadCount = [self unreadMessageCountByConversation:conversation];
//        if (indexPath.row % 2 == 1) {
//            cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
//        }else{
            cell.contentView.backgroundColor = [UIColor whiteColor];
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count+2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<2)
    {
        return 60;
    }
    else
    {
        return [ChatListCell tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<2)
    {
        if (indexPath.row==0)
        {
            YHBMessageViewController *vc = [[YHBMessageViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==1)
        {
            YHBRecommendViewController *vc = [[YHBRecommendViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row-2];
        UserinfoBaseClass *model = [self.dataArray objectAtIndex:indexPath.row-2];

        ChatViewController *chatController;
        NSString *title = conversation.chatter;
        if (conversation.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    title = group.groupSubject;
                    break;
                }
            }
        }
        
        NSString *chatter = conversation.chatter;
        chatController = [[ChatViewController alloc] initWithChatter:chatter isGroup:conversation.isGroup andChatterAvatar:model.avatar];
        chatController.title = model.truename;
        chatController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:YES];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [self.dataSource objectAtIndex:indexPath.row-2];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:NO];
        [self.dataSource removeObjectAtIndex:indexPath.row-2];
        [self.dataArray removeObjectAtIndex:indexPath.row-2];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataSource searchText:(NSString *)searchText collationStringSelector:@selector(chatter) resultBlock:^(NSArray *results) {
//        if (results) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.searchController.resultsSource removeAllObjects];
//                [self.searchController.resultsSource addObjectsFromArray:results];
//                [self.searchController.searchResultsTableView reloadData];
//            });
//        }
//    }];
//}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    searchBar.text = @"";
////    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
//    [searchBar resignFirstResponder];
//    [searchBar setShowsCancelButton:NO animated:YES];
//}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate
//刷新消息列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self refreshDataSource];
    [_slimeView endRefresh];
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - public

-(void)refreshDataSource
{
    self.dataSource = [self loadDataSource];
//    MLOG(@"%lu", (unsigned long)self.dataSource.count);
    if (self.dataSource.count>0)
    {
        NSMutableArray *temarray = [NSMutableArray new];
        for (int i=0; i<self.dataSource.count; i++)
        {
            EMConversation *con = [self.dataSource objectAtIndex:i];
            [temarray addObject:con.chatter];
        }
        [self.manage getUserNameUseridArray:temarray succBlock:^(NSMutableArray *aMuArray) {
            self.dataArray = aMuArray;
            [_tableView reloadData];
        } failBlock:^(NSString *aStr) {
            [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
        }];
    }
//    MLOG(@"%lu", (unsigned long)self.dataSource.count);
//    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        _tableView.tableHeaderView = _networkStateView;
    }
    else{
        _tableView.tableHeaderView = nil;
    }

}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
        _tableView.tableHeaderView = _networkStateView;
    }
    else{
        _tableView.tableHeaderView = nil;
    }
}

- (void)willReceiveOfflineMessages{
    NSLog(@"开始接收离线消息");
}

- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages{
    NSLog(@"离线消息接收成功");
    [self refreshDataSource];
}

@end
