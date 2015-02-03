//
//  YHBComCertificVieController.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/25.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBComCertificVieController.h"
#import "CCEditTextView.h"
#import "SVProgressHUD.h"
#import "NetManager.h"
#import "YHBUser.h"
#define kCellHeight 40
typedef enum : NSUInteger{
    Pick_Cert = 100,
    Pick_ID
}Pick_ImagTag;

@interface YHBComCertificVieController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITextField *_comTextField;
    UITextField *_nameTextField;
    UITextField *_numTextFile;
    UIImage *_certImage;
    UIImage *_identiImage;
    
    UIImageView *_certImageView;
    UIImageView *_identiImageView;
    Pick_ImagTag _pickTag;
    UIButton *_submitButton;
    
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *bigTitleLabel;
@property (strong, nonatomic) UIView *cellsView;
@property (strong, nonatomic) UILabel *tipsLabel;

@end

@implementation YHBComCertificVieController

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-20-44)];
        _scrollView.backgroundColor = kViewBackgroundColor;
        _scrollView.contentSize = CGSizeMake(kMainScreenWidth, 550);
    }
    return _scrollView;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.cellsView.bottom+20, kMainScreenWidth-20, 70)];
        _tipsLabel.textColor = [UIColor lightGrayColor];
        _tipsLabel.font = kFont12;
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.backgroundColor = [UIColor clearColor];
        _tipsLabel.text = @"1、企业认证通过后店铺名称将自动更改为所提交公司名称；\n2、认证成功后将不能修改，请务必确定填写准确；\n3、您的信息我们将严格为您保密；";
    }
    return _tipsLabel;
}

- (UILabel *)bigTitleLabel
{
    if (!_bigTitleLabel) {
        _bigTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, kMainScreenWidth-20, 20)];
        _bigTitleLabel.text = @"通过商家认证您可以获得更多的服务";
        _bigTitleLabel.backgroundColor = [UIColor clearColor];
        _bigTitleLabel.textColor = KColor;
        _bigTitleLabel.font = kFont18;
        _bigTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bigTitleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickTag = 0;
    self.title = @"商家认证";
    self.view.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bigTitleLabel];
    [self.scrollView addSubview:[self customButtonWithTitle:@"商家认证" andY:self.bigTitleLabel.bottom+20.0]];
    [self creatCellsView];
    [self.scrollView addSubview:self.cellsView];
    [self.scrollView addSubview:self.tipsLabel];
    UIButton *submitBtn = [self customButtonWithTitle:@"提交申请" andY:self.tipsLabel.bottom+20];
    [submitBtn addTarget:self action:@selector(touchSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    _submitButton = submitBtn;
    [self.scrollView addSubview:submitBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void)creatCellsView
{
    self.cellsView = [[UIView alloc] initWithFrame:CGRectMake(10, self.bigTitleLabel.bottom+20+kCellHeight, kMainScreenWidth-20, kCellHeight*5)];
    self.cellsView.backgroundColor = [UIColor whiteColor];

    UILabel *comTitle = [self customTitleLabelWithY:0 Title:@"公司名称："];
    [_cellsView addSubview:comTitle];
    
    _comTextField = [[UITextField alloc] initWithFrame:CGRectMake(comTitle.right, 0, kMainScreenWidth-20-comTitle.right, kCellHeight)];
    _comTextField.font = kFont14;
    _comTextField.delegate = self;
    _comTextField.placeholder = @"名称";
    [_cellsView addSubview:_comTextField];
    [_cellsView addSubview:[self lineWithY:_comTextField.bottom]];
    
    UILabel *nameTitle = [self customTitleLabelWithY:comTitle.bottom+1 Title:@"法人姓名："];
    [_cellsView addSubview:nameTitle];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTitle.right, nameTitle.top, kMainScreenWidth-20-nameTitle.right, kCellHeight)];
    _nameTextField.font = kFont14;
    _nameTextField.delegate = self;
    _nameTextField.placeholder = @"你的真实姓名";
    [_cellsView addSubview:_nameTextField];
    [_cellsView addSubview:[self lineWithY:nameTitle.bottom]];
    
    UILabel *numTitle = [self customTitleLabelWithY:nameTitle.bottom+1 Title:@"营业执照号码："];
    [_cellsView addSubview:numTitle];
    
    _numTextFile = [[UITextField alloc] initWithFrame:CGRectMake(numTitle.right, numTitle.top, kMainScreenWidth-20-numTitle.right, kCellHeight)];
    _numTextFile.font = kFont14;
    _numTextFile.delegate = self;
    _numTextFile.placeholder = @"填写营业执照号码";
    [_cellsView addSubview:_numTextFile];
    [_cellsView addSubview:[self lineWithY:numTitle.bottom]];
    
    UILabel *certTitle = [self customTitleLabelWithY:numTitle.bottom+1 Title:@"营业执照："];
    [_cellsView addSubview:certTitle];
    
    _certImageView = [[UIImageView alloc] initWithFrame:CGRectMake(certTitle.right, 10+certTitle.top, 20, 20)];
    [_certImageView setContentMode:UIViewContentModeScaleAspectFit];
    _certImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"photoIco"]];
    [_cellsView addSubview:_certImageView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(certTitle.right, certTitle.top, _cellsView.right-certTitle.right, kCellHeight);
    btn.tag = Pick_Cert;
    [btn addTarget:self action:@selector(touchPhotoCell:) forControlEvents:UIControlEventTouchUpInside];
    [_cellsView addSubview:btn];
    
    
    UILabel *idTitle = [self customTitleLabelWithY:certTitle.bottom+1 Title:@"身份证照片："];
    [_cellsView addSubview:idTitle];
    
    _identiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(idTitle.right, 10+idTitle.top, 20, 20)];
    [_identiImageView setContentMode:UIViewContentModeScaleAspectFit];
    _identiImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"photoIco"]];
    [_cellsView addSubview:_identiImageView];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(certTitle.right, idTitle.top, _cellsView.right-idTitle.right, kCellHeight);
    btn2.tag = Pick_ID;
    [btn2 addTarget:self action:@selector(touchPhotoCell:) forControlEvents:UIControlEventTouchUpInside];
    [_cellsView addSubview:btn2];

}

