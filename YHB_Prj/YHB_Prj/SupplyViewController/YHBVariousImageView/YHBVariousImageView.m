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
#define interval 5
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
    [self.photoScrollView removeSubviews];
    int endWidth = 0;
    for (int i=0; i<self.myPhotoArray.count; i++)
    {
        UIButton *photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(interval+(interval+photoHeight)*i, interval, photoHeight, photoHeight)];
        [photoBtn setBackgroundImage:[self.myPhotoArray objectAtIndex:i] forState:UIControlStateNormal];
        [photoBtn addTarget:self action:@selector(touchPhoto:) forControlEvents:UIControlEventTouchUpInside];
        photoBtn.tag = 1000+i;
        [self.photoScrollView addSubview:photoBtn];
        endWidth = photoBtn.right+5;
    }
    self.photoScrollView.contentSize = CGSizeMake(endWidth, 110);
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
    
    CGRect rect = CGRectMake(0,0,100,100);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

//    self.photoImg = newImage;
//    self.imgView.image = newImage;
    
    //NSLog(@"imagew = %f,h = %f",self.photoImg.size.width,
    // self.photoImg.size.height);
    
    //    self.photoUrl = [[info objectForKey:@"UIImagePickerControllerMediaURL"] absoluteString];
    //    NSData *imageData = UIImageJPEGRepresentation(image, COMPRESSED_RATE);
    //    UIImage *compressedImage = [UIImage imageWithData:imageData];
    
    //    [HttpRequestManager uploadImage:compressedImage httpClient:self.httpClient delegate:self];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
