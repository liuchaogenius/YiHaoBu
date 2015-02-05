//
//  YHBVariousImageView.m
//  TestButton
//
//  Created by Johnny's on 14/11/17.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import "YHBVariousImageView.h"
#import "YHBAlbumViewController.h"
#import "UIViewAdditions.h"
#import "UIButton+WebCache.h"
#import "YHBSupplyDetailPic.h"
#define interval 10
#define photoHeight 100
#define plusTag 1000
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define kMainScreenWidth  [UIScreen mainScreen].bounds.size.width
@implementation YHBVariousImageView

- (void)setPhotoArray:(NSArray *)aPhotoArray
{
    self.myPhotoArray = [aPhotoArray mutableCopy];
    [self reloadPhotoScrollView];
}

- (void)setMyWebPhotoArray:(NSArray *)aPhotoArray
{
    self.webPhotoArray = aPhotoArray;
    [self reloadWebPhotoScrollView];
}

- (void)reloadWebPhotoScrollView
{
    float width = (320-photoHeight*3)/4.0;
    [self.photoScrollView removeSubviews];
    int endWidth = 0;
    if (self.webPhotoArray.count>0)
    {
        for (int i=0; i<self.webPhotoArray.count; i++)
        {
            UIButton *photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(width+(width+photoHeight)*i, interval, photoHeight, photoHeight)];
            YHBSupplyDetailPic *model = [self.webPhotoArray objectAtIndex:i];
            [photoBtn sd_setImageWithURL:[NSURL URLWithString:model.thumb] forState:UIControlStateNormal];
            [photoBtn addTarget:self action:@selector(touchPhoto:) forControlEvents:UIControlEventTouchUpInside];
            photoBtn.tag = 1000+i;
            [self.photoScrollView addSubview:photoBtn];
            endWidth = photoBtn.right+5;
        }
        self.photoScrollView.contentSize = CGSizeMake(endWidth, 110);
    }
    else
    {
        [self.photoScrollView addSubview:self.noPhotoView];
    }
}

- (instancetype)initWithFrame:(CGRect)frame andPhotoArray:(NSArray *)aPhotoArray
{
    if (self = [self initWithFrame:frame]) {
        _isAllowEdit = NO;
        _currentPhotoCount = (int)aPhotoArray.count;
        [self.myPhotoArray addObjectsFromArray:aPhotoArray];
        [self reloadPhotoScrollView];
    }
    return self;
}

- (instancetype)initEditWithFrame:(CGRect)frame
{
    if (self = [self initWithFrame:frame]) {
        _isAllowEdit = YES;
        [self.myPhotoArray addObject:self.plusImage];
        [self reloadPhotoScrollView];
    }
    return self;
}

- (instancetype)initEditWithFrame:(CGRect)frame andPhotoArray:(NSArray *)aPhotoArray
{
    if (self = [self initWithFrame:frame andPhotoArray:aPhotoArray]) {
        [self changeEdit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.photoScrollView = [[UIScrollView alloc]
                                initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 110)];
        _currentPhotoCount = 0;
        self.myPhotoArray = [NSMutableArray new];
        self.webPhotoArray = [NSMutableArray new];
        self.plusImage = [UIImage imageNamed:@"QSPlusBtn"];
        [self addSubview:self.photoScrollView];
    }
    return self;
}

- (UIAlertView *)deleteAlertView
{
    if (!_deleteAlertView) {
        _deleteAlertView = [[UIAlertView alloc] initWithTitle:@"要删除这张图片吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    return _deleteAlertView;
}


- (void)plusImageClicked
{
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照", @"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self];
}

#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        if (sourceType==UIImagePickerControllerSourceTypeCamera) {
            // 跳转到相机或相册页面
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = sourceType;
            imagePickerController.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:imagePickerController.sourceType];
            if (sourceType == UIImagePickerControllerSourceTypeCamera)
            {
                imagePickerController.allowsEditing = YES;
            }
            
            [[self viewController] presentViewController:imagePickerController animated:YES completion:^{}];
        }
        else
        {
            [[self viewController] presentViewController:[[UINavigationController alloc] initWithRootViewController:[[YHBAlbumViewController alloc] initWithBlock:^(NSArray *aArray) {
                [self addImageWithImageArray:aArray];
            } andPhotoCount:5-_currentPhotoCount]] animated:YES completion:^{
                
            }];
        }
    }
}