#pragma mark - Action
- (void)touchPhotoCell : (UIButton *)sender
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
    _pickTag = sender.tag;
    [sheet showInView:self.view];
}

- (void)touchSubmitBtn
{
    if ([self infoCheck]) {
        //上传
        [self updateInfo];
    }
}

- (void)updateInfo
{
    NSString *uploadUrl = nil;
    kYHBRequestUrl(@"postValidate.php", uploadUrl);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[YHBUser sharedYHBUser].token,"token",_comTextField.text,@"title",_nameTextField.text,@"truename",_numTextFile.text,@"idcard", nil];
    _submitButton.enabled = NO;
    
    [SVProgressHUD showWithStatus:@"上传信息中，请耐心等待" cover:YES offsetY:0];
    [NetManager uploadArryImg:@[_certImage,_identiImage] parameters:dic uploadUrl:uploadUrl uploadimgName:@"thumb" parameEncoding:AFJSONParameterEncoding progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    } succ:^(NSDictionary *successDict) {
        [SVProgressHUD dismissWithSuccess:@"上传成功，请耐心等待审核"];
    } failure:^(NSDictionary *failDict, NSError *error) {
        [SVProgressHUD dismissWithError:@"上传失败，请重试"];
        _submitButton.enabled = YES;
    }];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[CCEditTextView sharedView] showEditTextViewWithTitle:[self titleWithTextFiled:textField] textfieldText:textField.text comfirmBlock:^(NSString *text) {
        textField.text = text;
    } cancelBlock:^{
        
    }];
    return NO;
}

- (BOOL)infoCheck
{
    if (_comTextField.text.length && _nameTextField.text.length && _numTextFile.text.length) {
        if (_identiImage) {
            if (_identiImage) {
                return YES;
            }else [SVProgressHUD showErrorWithStatus:@"请选择身份证照片" cover:YES offsetY:0];
        }else [SVProgressHUD showErrorWithStatus:@"请选择营业执照" cover:YES offsetY:0];
    }else [SVProgressHUD showErrorWithStatus:@"请输入未填写的信息" cover:YES offsetY:0];
    return NO;
}

- (NSString *)titleWithTextFiled:(UITextField *)textField
{
    if (textField == _comTextField) {
        return @"公司名称";
    }else if (textField == _nameTextField){
        return @"法人姓名";
    }else if (textField == _numTextFile){
        return @"营业执照号码";
    }else return @"";
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
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//UIImagePickerControllerSourceTypeSavedPhotosAlbum;//
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        imagePickerController.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:imagePickerController.sourceType];
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}


#pragma mark - image picker delegte

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
        paramImage = nil;
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage * oriImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    // 保存图片到相册中
    SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(oriImage, self,selectorToCall, NULL);
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //self.photoImg = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    CGRect rect = CGRectMake(0, 0, 1024, 1024);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _pickTag == Pick_Cert ? (_certImage = newImage) : (_identiImage = newImage);
    
    //缩略图
    CGRect srect = CGRectMake(0, 0, 30, 30);
    UIGraphicsBeginImageContext( srect.size );
    [image drawInRect:srect];
    UIImage *sImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _pickTag == Pick_Cert ? (_certImageView.image = sImage) : (_identiImageView.image = sImage);
    
    //self.photoImg = newImage;
    //self.imgView.image = newImage;
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIButton *)customButtonWithTitle:(NSString *)title andY:(CGFloat)y
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:KColor];
    [btn setTintColor:[UIColor whiteColor]];
    btn.layer.cornerRadius = 4.0;
    btn.titleLabel.font = kFont18;
    btn.frame = CGRectMake(10, y, kMainScreenWidth-20, kCellHeight);
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

- (UILabel *)customTitleLabelWithY:(CGFloat)y Title:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, 100, kCellHeight)];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    label.font = kFont14;
    label.textColor = [UIColor blackColor];
    
    return label;
}

- (UIView *)lineWithY:(CGFloat)y
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y, kMainScreenWidth-20, 0.7)];
    line.backgroundColor = kLineColor;
    
    return line;
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
