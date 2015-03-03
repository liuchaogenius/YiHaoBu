//
//  YHBShopInfoViewController.m
//  YHB_Prj
//
//  Created by yato_kami on 14/11/17.
//  Copyright (c) 2014年 striveliu. All rights reserved.
//

#import "YHBShopInfoViewController.h"
#import "CCEditTextView.h"
#import "YHBUser.h"
#import "UIImageView+WebCache.h"
#import "NetManager.h"
#import "YHBUserManager.h"
#import "YHBAddressManager.h"
#import "SVProgressHUD.h"
//#import "YHBAddressModel.h"
#import "YHBAreaModel.h"
#import "CategoryViewController.h"
#import "YHBCity.h"
#import "YHBCatData.h"
#import "LSNavigationController.h"

#define kHeadHeight 135
#define kImageWith 50
#define kTitleFont 15
#define kBlackHeight 15
#define isTest 1
#define kCellHeight 40
#define kButtonTag_Cancel 10

typedef enum : NSUInteger {
    Picker_Head = 10,
    Picker_Banner,
} Picker_type;

enum TextTag
{
    TextField_Name = 0,
    TextField_company,
    TextField_mobile,
    TextField_Attention,
    TextField_area,
    TextField_Address,
    TextView_buisness,
    TextView_introduce
};
@interface YHBShopInfoViewController ()<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_tipTitleArray;
    Picker_type _pickType;
    BOOL _isBannerChanged;
    BOOL _isUserImageChanged;
    
    UIButton *_cancelBtn;
    
    NSInteger _selProvince;
    NSInteger _selCity;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UIImageView *bannerImageView;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UIView *cellsView;
@property (strong ,nonatomic) UIView *headBackView;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIView *userHeadCell;
@property (strong, nonatomic) UIView *toolBarView;

@property (strong, nonatomic) NSMutableArray *textFieldArray;
@property (strong, nonatomic) NSMutableArray *arrowsArray;
@property (weak, nonatomic) UITextView *mProductTextView;//主营产品
@property (weak, nonatomic) UITextView *mIntroduceTextView;//介绍
@property (strong, nonatomic) YHBUserManager *userManager;

@property (strong, nonatomic) YHBAddressManager *addManager;
@property (strong, nonatomic) NSMutableArray *areaArray;
//@property (strong, nonatomic) YHBAddressModel *addModel;
@property (strong, nonatomic) UIPickerView *areaPicker;
@property (strong, nonatomic) UIView *clearView;
@property (strong, nonatomic) UIButton *tool;

@property (strong, nonatomic) NSString *cateID;

@end

@implementation YHBShopInfoViewController

- (NSMutableArray *)arrowsArray
{
    if (!_arrowsArray) {
        _arrowsArray = [NSMutableArray arrayWithCapacity:6];
    }
    return _arrowsArray;
}

- (YHBAddressManager *)addManager
{
    if (!_addManager) {
        _addManager = [[YHBAddressManager alloc] init];
    }
    return _addManager;
}

- (UIView *)clearView
{
    if (!_clearView) {
        _clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth,kMainScreenHeight)];
        _clearView.backgroundColor = [UIColor clearColor];
    }
    return _clearView;
}

- (UIPickerView *)areaPicker
{
    if (!_areaPicker) {
        _areaPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 200)];
        _areaPicker.backgroundColor = [UIColor whiteColor];
        _areaPicker.dataSource =self;
        _areaPicker.delegate = self;
        _areaPicker.showsSelectionIndicator = YES;
    }
    return _areaPicker;
}


- (YHBUserManager *)userManager
{
    if (!_userManager) {
        _userManager = [[YHBUserManager alloc] init];
    }
    return _userManager;
}

