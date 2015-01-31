//
//  YHBProductDetailVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/1.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBProductDetailVC.h"
#import "YHBBannerVeiw.h"
#import "YHBProductManager.h"
#import "YHBUser.h"
#import "SVProgressHUD.h"
#import "YHBProductDetail.h"
#import "YHBSku.h"
#import "YHBExpress.h"
#import "YHBAlbum.h"
#import "YHBComment.h"
#import "UIImageView+WebCache.h"
#import "YHBPdtInfoView.h"
#import "YHBBuytoolBarView.h"
#import "YHBCommentCellView.h"
#import "YHBConnectStoreVeiw.h"
#import "YHBMoreCommentsVC.h"
#import "YHBStoreDetailViewController.h"
#import "YHBSelNumColorView.h"
#import "YHBPrivateManager.h"
#import "YHBShopCartManage.h"
#import "YHBOrderConfirmVC.h"
#import "YHBProductWebVC.h"
#import "MWPhotoBrowser.h"

#define kBlankHeight 15
#define kCCellHeight 35
#define kBannerHeight (kMainScreenWidth * 625/1080.0f)

@interface YHBProductDetailVC()<YHBBannerDelegate,YHBConStoreDelegate,YHBSelViewDelegate,UIScrollViewDelegate,MWPhotoBrowserDelegate>
{
    CGFloat _currentY;
    BOOL _isBuy; //yes代表点击了购买 no代表点击了购物车
    
    double _number;//购买的数量
    YHBSku *_selSku;//选择的色块
    
}
@property (assign, nonatomic) NSInteger productID;
@property (strong, nonatomic) YHBBannerVeiw *bannerView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) YHBProductManager *pManager;
@property (strong, nonatomic) YHBUser *user;
@property (strong, nonatomic) YHBProductDetail *productModel;
@property (strong, nonatomic) YHBPdtInfoView *infoView;
@property (strong, nonatomic) YHBBuytoolBarView *toolBarView;
@property (weak, nonatomic) UILabel *selectColorLabel;
@property (weak, nonatomic) UIView *selectCell;
@property (weak, nonatomic) UIView *commentHead;
@property (strong, nonatomic) YHBConnectStoreVeiw *conStoreView;
@property (strong, nonatomic) YHBSelNumColorView *selView;
@property (strong, nonatomic) UIVisualEffectView *visualEffectView;
@property (strong, nonatomic) YHBPrivateManager *privateManager;
@property (strong, nonatomic) YHBShopCartManage *shopCartManger;
@property (strong, nonatomic) YHBProductWebVC *webVc;
@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation YHBProductDetailVC

#pragma mark - getter and setter

- (YHBProductWebVC *)webVc
{
    if (!_webVc) {
        _webVc = [[YHBProductWebVC alloc] init];
    }
    return _webVc;
}

- (YHBShopCartManage *)shopCartManger
{
    if (!_shopCartManger) {
        _shopCartManger = [[YHBShopCartManage alloc] init];
    }
    return _shopCartManger;
}
- (YHBPrivateManager *)privateManager
{
    if (!_privateManager) {
        _privateManager = [[YHBPrivateManager alloc] init];
    }
    return _privateManager;
}

- (YHBUser *)user
{
    if (!_user) {
        _user = [YHBUser sharedYHBUser];
    }
    return _user;
}

- (YHBProductManager *)pManager
{
    if (!_pManager) {
        _pManager = [[YHBProductManager alloc] init];
    }
    return _pManager;
}