- (void)reloadPhotoScrollView
{
    float width = (320-photoHeight*3)/4.0;
    [self.photoScrollView removeSubviews];
    int endWidth = 0;
    if (self.myPhotoArray.count>0)
    {
        for (int i=0; i<self.myPhotoArray.count; i++)
        {
            UIButton *photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(width+(width+photoHeight)*i, interval, photoHeight, photoHeight)];
            [photoBtn setBackgroundImage:[self.myPhotoArray objectAtIndex:i] forState:UIControlStateNormal];
            [photoBtn addTarget:self action:@selector(touchPhoto:) forControlEvents:UIControlEventTouchUpInside];
            photoBtn.tag = 1000+i;
            [self.photoScrollView addSubview:photoBtn];
            endWidth = photoBtn.right+5;
        }
        self.photoScrollView.contentSize = CGSizeMake(endWidth, 110);
    }
    else
    {
        [self.photoScrollView addSubview:self.noPhotoView];
    }
}

- (UIView *)noPhotoView
{
    if (!_noPhotoView) {
        _noPhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-50, self.frame.size.height/2-10, 100, 20)];
        label.font = kFont15;
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"无相关图片";
        [_noPhotoView addSubview:label];
    }
    return _noPhotoView;
}

- (void)touchPhoto:(UIButton *)aBtn
{
    if (_isAllowEdit==YES)
    {
        if (aBtn.tag==plusTag&&_currentPhotoCount!=5)
        {
            [self plusImageClicked];
        }
        else
        {
            [self.deleteAlertView show];
            _deleteBtnIndex = aBtn.tag-plusTag;
        }
    }
#warning 增加查看详情是点击图片的代码
    else
    {
        int index = (int)aBtn.tag-plusTag;
        if (self.myPhotoArray.count>0)
        {
            MWPhoto *photo = nil;
            self.showPhotoArray = [NSMutableArray arrayWithCapacity:self.myPhotoArray.count];
            NSInteger imageNum = self.myPhotoArray.count;
            for (NSInteger i = 0; i < imageNum; i++) {
                photo = [MWPhoto photoWithImage:[self.myPhotoArray objectAtIndex:i]];
                self.showPhotoArray[i] = photo;
            }
        }
        if (self.webPhotoArray.count>0)
        {
            MWPhoto *photo = nil;
            self.showPhotoArray = [NSMutableArray arrayWithCapacity:self.webPhotoArray.count];
            NSInteger imageNum = self.webPhotoArray.count;
            for (NSInteger i = 0; i < imageNum; i++) {
                YHBSupplyDetailPic *model = [self.webPhotoArray objectAtIndex:i];
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:model.middle]];
                self.showPhotoArray[i] = photo;
            }
        }
        [self showPhotoBrownserWithIndex:index];
    }
}

- (void)changeEdit
{
    if (_isAllowEdit==NO) {
        _isAllowEdit=YES;
        if (_currentPhotoCount<5) {
            [self.myPhotoArray insertObject:self.plusImage atIndex:0];
            [self reloadPhotoScrollView];
        }
    }
    else
    {
        _isAllowEdit=NO;
        if (_currentPhotoCount!=5) {
            [self.myPhotoArray removeObjectAtIndex:0];
            [self reloadPhotoScrollView];
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [self.myPhotoArray removeObjectAtIndex:_deleteBtnIndex];
        if (_currentPhotoCount==5)
        {
            [self.myPhotoArray insertObject:self.plusImage atIndex:0];
        }
        [self reloadPhotoScrollView];
        _currentPhotoCount--;
    }
}

- (void)addImageWithImageArray:(NSArray *)aPhotoArray
{
    [self.myPhotoArray addObjectsFromArray:aPhotoArray];
    _currentPhotoCount += aPhotoArray.count;
    if (_currentPhotoCount==5) {
        [self.myPhotoArray removeObjectAtIndex:0];
    }
    [self reloadPhotoScrollView];
}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#warning 未测试照相增加图片
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //self.photoImg = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    CGRect rect = CGRectMake(0,0,100,100);
//    UIGraphicsBeginImageContext( rect.size );
//    [image drawInRect:rect];
////    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    NSMutableArray *array = [NSMutableArray new];
    [array addObject:image];
    [self addImageWithImageArray:array];
    
    UIImage *oriImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(oriImage, self,selectorToCall, NULL);
    
//    self.photoImg = newImage;
//    self.imgView.image = newImage;
    
    //NSLog(@"imagew = %f,h = %f",self.photoImg.size.width,
    // self.photoImg.size.height);
    
    //    self.photoUrl = [[info objectForKey:@"UIImagePickerControllerMediaURL"] absoluteString];
    //    NSData *imageData = UIImageJPEGRepresentation(image, COMPRESSED_RATE);
    //    UIImage *compressedImage = [UIImage imageWithData:imageData];
    
    //    [HttpRequestManager uploadImage:compressedImage httpClient:self.httpClient delegate:self];
    
}

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
        paramImage = nil;
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    [[self viewController].navigationController pushViewController:browser animated:NO];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.showPhotoArray.count;
}

- (id )photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.showPhotoArray.count)
        return [self.showPhotoArray objectAtIndex:index];
    return nil;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