- (UIView *)headBackView
{
    if (!_headBackView) {
        _headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kHeadHeight)];
        
        _bannerImageView = [[UIImageView alloc] initWithFrame:_headBackView.frame];
        _bannerImageView.backgroundColor = [UIColor lightGrayColor];
        [_bannerImageView setContentMode:UIViewContentModeScaleAspectFill];
        _bannerImageView.clipsToBounds = YES;
        [_headBackView addSubview:_bannerImageView];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake((kMainScreenWidth-kImageWith)/2.0, (kHeadHeight-kImageWith)/2.0, kImageWith, kImageWith);
        [addBtn setBackgroundImage:[UIImage imageNamed:@"addHead"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(touchChangeBannerBtn) forControlEvents:UIControlEventTouchUpInside];
        [_headBackView addSubview:addBtn];
    }
    return _headBackView;
}

- (UIView *)userHeadCell
{
    if (!_userHeadCell) {
        _userHeadCell = [[UIView alloc] initWithFrame:CGRectMake(0, self.headBackView.bottom+kBlackHeight, kMainScreenWidth, kImageWith+10)];
        _userHeadCell.backgroundColor = [UIColor whiteColor];
        
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_userHeadCell.height-kImageWith)/2.0, kImageWith, kImageWith)];
        //_userImageView.backgroundColor = [UIColor whiteColor];
        _userImageView.layer.borderColor = [kLineColor CGColor];
        _userImageView.layer.borderWidth = 0.5;
        _userImageView.layer.cornerRadius = _userImageView.width/2.0;
        _userImageView.clipsToBounds = YES;
        [_userHeadCell addSubview:_userImageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(_userImageView.right+10, 0, 100, _userHeadCell.height)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:kTitleFont];
        title.textColor = [UIColor lightGrayColor];
        title.text = @"修改头像";
        [_userHeadCell addSubview:title];
        
        [_userHeadCell addSubview:[self getArrowImageViewWithFrame:CGRectMake(kMainScreenWidth-10-15, (_userHeadCell.height-20)/2.0, 15, 20)]];
        
        UITapGestureRecognizer *rz = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchChangeUserHeadCell)];
        [_userHeadCell addGestureRecognizer:rz];
    }
    return _userHeadCell;
}

- (UIView *)cellsView
{
    if (!_cellsView) {
        _cellsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.userHeadCell.bottom + kBlackHeight, kMainScreenWidth, 0)];
        _cellsView.backgroundColor = [UIColor whiteColor];
        _cellsView.layer.borderColor = [kLineColor CGColor];
        _cellsView.layer.borderWidth = 0.5f;
        NSArray *titleArray = @[@"姓       名：",@"公司名称：",@"联系电话：",@"我的关注：",@"地       区：",@"地       址：",@"主营产品：",@"店铺简介："];
        CGFloat currenty = 0;
        for(int i = 0 ;i < titleArray.count; i++)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, currenty, kMainScreenWidth, 0.7)];
            line.backgroundColor = kLineColor;
            [_cellsView addSubview:line];
            
            UIView *cellView = [self customCellViewWithframe:CGRectMake(0, currenty, kMainScreenWidth, i < 6 ? kCellHeight : 2.5*kCellHeight) title:titleArray[i] tag:i];
            [_cellsView addSubview:cellView];
            currenty = cellView.bottom;
        }
        _cellsView.height = currenty;
        
    }
    return _cellsView;
}