- (instancetype)initWithProductID:(NSInteger)productID
{
    self = [super init];
    if (self) {
        self.productID = productID;
        self.title = @"产品详情";
        _number = 1;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    //UI
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-44-ktoolHeight-20)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = kViewBackgroundColor;
    self.scrollView.contentSize = CGSizeMake(kMainScreenWidth, 700);
    [self.view addSubview:self.scrollView];
    
    self.bannerView = [[YHBBannerVeiw alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kBannerHeight)];
    self.bannerView.delegate = self;
    [self.scrollView addSubview:self.bannerView];
    
    self.infoView = [[YHBPdtInfoView alloc] init];
    self.infoView.top = self.bannerView.bottom;
    [self.infoView.privateButton addTarget:self action:@selector(touchPrivateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.infoView];
    
    self.toolBarView = [[YHBBuytoolBarView alloc] init];
    self.toolBarView.top = self.scrollView.bottom;
    [self.toolBarView.cartButton addTarget:self action:@selector(touchCartButton) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarView.buyButton addTarget:self action:@selector(touchBuyButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.toolBarView];
    
    [self creatSelectColorCell];
    [self creatProductDetailCell];
    [self creatCommentHead];
    
    self.conStoreView = [[YHBConnectStoreVeiw alloc] init];
    self.conStoreView.delegate = self;
    //网络请求
    __weak YHBProductDetailVC *weakself = self;
    [SVProgressHUD showWithStatus:@"拼命加载中..." cover:YES offsetY:kMainScreenHeight/2.0];
    [self.pManager getProductDetailInfoWithProductID:self.productID token:self.user.token Success:^(YHBProductDetail *model) {
        [SVProgressHUD dismiss];
        weakself.productModel = model;
        [weakself refreshAddView];
        [weakself.infoView setTitle:weakself.productModel.title price:weakself.productModel.price cate:weakself.productModel.catname favorite:(int)weakself.productModel.favorite];
        [weakself creatCommentCells];
        
        weakself.conStoreView.frame = CGRectMake(0, _currentY+=kBlankHeight, weakself.conStoreView.width, weakself.conStoreView.height);
        [weakself.conStoreView setUIWithTitle:weakself.productModel.company imageUrl:weakself.productModel.avatar desStar:weakself.productModel.star1 servStar:weakself.productModel.star2];
        weakself.scrollView.contentSize = CGSizeMake(kMainScreenWidth, self.conStoreView.bottom+20);
        
        [weakself.scrollView addSubview:weakself.conStoreView];
    } failure:^(NSString *error) {
        [SVProgressHUD dismissWithError:@"网络请求失败，请稍后再试！"];
    }];
}

- (void)creatSelectColorCell
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.infoView.bottom+kBlankHeight, kMainScreenWidth, kCCellHeight)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (view.height-kTitlefont)/2.0, kMainScreenWidth-20, kTitlefont)];
    textLabel.font = [UIFont systemFontOfSize:kTitlefont];
    textLabel.text = @"选择色块、型号";
    textLabel.textColor = [UIColor blackColor];
    [view addSubview:textLabel];
    self.selectCell = view;
    self.selectColorLabel = textLabel;
    UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSelectColorCell)];
    [view addGestureRecognizer:tp];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-25, view.height/2.0 - 9.5, 12, 19)];
    arrowImageView.image = [UIImage imageNamed:@"Arrow_right"];
    [arrowImageView setContentMode:UIViewContentModeScaleAspectFit];
    [view addSubview:arrowImageView];
    _currentY = view.bottom;
    [self.scrollView addSubview:view];
}

- (void)creatProductDetailCell
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _currentY+kBlankHeight, kMainScreenWidth, kCCellHeight)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (view.height-kTitlefont)/2.0, kMainScreenWidth-20, kTitlefont)];
    textLabel.font = [UIFont systemFontOfSize:kTitlefont];
    textLabel.text = @"查看产品详情";
    textLabel.textColor = [UIColor blackColor];
    [view addSubview:textLabel];
    UITapGestureRecognizer *tp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchProductDetailCell)];
    [view addGestureRecognizer:tp];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-25, view.height/2.0 - 9.5, 12, 19)];
    arrowImageView.image = [UIImage imageNamed:@"Arrow_right"];
    [arrowImageView setContentMode:UIViewContentModeScaleAspectFit];
    [view addSubview:arrowImageView];
    _currentY = view.bottom;
    [self.scrollView addSubview:view];
}

- (void)creatCommentHead
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _currentY+kBlankHeight, kMainScreenWidth, kCCellHeight)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (view.height-kTitlefont)/2.0, kMainScreenWidth-20, kTitlefont)];
    textLabel.font = [UIFont systemFontOfSize:kTitlefont];
    textLabel.text = @"产品评价";
    textLabel.textColor = [UIColor blackColor];
    [view addSubview:textLabel];
    [self.scrollView addSubview:view];
    _commentHead = view;
    _currentY = view.bottom;
}

