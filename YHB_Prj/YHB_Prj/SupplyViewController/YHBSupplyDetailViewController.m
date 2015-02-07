//
//  YHBSupplyDetailViewController.m
//  YHB_Prj
//
//  Created by Johnny's on 14/11/30.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBSupplyDetailViewController.h"
#import "YHBSupplyDetailView.h"
#import "YHBVariousImageView.h"
#import "YHBSupplyDetailManage.h"
#import "SVProgressHUD.h"
#import "YHBContactView.h"
#import "YHBPublishSupplyViewController.h"
#import "YHBShopMallViewController.h"
#import "NetManager.h"
#import "YHBUser.h"
#import "YHBSupplyDetailPic.h"

#define kContactViewHeight 60
@interface YHBSupplyDetailViewController ()
{
    UIScrollView *scrollView;
    YHBSupplyDetailView *supplyDetailView;
    YHBVariousImageView *variousImageView;
    YHBContactView *contactView;
    BOOL isModal;
    int itemId;
    BOOL isMine;
    YHBSupplyDetailModel *myModel;
    NSArray *uploadPhotoArray;
    BOOL needUpload;
    NSDictionary *itemDict;
    
    int uploadIndex;
    BOOL isWeb;
}
@property(nonatomic, strong) YHBSupplyDetailManage *netManage;
@end

@implementation YHBSupplyDetailViewController

//- (instancetype)initWithItemId:(int)aItemId andIsMine:(BOOL)aIsMine;
//{
//    if (self = [super init]) {
//        isModal=NO;
//        itemId = aItemId;
//        isMine = aIsMine;
//    }
//    return self;
//}

- (instancetype)initWithItemId:(int)aItemId andIsMine:(BOOL)aIsMine isModal:(BOOL)aIsModal
{
    if (self = [super init]) {
        isModal=aIsModal;
        itemId = aItemId;
        isMine = aIsMine;
    }
    return self;
}

- (instancetype)initWithItemId:(int)aItemId itemDict:(NSDictionary *)aDict uploadPhotoArray:(NSArray *)aArray isWebArray:(BOOL)aBool
{
    if (self = [super init]) {
        isModal = YES;
        isMine = YES;
        itemId = aItemId;
        uploadPhotoArray = aArray;
        needUpload = YES;
        itemDict = aDict;
        isWeb = aBool;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:YES];
}

- (instancetype)init
{
    if (self = [super init]) {
        isModal = YES;
        [self dismissFlower];
    }
    return self;
}