- (UIView *)customCellViewWithframe:(CGRect)frame title:(NSString *)title tag:(NSInteger)i
{
    UIView *cellView = [[UIView alloc] initWithFrame:frame];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (kCellHeight-kTitleFont)/2.0f, kTitleFont*5.2, kTitleFont)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = title;
    //titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
    if (i < 6) {
         UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.right+2, 0, kMainScreenWidth-titleLabel.right-2, kCellHeight)];
        textField.tag = i;
        //textField.text = [NSString stringWithFormat:@"%d",i];
        textField.font = [UIFont systemFontOfSize:kTitleFont];
        [textField setBorderStyle:UITextBorderStyleNone];
        textField.textColor = [UIColor lightGrayColor];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textField setTextAlignment:NSTextAlignmentLeft];
        textField.delegate = self;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [cellView addSubview:textField];
        self.textFieldArray[i] = textField;
        
        UIView *arrow = [self getArrowImageViewWithFrame:CGRectMake(kMainScreenWidth-10-15, (cellView.height-15)/2.0, 10, 15)];
        self.arrowsArray[i] = arrow;
        [cellView addSubview:arrow];
        
    }else{
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom+5, kMainScreenWidth-titleLabel.left*2, cellView.height-titleLabel.bottom-10)];
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = [UIFont systemFontOfSize:kTitleFont];
        textView.textColor = [UIColor lightGrayColor];
        textView.delegate = self;
        textView.tag = i;
        //textView.backgroundColor = [UIColor blackColor];
        //textView.text = @"羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛，羊毛";
        [textView setTextAlignment:NSTextAlignmentLeft];
        [cellView addSubview:textView];
        i == TextView_buisness ? (self.mProductTextView = textView) : (self.mIntroduceTextView = textView);
        
    }
    
    return cellView;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.backgroundColor = KColor;
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setFrame:CGRectMake(20, (50-40)/2.0, kMainScreenWidth-40.0, 40)];
        _confirmButton.layer.cornerRadius = 5.0f;
        [_confirmButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(touchConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIView *)toolBarView
{
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-64-50, kMainScreenWidth, 50)];
        _toolBarView.backgroundColor = [UIColor whiteColor];
        _toolBarView.layer.borderColor = [kLineColor CGColor];
        _toolBarView.layer.borderWidth = 1.0;
        [_toolBarView addSubview:self.confirmButton];
    }
    return _toolBarView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isBannerChanged = NO;
    _isUserImageChanged = NO;
    _selCity = 0 ;
    _selProvince = 0;
    self.view.backgroundColor = kViewBackgroundColor;
    
    [self settitleLabel:@"店铺详情"];
    _tipTitleArray = @[@"编辑姓名",@"编辑名称",@"编辑联系电话",@"编辑我的关注",@"编辑地区",@"编辑地址"];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44-49-20)];
    self.scrollView.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.toolBarView];
    
    _textFieldArray = [NSMutableArray arrayWithCapacity:3];
    
    //ui
    [self.scrollView addSubview:self.headBackView];
    [self.scrollView addSubview:self.userHeadCell];
    [self.scrollView addSubview:self.cellsView];
    //[self.scrollView addSubview:self.confirmButton];
    
    [self.scrollView setContentSize:CGSizeMake(kMainScreenWidth, self.cellsView.bottom+20)];

    [self setData];
    [self loadUserPhoto];
}

- (void)setData
{
    YHBUser *user =[YHBUser sharedYHBUser];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.avatar] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    UITextField *tf;
    tf = self.textFieldArray[TextField_Name];
    tf.text = user.userInfo.truename;
    if (1 == (int)user.userInfo.vtruename) {
        ((UIView *)(self.arrowsArray[TextField_Name])).hidden = YES;
        tf.enabled = NO;
    }
    MLOG(@"%@",user.userInfo.catname);
    tf = self.textFieldArray[TextField_Attention];
    tf.text = [user.userInfo.catname isKindOfClass:[NSString class]]?user.userInfo.catname:@"";

    tf = self.textFieldArray[TextField_Address];
    tf.text = user.userInfo.address;
    
    tf = self.textFieldArray[TextField_mobile];
    tf.text = user.userInfo.telephone;
    
    tf = self.textFieldArray[TextField_company];
    tf.text = user.userInfo.company;
    if (1 == (int)user.userInfo.vcompany) {
        ((UIView *)(self.arrowsArray[TextField_company])).hidden = YES;
        tf.enabled = NO;
    }
    
    tf = self.textFieldArray[TextField_area];
    tf.text = user.userInfo.area;
    
    self.cateID = [YHBUser sharedYHBUser].userInfo.catid;
    
    self.mProductTextView.text = user.userInfo.business;
    self.mIntroduceTextView.text = user.userInfo.introduce;
}

