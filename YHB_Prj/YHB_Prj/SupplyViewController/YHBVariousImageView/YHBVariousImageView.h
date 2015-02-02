//
//  YHBVariousImageView.h
//  TestButton
//
//  Created by Johnny's on 14/11/17.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface YHBVariousImageView : UIView<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate,MWPhotoBrowserDelegate>
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initEditWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame andPhotoArray:(NSArray *)aPhotoArray;
- (instancetype)initEditWithFrame:(CGRect)frame andPhotoArray:(NSArray *)aPhotoArray;
- (void)setPhotoArray:(NSArray *)aPhotoArray;
- (void)setMyWebPhotoArray:(NSArray *)aPhotoArray;
- (void)changeEdit;

@property(nonatomic, strong) NSArray *webPhotoArray;
@property(nonatomic, assign) BOOL isAllowEdit;
@property(nonatomic, strong) UIView *noPhotoView;
@property(nonatomic, strong) UIAlertView *deleteAlertView;
@property(nonatomic, assign) long deleteBtnIndex;
@property(nonatomic, strong) NSMutableArray *myPhotoArray;
@property(nonatomic, strong) UIImage *plusImage;
@property(nonatomic, assign) int currentPhotoCount;
@property(nonatomic, strong) UIScrollView *photoScrollView;
@property(nonatomic, strong) NSMutableArray *showPhotoArray;
@end