- (YHBSupplyDetailManage *)netManage
{
    if (!_netManage) {
        _netManage = [[YHBSupplyDetailManage alloc] init];
    }
    return _netManage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(241, 241, 241);
    self.title = @"供应详情";
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-kContactViewHeight-62)];
    [self.view addSubview:scrollView];
    
    variousImageView = [[YHBVariousImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 120) andPhotoArray:[NSArray new]];
    [scrollView addSubview:variousImageView];
    
    supplyDetailView = [[YHBSupplyDetailView alloc] initWithFrame:CGRectMake(0, variousImageView.bottom, kMainScreenWidth, 270) andIsMine:isMine];
    [scrollView addSubview:supplyDetailView];
    
    [self setLeftButton:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(dismissSelf)];

    if (!isMine)
    {
        UIButton *watchStoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, supplyDetailView.bottom+20, kMainScreenWidth-10, 35)];
        watchStoreBtn.backgroundColor = KColor;
        [watchStoreBtn addTarget:self action:@selector(watchStoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [watchStoreBtn setTitle:@"浏览商城" forState:UIControlStateNormal];
        watchStoreBtn.layer.cornerRadius = 2.5;
        [watchStoreBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [scrollView addSubview:watchStoreBtn];
        
        if (watchStoreBtn.bottom+20>kMainScreenHeight-62-kContactViewHeight+1)
        {
            scrollView.contentSize = CGSizeMake(kMainScreenWidth, watchStoreBtn.bottom+20);
        }
        else
        {
            scrollView.contentSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight-62-kContactViewHeight+1);
        }
        
        contactView = [[YHBContactView alloc] initWithFrame:CGRectMake(0, scrollView.bottom, kMainScreenWidth, kContactViewHeight)];
        contactView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:contactView];
    }
    
    UIView *navRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 22)];
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(navRightView.right-25, 0, 25, 21)];
    [shareBtn setImage:[UIImage imageNamed:@"detailShareImg"] forState:UIControlStateNormal];
    [shareBtn addTarget:self  action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [navRightView addSubview:shareBtn];
    
    if (isMine && needUpload != YES)
    {
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [editBtn setImage:[UIImage imageNamed:@"editImg"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        [navRightView addSubview:editBtn];
    }
    
    UIBarButtonItem *navRightBarItem = [[UIBarButtonItem alloc] initWithCustomView:navRightView];
    self.navigationItem.rightBarButtonItem = navRightBarItem;
    
    [self showFlower];
    
//    if (isModal==NO)
//    {
        [self.netManage getSupllyDetailWithItemid:itemId SuccessBlock:^(YHBSupplyDetailModel *aModel)
         {
             myModel = aModel;
             [supplyDetailView setDetailWithModel:aModel];
             if (needUpload==YES)
             {
                 
             }
             else
             {
                 [variousImageView setMyWebPhotoArray:aModel.pic canEdit:NO];
             }
             if (!isMine)
             {
                 NSArray *array = aModel.pic;
                 NSString *picUrl;
                 if (array.count>0)
                 {
                     YHBSupplyDetailPic *picmodel = [array objectAtIndex:0];
                     picUrl = picmodel.thumb;
                 }
                 else
                 {
                     picUrl=nil;
                 }
                 [contactView setPhoneNumber:aModel.mobile storeName:aModel.truename itemId:itemId isVip:aModel.vip imgUrl:picUrl Title:myModel.title andType:@"supply" userid:myModel.userid];
             }
             [self dismissFlower];
             if (needUpload && uploadPhotoArray.count>0)
             {
                 [variousImageView setPhotoArray:uploadPhotoArray];
                 uploadIndex = 0;
                 [self uploadImage];
                 [SVProgressHUD showWithStatus:@"上传图片中" cover:YES offsetY:kMainScreenHeight/2.0];
             }
         } andFailBlock:^(NSString *aStr) {
             [self dismissFlower];
//             [self.navigationController popViewControllerAnimated:YES];
             [SVProgressHUD showErrorWithStatus:aStr cover:YES offsetY:kMainScreenHeight/2.0];
         }];
//    }
    
//    if (needUpload && uploadPhotoArray.count>0)
//    {
//        [variousImageView setPhotoArray:uploadPhotoArray];
//        uploadIndex = 0;
//        [self uploadImage];
//        NSString *uploadPhototUrl = nil;
//        kYHBRequestUrl(@"upload.php", uploadPhototUrl);
//
//            for (int i=0; i<variousImageView.myPhotoArray.count; i++)
//            {
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[YHBUser sharedYHBUser].token,@"token",[NSString stringWithFormat:@"%d", i],@"order",@"album",@"action",[NSString stringWithFormat:@"%d",itemId],@"itemid",[itemDict objectForKey:@"moduleid"],@"moduleid", nil];
//                [NetManager uploadImg:[variousImageView.myPhotoArray objectAtIndex:i] parameters:dic uploadUrl:uploadPhototUrl uploadimgName:nil parameEncoding:AFJSONParameterEncoding progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//                } succ:^(NSDictionary *successDict) {
//                    MLOG(@"%@", successDict);
//                    NSString *result = [successDict objectForKey:@"result"];
//                    if ([result intValue] != 1)
//                    {
//                        MLOG(@"%@", [successDict objectForKey:@"error"]);
//                    }
//                    else
//                    {
//                        
//                    }
//                } failure:^(NSDictionary *failDict, NSError *error) {
//                    MLOG(@"%@", [failDict objectForKey:@"error"]);
//                }];
//            }
//    }
}

- (void)uploadImage
{
    if (uploadIndex<uploadPhotoArray.count)
    {
        id obj = [uploadPhotoArray objectAtIndex:uploadIndex];
        if (![obj isKindOfClass:[UIImage class]])
        {
            uploadIndex++;
            [self uploadImage];
        }
        else
        {
            [self upload];
        }
    }
}

- (void)upload
{
    NSString *uploadPhototUrl = nil;
    kYHBRequestUrl(@"upload.php", uploadPhototUrl);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[YHBUser sharedYHBUser].token,@"token",[NSString stringWithFormat:@"%d", uploadIndex],@"order",@"album",@"action",[NSString stringWithFormat:@"%d",itemId],@"itemid",[itemDict objectForKey:@"moduleid"],@"moduleid", nil];
    UIImage *uploadImage = (UIImage *)[uploadPhotoArray objectAtIndex:uploadIndex];
    [NetManager uploadImg:uploadImage parameters:dic uploadUrl:uploadPhototUrl uploadimgName:nil parameEncoding:AFJSONParameterEncoding progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    } succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        NSString *result = [successDict objectForKey:@"result"];
        if ([result intValue] != 1)
        {
            MLOG(@"%@", [successDict objectForKey:@"error"]);
        }
        else
        {
            
        }
        uploadIndex++;
        if (uploadIndex<uploadPhotoArray.count)
        {
            [self upload];
        }
        else
        {
            [SVProgressHUD dismiss];
        }
    } failure:^(NSDictionary *failDict, NSError *error) {
        MLOG(@"%@", [failDict objectForKey:@"error"]);
    }];

}


#pragma mark 分享
- (void)share
{
    MLOG(@"分享");
}

#pragma mark 编辑
- (void)edit
{
    YHBPublishSupplyViewController *vc = [[YHBPublishSupplyViewController alloc] initWithModel:myModel];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark 浏览商城
- (void)watchStoreBtn
{
    YHBShopMallViewController *shopMallVC = [[YHBShopMallViewController alloc] init];
    [self.navigationController pushViewController:shopMallVC animated:YES];
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

- (void)dismissSelf
{
    [self dismissFlower];
    if (isModal)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self dismissFlower];
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