#pragma mark - action
#pragma mark - 点击保存按钮
- (void)touchConfirmButton
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:9];
    [dic setObject:[YHBUser sharedYHBUser].token forKey:@"token"];
    if (((UITextField *)self.textFieldArray[TextField_Name]).text.length) {
        [dic setObject:((UITextField *)self.textFieldArray[TextField_Name]).text forKey:@"truename"];
    }
    if (((UITextField *)self.textFieldArray[TextField_company]).text.length) {
        [dic setObject:((UITextField *)self.textFieldArray[TextField_company]).text forKey:@"company"];
    }
    if (((UITextField *)self.textFieldArray[TextField_mobile]).text.length) {
        [dic setObject:((UITextField *)self.textFieldArray[TextField_mobile]).text forKey:@"telephone"];
    }
    if (self.mProductTextView.text.length) {
        [dic setObject:self.mProductTextView.text forKey:@"business"];
    }
    if (((UITextField *)self.textFieldArray[TextField_Address]).text.length) {
        [dic setObject:((UITextField *)self.textFieldArray[TextField_Address]).text forKey:@"address"];
    }
    if (self.mIntroduceTextView.text.length) {
        [dic setObject:self.mIntroduceTextView.text?:@"" forKey:@"introduce"];
    }
    if (self.cateID.length) {
        [dic setObject:self.cateID forKey:@"catid"];
    }
    if (_selCity && _selProvince) {
        YHBAreaModel *area = self.areaArray[_selProvince-1];
        YHBCity *city = area.city[_selCity -1];
        [dic setObject:[NSString stringWithFormat:@"%d",(int)city.areaid]forKey:@"areaid"];
    }
    //
    //[dic setObject:((UITextField *)self.textFieldArray[TextField_Name]).text?:@"" forKey:@"truename"];
    MLOG(@"%@",dic);
    [self.userManager editUserInfoWithInfoDic:dic withSuccess:^{
        [SVProgressHUD showSuccessWithStatus:@"修改成功!" cover:YES offsetY:0];
        [YHBUser sharedYHBUser].statusIsChanged = YES;
    } failure:^(int result, NSString *errorString) {
        [SVProgressHUD showErrorWithStatus:errorString cover:YES offsetY:0];
    }];
    
}

#pragma mark 点击修改头像
- (void)touchChangeUserHeadCell
{
    _pickType = Picker_Head;
    [self showActionSheet];
}

#pragma mark 点击修改背景图
- (void)touchChangeBannerBtn
{
    _pickType = Picker_Banner;
    
    [self showActionSheet];
    
}

//upload image
- (void)uploadImgWithAction:(Picker_type)type Image:(UIImage *)image
{
    NSString *uploadPhototUrl = nil;
    kYHBRequestUrl(@"upload.php", uploadPhototUrl);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[YHBUser sharedYHBUser].token,@"token",(type == Picker_Banner ? @"banner":@"avatar"),@"action", nil];
    
    [SVProgressHUD showWithStatus:@"上传中..." cover:YES offsetY:0];
    [NetManager uploadImg:image parameters:dic uploadUrl:uploadPhototUrl uploadimgName:(type == Picker_Banner ? @"banner":@"avatar") parameEncoding:AFJSONParameterEncoding progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    } succ:^(NSDictionary *successDict) {
        MLOG(@"%@", successDict);
        if ([successDict[@"result"] integerValue] == 1) {
            [SVProgressHUD dismissWithSuccess:@"上传成功"];
            if (type == Picker_Head) {
                self.userImageView.image = image;
            }else{
                self.bannerImageView.image = image;
            }
            [YHBUser sharedYHBUser].statusIsChanged = YES;
            [[SDWebImageManager sharedManager].imageCache removeImageForKey:(type == Picker_Banner ? [YHBUser sharedYHBUser].userInfo.thumb:[YHBUser sharedYHBUser].userInfo.avatar)];
            /*
            //本地操作
            BOOL result = [UIImagePNGRepresentation((type == Picker_Banner ? self.bannerImageView.image:self.userImageView.image)) writeToFile: (type == Picker_Banner ? [YHBUser sharedYHBUser].localBannerUrl:[YHBUser sharedYHBUser].localHeadUrl)    atomically:YES];
            if (result) {
                [YHBUser sharedYHBUser].statusIsChanged = YES;
            }*/
        }else{
            [SVProgressHUD dismissWithError:kErrorStr];
        }
        
        
    } failure:^(NSDictionary *failDict, NSError *error) {
        [SVProgressHUD dismissWithError:kNoNet];
    }];
    
    
}