- (void)creatCommentCells
{
    if(self.productModel.comment.count){
        YHBComment *comment;
        for (int i=0; i < self.productModel.comment.count; i++) {
            comment = self.productModel.comment[i];
            YHBCommentCellView *cellView = [[YHBCommentCellView alloc] init];
            cellView.top = _currentY + 1;
            [cellView setUIWithName:comment.truename image:comment.avatar comment:comment.comment date:comment.adddate];
            [self.scrollView addSubview:cellView];
            _currentY = cellView.bottom;
        }
        if (self.productModel.comment.count >= 2) {
            UIView *moreVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, _currentY+1, kMainScreenWidth, 30)];
            moreVeiw.backgroundColor = [UIColor whiteColor];
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake((kMainScreenWidth-100)/2.0, (moreVeiw.height-13)/2.0, 100, 13)];
            textLabel.textColor = [UIColor blackColor];
            textLabel.font = kFont12;
            textLabel.text = @"查看更多评价";
            [moreVeiw addSubview:textLabel];
            [self.scrollView addSubview:moreVeiw];
            UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchMoreComment)];
            [moreVeiw addGestureRecognizer:gr];
            _currentY = moreVeiw.bottom;
        }
    }else{
        YHBCommentCellView *cellView = [[YHBCommentCellView alloc] init];
        cellView.top = _currentY + 1;
        [cellView isNoComment];
        [self.scrollView addSubview:cellView];
        _currentY = cellView.bottom;
    }
}

//载入banners的网络数据
- (void)refreshAddView
{
    
    NSInteger imageNum = self.productModel.album.count;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:imageNum];
    
    
    for (NSInteger i = 0; i < imageNum; i++) {
        YHBAlbum *album = self.productModel.album[i];
        array[i] = album.middle;
    }
    self.bannerView.isNeedCycle = NO;
    [self.bannerView resetUIWithUrlStrArray:[NSArray arrayWithArray:array]];
 
}
#pragma mark - Action
#pragma mark 收藏
- (void)touchPrivateBtn : (UIButton *)sender
{
    if ([self userLoginConfirm]) {
        sender.selected = !sender.selected;
        [self.privateManager privateOrDisPrivateWithItemID:[NSString stringWithFormat:@"%ld",(long)self.productID] privateType:private_mall token:[YHBUser sharedYHBUser].token ? :@"" Success:^{
            
        } failure:^(NSString *error) {
            [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
            sender.selected = !sender.selected;
        }];
    }
}

#pragma mark 点击购物车
- (void)touchCartButton
{
    _isBuy = NO;
    if ([self infoCheck]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:self.productID],@"itemid",[NSString stringWithFormat:@"%lf",_number],@"number",[NSNumber numberWithInt:(int)_selSku.colorid],@"skuid", nil];
        [self.shopCartManger changeShopCartWithArray:@[dic] andSuccBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"添加购物车成功！" cover:YES offsetY:0];
        } failBlock:^(NSString *aStr){
            [SVProgressHUD showErrorWithStatus:@"添加购物车失败，请重新尝试！" cover:YES offsetY:0];
        }];
    }
}

#pragma mark 点击购买按钮
- (void)touchBuyButton
{
    _isBuy = YES;
    if ([self infoCheck]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:self.productID],@"itemid",[NSString stringWithFormat:@"%lf",_number],@"number",[NSNumber numberWithInt:(int)_selSku.colorid],@"skuid", nil];
        YHBOrderConfirmVC *vc = [[YHBOrderConfirmVC alloc] initWithSource:@"mall" requestArray:@[dic]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 信息完整性检查
- (BOOL)infoCheck
{
    if ([YHBUser sharedYHBUser].isLogin) {
        if (_selSku) {
            return YES;
        }else{
            [SVProgressHUD showErrorWithStatus:@"你还没有选择色块/型号哦" cover:YES offsetY:0];
            return NO;
        }
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginForUserMessage object:[NSNumber numberWithBool:NO]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessItem) name:kLoginSuccessMessae object:nil];
        return NO;
    }
}
- (void)loginSuccessItem
{
    _isBuy ? [self touchBuyButton] : [self touchCartButton];
}

- (BOOL)userLoginConfirm
{
    if ([YHBUser sharedYHBUser].isLogin) {
        return YES;
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginForUserMessage object:[NSNumber numberWithBool:NO]];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessItem) name:kLoginSuccessMessae object:nil];
        return NO;
    }
}