- (void)showActionSheet
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
    
    [sheet showInView:self.view];
}

#pragma mark - delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == TextField_Attention) {
        [CategoryViewController sharedInstancetype].isPushed = NO;
        [[CategoryViewController sharedInstancetype] cleanAll];
        LSNavigationController *nav = [[LSNavigationController alloc] initWithRootViewController:[CategoryViewController sharedInstancetype]];
        [self presentViewController:nav animated:YES completion:nil];
        [[CategoryViewController sharedInstancetype] setBlock:^(NSArray *aArray) {
            NSMutableString *text = [NSMutableString stringWithCapacity:25];
            NSMutableString *cateids = [NSMutableString stringWithCapacity:15];
            for (int i = 0; i < aArray.count; i++) {
                YHBCatData *cate = aArray[i];
                [text appendString:cate.catname];
                
                [cateids appendString:[NSString stringWithFormat:@"%d",(int)cate.catid]];
                
                if(i != aArray.count-1){
                    [text appendString:@","];
                    [cateids appendString:@","];
                }
            }
            self.cateID =[cateids copy];
            UITextField *tf = self.textFieldArray[TextField_Attention];
            tf.text = [text copy];
        }];
        return NO;
    }
    else if (textField.tag == TextField_area) {
        if (!self.areaArray) {
            __weak YHBShopInfoViewController *weakself = self;
            [self.addManager getAreaListWithSuccess:^(NSMutableArray *areaArray) {
                weakself.areaArray = areaArray;
                [weakself.areaPicker reloadAllComponents];
            } failure:^(NSString *error) {
                [SVProgressHUD showErrorWithStatus:error cover:YES offsetY:0];
            }];
        }
        [self showAreaPickView];
    } else if (textField.tag < TextView_buisness) {
        UITextField *tf = self.textFieldArray[textField.tag];
        
        [[CCEditTextView sharedView] showEditTextViewWithTitle:_tipTitleArray[textField.tag] textfieldText:tf.text comfirmBlock:^(NSString *text) {
            tf.text = text;
        } cancelBlock:^{
            
        }];
        return NO;
    }
    return NO;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [[CCEditTextView sharedView] showLargeEditTextViewWithTitle:(textView.tag == TextView_buisness ? @"编辑主营产品" : @"编辑店铺介绍") textfieldText:(textView.tag == TextView_buisness ? [YHBUser sharedYHBUser].userInfo.business : [YHBUser sharedYHBUser].userInfo.introduce) comfirmBlock:^(NSString *text) {
        textView.text = text;
        NSLog(@"%@",text);
    } cancelBlock:^{
        
    }];
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    MLOG(@"%lf %lf",textField.frame.size.width, textField.height);
    [textField resignFirstResponder];
    return YES;
    
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
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage * oriImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 保存图片到相册中
        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(oriImage, self,selectorToCall, NULL);
    }


    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    CGRect oldRect = [[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
    CGRect rect = (_pickType == Picker_Head ? CGRectMake(0,0,128,128) : CGRectMake(0, 0, 1080, oldRect.size.height * 1080.0f/ oldRect.size.width));
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self uploadImgWithAction:_pickType Image:newImage];


    
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

#pragma mark - areaPicker

- (void)showAreaPickView
{
    if (![self.areaPicker superview]) {
        UIToolbar *toolView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, _areaPicker.top-30, kMainScreenWidth, 40)];
        toolView.backgroundColor = RGBCOLOR(240, 240, 240);
        _tool = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 60, 0, 60, 40)];
        [_tool setTitle:@"完成" forState:UIControlStateNormal];
        _tool.titleLabel.textAlignment = NSTextAlignmentCenter;
        _tool.titleLabel.font = kFont15;
        [_tool setTitleColor:RGBCOLOR(3, 122, 255) forState:UIControlStateNormal];
        _tool.backgroundColor = [UIColor clearColor];
        [_tool addTarget:self action:@selector(pickerPickEnd:) forControlEvents:UIControlEventTouchDown];
        [toolView addSubview:_tool];
        
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.tag = kButtonTag_Cancel;
        [_cancelBtn setTitleColor:RGBCOLOR(3, 122, 255) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelBtn.titleLabel.font = kFont15;
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn addTarget:self action:@selector(pickerPickEnd:) forControlEvents:UIControlEventTouchDown];
        [toolView addSubview:_cancelBtn];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.clearView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.areaPicker];
        [[UIApplication sharedApplication].keyWindow addSubview:toolView];
        
        [UIView animateWithDuration:0.2 animations:^{
            _areaPicker.top = kMainScreenHeight - 180;
            toolView.top = _areaPicker.top - 30;
        }];
    }
}

- (NSString *)titleWithRow:(NSInteger)row
{
    if (row == 1) {
        return @"请输入详细地址";
    }else if (row == 2){
        return @"请输入联系人姓名";
    }else if (row == 3){
        return @"请输入联系人电话";
    }else return @"";
}

#pragma 地区选择结果更新模型 ui
- (void)pickedAreaToModelAndUI
{
    if (_selProvince && _selCity) {
        YHBAreaModel *area = self.areaArray[_selProvince-1];
        YHBCity *city = area.city[_selCity-1];
        NSString *areaStr = [area.areaname stringByAppendingString:city.areaname];
        
        UITextField *tf = self.textFieldArray[TextField_area];
        tf.text = areaStr;
    }
}

#pragma mark - pickerView delegate and datasource

- (void)pickerPickEnd:(UIButton *)sender{
    
    //HbuAreaListModelAreas *area = self.cityArray[0];
    [self.clearView removeFromSuperview];
    //[self.tableView shouldScrolltoPointY:0];
    if ([_areaPicker superview]) {
        if (sender.tag != kButtonTag_Cancel) {
            [self pickedAreaToModelAndUI];
        }else{
            _selProvince = 0;
            _selCity = 0;
            [_areaPicker selectRow:0 inComponent:0 animated:NO];
            [_areaPicker selectRow:0 inComponent:1 animated:NO];
        }
        [UIView animateWithDuration:0.2 animations:^{
            _areaPicker.top = kMainScreenHeight;
            [_areaPicker removeFromSuperview];
            [sender.superview removeFromSuperview];
        }];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.areaArray.count+1;
    }else{
        if (_selProvince > 0) {
            YHBAreaModel *area = self.areaArray[_selProvince-1];
            return area.city.count + 1;
        }else{
            return 1;
        }
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 140;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        if (row == 0) {
            return @"请选择省份";
        }else{
            YHBAreaModel *model = self.areaArray[row-1];
            return model.areaname;
        }
    }else if(component == 1){
        if (row) {
            YHBAreaModel *model = self.areaArray[_selProvince-1];
            YHBCity *city = model.city[row-1];
            return city.areaname;
        }else return @"请选择城市";
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _selProvince = row;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }else if(component == 1){
        _selCity = row;
    }
    
}


#pragma 载入头像
- (void)loadUserPhoto
{
    YHBUser *user = [YHBUser sharedYHBUser];
    
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.thumb] placeholderImage:[UIImage imageNamed:@"userBannerDefault"] options:SDWebImageCacheMemoryOnly];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.avatar] placeholderImage:[UIImage imageNamed:@"DefualtUser"] options:SDWebImageCacheMemoryOnly];
    /*
    if ([[NSFileManager defaultManager] fileExistsAtPath:user.localBannerUrl]) {
        self.bannerImageView.image = [UIImage imageWithContentsOfFile:user.localBannerUrl];
        
    }else{
        [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.thumb] placeholderImage:[UIImage imageNamed:@"userBannerDefault"]];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:user.localHeadUrl]) {
        self.userImageView.image = [UIImage imageWithContentsOfFile:user.localHeadUrl];
        
    }else{
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.avatar] placeholderImage:[UIImage imageNamed:@"DefualtUser"]];
    }
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)getArrowImageViewWithFrame:(CGRect)frame
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    imageview.backgroundColor = [UIColor clearColor];
    imageview.image = [UIImage imageNamed:@"rightArrow"];
    
    return imageview;
}

@end