#pragma mark 点击选择色块
- (void)touchSelectColorCell
{
    if (self.productModel) {
        if (!_selView) {
            _selView = [[YHBSelNumColorView alloc] initWithProductModel:self.productModel];
            _selView.delegate = self;
        }
        _selView.top = kMainScreenHeight;
        [_selView registerForKeyboradNotifications];
        /*
        UIView *dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        dimView.backgroundColor = [UIColor clearColor];
        dimView.alpha = 0.6;
        //[[UIApplication sharedApplication].keyWindow addSubview:dimView];
        */
        if (!_visualEffectView) {
            UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            
            _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            
            _visualEffectView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-64);
        }
        self.visualEffectView.alpha = 1.0f;
        [self.view addSubview:_visualEffectView];
        [self.view addSubview:_selView];
        //[[UIApplication sharedApplication].keyWindow addSubview:_visualEffectView];
        
        //[[UIApplication sharedApplication].keyWindow addSubview:_selView];
        
        [UIView animateWithDuration:0.6f animations:^{
            _selView.bottom =_selView.bottom- _selView.height-64;
        } completion:^(BOOL finished) {
            
        }];
        
        
        /*
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:vc animated:YES completion:^{
        }];*/
    }
    
}

#pragma mark selView dismiss
- (void)selViewShouldDismissWithSelNum:(double)num andSelSku:(YHBSku *)sku
{
    _number = num;
    _selSku = sku;
    [UIView animateWithDuration:0.2f animations:^{
        self.selView.top = kMainScreenHeight;
    } completion:^(BOOL finished) {
        [self.selView removeFromSuperview];
        [UIView animateWithDuration:0.2f animations:^{
        self.visualEffectView.alpha = 0.1;
        } completion:^(BOOL finished) {
            [self.visualEffectView removeFromSuperview];
        }];
    }];
}

- (void)selViewShouldPushViewController:(UIViewController *)vc
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
}

#pragma mark 点击查看产品详情
- (void)touchProductDetailCell
{
    if (self.productModel.content.length) {
        [self.navigationController pushViewController:self.webVc animated:YES];
        [self.webVc sethtmlStr:self.productModel.content];
    }
}

#pragma mark 点击更多评论
- (void)touchMoreComment
{
    YHBMoreCommentsVC *moreVC = [[YHBMoreCommentsVC alloc] initWithItemID:self.productID];
    [self.navigationController pushViewController:moreVC animated:YES];
}
#pragma mark 点击查询店铺详情
- (void)touchShopDetailCell
{
    YHBStoreDetailViewController *vc = [[YHBStoreDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 点击联系卖家
- (void)touchConnectStoreBtn
{
    
}

#pragma mark 点击head的Banner
- (void)touchBannerWithNum:(NSInteger)num;
{
    
    if (!self.photos.count) {
        MWPhoto *photo = nil;
        self.photos = [NSMutableArray arrayWithCapacity:5];
        NSInteger imageNum = self.productModel.album.count;
        for (NSInteger i = 0; i < imageNum; i++) {
            YHBAlbum *album = self.productModel.album[i];
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:album.large?:@""]];
            self.photos[i] = photo;
        }
    }
    [self showPhotoBrownserWithIndex:num];
}

#pragma mark - 照片浏览
- (void)showPhotoBrownserWithIndex:(NSInteger)num
{
    BOOL displayActionButton = NO;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;

    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;//分享按钮,默认是
    browser.displayNavArrows = displayNavArrows;//左右分页切换,默认否
    browser.displaySelectionButtons = displaySelectionButtons;//是否显示选择按钮在图片上,默认否
    browser.alwaysShowControls = displaySelectionButtons;//控制条件控件 是否显示,默认否
    browser.zoomPhotosToFill = NO;//是否全屏,默认是
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;//是否全屏
#endif
    browser.enableGrid = enableGrid;//是否允许用网格查看所有图片,默认是
    browser.startOnGrid = startOnGrid;//是否第一张,默认否
    browser.enableSwipeToDismiss = YES;
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:num+1];
    //browser.photoTitles = @[@"000",@"111",@"222",@"333"];//标题
    
    //   [self presentViewController:browser animated:YES completion:nil];
    [self.navigationController pushViewController:browser animated:NO];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id )photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

#pragma mark banner delegat
- (void)didScrollOverRight
{
    if (self.productModel.content.length) {
        [self.navigationController pushViewController:self.webVc animated:YES];
        [self.webVc sethtmlStr:self.productModel.content];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
