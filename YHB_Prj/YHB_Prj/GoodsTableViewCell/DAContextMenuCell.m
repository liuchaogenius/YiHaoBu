//
//  DAСontextMenuCell.m
//  DAContextMenuTableViewControllerDemo
//
//  Created by Daria Kopaliani on 7/24/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAContextMenuCell.h"
#import "UIImageView+WebCache.h"

#define cellHeight 80
@interface DAContextMenuCell () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *contextMenuView;
@property (strong, nonatomic) UIButton *moreOptionsButton;
@property (strong, nonatomic) UIButton *deleteButton;
@property (assign, nonatomic, getter = isContextMenuHidden) BOOL contextMenuHidden;
@property (assign, nonatomic) BOOL shouldDisplayContextMenuView;
@property (assign, nonatomic) CGFloat initialTouchPositionX;

@end


@implementation DAContextMenuCell

#pragma mark - Initialization

+ (CGFloat)returnCellHeight
{
    return cellHeight;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp
{
    self.actualContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, cellHeight)];
    self.actualContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.actualContentView];
    
    self.goodImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    self.goodImgView.backgroundColor = KColor;
    
    self.goodTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodImgView.right+10, self.goodImgView.top, kMainScreenWidth-self.goodImgView.right-10, 17)];
    self.goodTitleLabel.font = kFont16;
    
    self.vipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.goodTitleLabel.right, self.goodTitleLabel.top, 24, 17)];
    self.vipImgView.image = [UIImage imageNamed:@"vipImg"];
    self.vipImgView.hidden = YES;
    
    self.goodTypeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-90, self.goodTitleLabel.bottom+10, 80, 17)];
    self.goodTypeNameLabel.textColor = [UIColor redColor];
    self.goodTypeNameLabel.textAlignment = NSTextAlignmentRight;
    self.goodTypeNameLabel.font = kFont14;
    
    self.goodCatNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodTitleLabel.left, self.goodTypeNameLabel.top, 41, 17)];
    self.goodCatNameLabel.text = @"分类 : ";
    self.goodCatNameLabel.font = kFont14;
    
    self.goodCatDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodCatNameLabel.right, self.goodCatNameLabel.top, self.goodTypeNameLabel.left-self.goodCatNameLabel.right, 34)];
    self.goodCatDetailLabel.numberOfLines = 2;
    self.goodCatDetailLabel.textColor = [UIColor lightGrayColor];
    self.goodCatDetailLabel.font = kFont14;
    
    self.goodEditTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodTypeNameLabel.left, self.goodTypeNameLabel.bottom+5, 80, 15)];
    self.goodEditTimeLabel.font = kFont12;
    self.goodEditTimeLabel.textAlignment = NSTextAlignmentRight;
    self.goodEditTimeLabel.textColor = [UIColor lightGrayColor];
    
    self.goodTodayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodCatNameLabel.left, self.goodCatNameLabel.top, 120, 15)];
    self.goodTodayLabel.font = kFont12;
    //        self.goodTodayLabel.text = @"供应周期30天";
    
    self.goodAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.goodCatNameLabel.left, self.goodEditTimeLabel.top, 120, 15)];
    self.goodAmountLabel.font = kFont12;
    //        self.goodAmountLabel.text = @"采购数量5000米";
    
    [self.actualContentView addSubview:self.goodImgView];
    [self.actualContentView addSubview:self.goodTitleLabel];
    [self.actualContentView addSubview:self.goodCatNameLabel];
    [self.actualContentView addSubview:self.goodTypeNameLabel];
    [self.actualContentView addSubview:self.goodEditTimeLabel];
    [self.actualContentView addSubview:self.goodCatDetailLabel];
    [self.actualContentView addSubview:self.vipImgView];
    [self.actualContentView addSubview:self.goodTodayLabel];
    [self.actualContentView addSubview:self.goodAmountLabel];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-0.5, kMainScreenWidth, 0.5)];
    bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLineView];

    
    
    self.contextMenuView = [[UIView alloc] initWithFrame:self.actualContentView.bounds];
    self.contextMenuView.backgroundColor = self.contentView.backgroundColor;
    [self.contentView insertSubview:self.contextMenuView belowSubview:self.actualContentView];
    self.contextMenuHidden = self.contextMenuView.hidden = YES;
    self.shouldDisplayContextMenuView = NO;
    self.editable = YES;
    self.moreOptionsButtonTitle = @"刷新";
    self.deleteButtonTitle = @"删除";
    self.menuOptionButtonTitlePadding = 25.;
    self.menuOptionsAnimationDuration = 0.3;
    self.bounceValue = 30.;
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panRecognizer.delegate = self;
    [self addGestureRecognizer:panRecognizer];
    [self setNeedsLayout];
}

- (void)setCellWithModel:(YHBSupplyModel *)aModel
{
    if (aModel.thumb)
    {
        [self.goodImgView sd_setImageWithURL:[NSURL URLWithString:aModel.thumb] placeholderImage:[UIImage imageNamed:@"DefaultProduct"] options:SDWebImageCacheMemoryOnly];
    }
    
    if (aModel.title)
    {
        self.goodTitleLabel.text = aModel.title;
        CGSize strSize = [aModel.title sizeWithFont:kFont16];
        CGRect temFrame = self.goodTitleLabel.frame;
        if (strSize.width+temFrame.origin.x>kMainScreenWidth-50)
        {
            strSize.width = kMainScreenWidth-50-temFrame.origin.x;
        }
        temFrame.size.width = strSize.width;
        self.goodTitleLabel.frame = temFrame;
        CGRect vipFrame = self.vipImgView.frame;
        vipFrame.origin.x = self.goodTitleLabel.right+3;
        self.vipImgView.frame = vipFrame;
    }
    else
    {
        self.goodTitleLabel.text = @"未命名";
    }
    
    
    if (aModel.typename)
    {
        self.goodTypeNameLabel.text = [NSString stringWithFormat:@"状态 : %@", aModel.typename];
    }
    else
    {
        self.goodTypeNameLabel.text = @"";
    }
    
    CGRect typeNameFrame = CGRectMake(kMainScreenWidth-90, self.goodTitleLabel.bottom+10, 80, 15);
    self.goodTypeNameLabel.frame = typeNameFrame;
    
    CGRect catNameFrame = CGRectMake(self.goodCatNameLabel.right, self.goodCatNameLabel.top, self.goodTypeNameLabel.left-self.goodCatNameLabel.right, 17);
    self.goodCatDetailLabel.frame = catNameFrame;
    
    CGSize typeSize = [self.goodTypeNameLabel.text sizeWithFont:kFont14];
    if (typeSize.width>80)
    {
        CGRect temTypeFrame = self.goodTypeNameLabel.frame;
        temTypeFrame.size.width = typeSize.width;
        temTypeFrame.origin.x = kMainScreenWidth-10-typeSize.width;
        self.goodTypeNameLabel.frame = temTypeFrame;
        
        CGRect temCatFrame = self.goodCatDetailLabel.frame;
        temCatFrame.size.width -= typeSize.width-80;
        self.goodCatDetailLabel.frame = temCatFrame;
    }
    
    self.goodCatDetailLabel.numberOfLines=1;
    if (aModel.catname)
    {
        self.goodCatDetailLabel.text = aModel.catname;
        CGSize strSize = [aModel.catname sizeWithFont:kFont14];
        if (strSize.width>self.goodTypeNameLabel.left-self.goodCatNameLabel.right) {
            self.goodCatDetailLabel.numberOfLines = 2;
            CGRect temFrame = self.goodCatDetailLabel.frame;
            temFrame.size.height = 34;
            self.goodCatDetailLabel.frame = temFrame;
        }
    }
    else
    {
        self.goodCatNameLabel.text = @"";
    }
    
    if (aModel.editdate)
    {
        self.goodEditTimeLabel.text = aModel.editdate;
    }
    else
    {
        self.goodEditTimeLabel.text = @"";
    }
    
    if (aModel.vip==1)
    {
        self.vipImgView.hidden=NO;
    }
    else
    {
        self.vipImgView.hidden=YES;
    }
    self.goodTodayLabel.hidden=YES;
    self.goodAmountLabel.hidden=YES;
    self.goodCatNameLabel.hidden = NO;
    self.goodCatDetailLabel.hidden = NO;
    if (aModel.today)
    {
        self.goodTodayLabel.hidden=NO;
        self.goodAmountLabel.hidden=NO;
        self.goodCatNameLabel.hidden = YES;
        self.goodCatDetailLabel.hidden = YES;
        
        self.goodTodayLabel.text = [NSString stringWithFormat:@"供应周期 : %@天", aModel.today];
        self.goodAmountLabel.text = [NSString stringWithFormat:@"采购数量 : %@%@", aModel.amount, aModel.unit];
    }
}

#pragma mark - Public

- (CGFloat)contextMenuWidth
{
    return CGRectGetWidth(self.deleteButton.frame) + CGRectGetWidth(self.moreOptionsButton.frame);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contextMenuView.frame = self.actualContentView.bounds;
    [self.contentView sendSubviewToBack:self.contextMenuView];
    [self.contentView bringSubviewToFront:self.actualContentView];
    
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat menuOptionButtonWidth = [self menuOptionButtonWidth];
    self.moreOptionsButton.frame = CGRectMake(kMainScreenWidth-65*2, 0, 65, CGRectGetHeight(self.actualContentView.frame));

    self.deleteButton.frame = CGRectMake(kMainScreenWidth-65, 0, 65, CGRectGetHeight(self.actualContentView.frame));

}

- (CGFloat)menuOptionButtonWidth
{
    NSString *string = ([self.deleteButtonTitle length] > [self.moreOptionsButtonTitle length]) ? self.deleteButtonTitle : self.moreOptionsButtonTitle;
    CGFloat width = roundf([string sizeWithFont:self.moreOptionsButton.titleLabel.font].width + 2. * self.menuOptionButtonTitlePadding);
    width = MIN(width, CGRectGetWidth(self.bounds) / 2. - 10.);
    if ((NSInteger)width % 2) {
        width += 1.;
    }
    return width;
}

- (void)setDeleteButtonTitle:(NSString *)deleteButtonTitle
{
    _deleteButtonTitle = deleteButtonTitle;
    [self.deleteButton setTitle:deleteButtonTitle forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)setEditable:(BOOL)editable
{
    if (_editable != editable) {
        _editable = editable;
        [self setNeedsLayout];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (self.contextMenuHidden) {
        self.contextMenuView.hidden = YES;
        [super setHighlighted:highlighted animated:animated];
    }
}

- (void)setMenuOptionButtonTitlePadding:(CGFloat)menuOptionButtonTitlePadding
{
    if (_menuOptionButtonTitlePadding != menuOptionButtonTitlePadding) {
        _menuOptionButtonTitlePadding = menuOptionButtonTitlePadding;
        [self setNeedsLayout];
    }
}

- (void)setMenuOptionsViewHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler
{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGRect frame = CGRectMake((hidden) ? 0 : -[self contextMenuWidth], 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    [UIView animateWithDuration:(animated) ? self.menuOptionsAnimationDuration : 0.
                          delay:0.
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         self.actualContentView.frame = frame;
     } completion:^(BOOL finished) {
         self.contextMenuHidden = hidden;
         self.shouldDisplayContextMenuView = !hidden;
         if (!hidden) {
             [self.delegate contextMenuDidShowInCell:self];
         } else {
             [self.delegate contextMenuDidHideInCell:self];
         }
         if (completionHandler) {
             completionHandler();
         }
     }];
}

- (void)setMoreOptionsButtonTitle:(NSString *)moreOptionsButtonTitle
{
    _moreOptionsButtonTitle = moreOptionsButtonTitle;
    [self.moreOptionsButton setTitle:self.moreOptionsButtonTitle forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.contextMenuHidden) {
        self.contextMenuView.hidden = YES;
        [super setSelected:selected animated:animated];
    }
}

#pragma mark - Private

- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
{
    if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)recognizer;
        
        CGPoint currentTouchPoint = [panRecognizer locationInView:self.contentView];
        CGFloat currentTouchPositionX = currentTouchPoint.x;
        CGPoint velocity = [recognizer velocityInView:self.contentView];
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            self.initialTouchPositionX = currentTouchPositionX;
            if (velocity.x > 0) {
                [self.delegate contextMenuWillHideInCell:self];
            } else {
                [self.delegate contextMenuDidShowInCell:self];
            }
        } else if (recognizer.state == UIGestureRecognizerStateChanged) {
            CGPoint velocity = [recognizer velocityInView:self.contentView];
            if (!self.contextMenuHidden || (velocity.x > 0. || [self.delegate shouldShowMenuOptionsViewInCell:self])) {
                if (self.selected) {
                    [self setSelected:NO animated:NO];
                }
                self.contextMenuView.hidden = NO;
                CGFloat panAmount = currentTouchPositionX - self.initialTouchPositionX;
                self.initialTouchPositionX = currentTouchPositionX;
                CGFloat minOriginX = -[self contextMenuWidth] - self.bounceValue;
                CGFloat maxOriginX = 0.;
                CGFloat originX = CGRectGetMinX(self.actualContentView.frame) + panAmount;
                originX = MIN(maxOriginX, originX);
                originX = MAX(minOriginX, originX);
                
                
                if ((originX < -0.5 * [self contextMenuWidth] && velocity.x < 0.) || velocity.x < -100) {
                    self.shouldDisplayContextMenuView = YES;
                } else if ((originX > -0.3 * [self contextMenuWidth] && velocity.x > 0.) || velocity.x > 100) {
                    self.shouldDisplayContextMenuView = NO;
                }
                self.actualContentView.frame = CGRectMake(originX, 0., CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            }
        } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
            [self setMenuOptionsViewHidden:!self.shouldDisplayContextMenuView animated:YES completionHandler:nil];
        }
    }
}

- (void)deleteButtonTapped
{
    if ([self.delegate respondsToSelector:@selector(contextMenuCellDidSelectDeleteOption:)]) {
        [self.delegate contextMenuCellDidSelectDeleteOption:self];
    }
}

- (void)moreButtonTapped
{
    [self.delegate contextMenuCellDidSelectMoreOption:self];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self setMenuOptionsViewHidden:YES animated:NO completionHandler:nil];
}

#pragma mark * Lazy getters

- (UIButton *)moreOptionsButton
{
    if (!_moreOptionsButton) {
        CGRect frame = CGRectMake(kMainScreenWidth-65*2, 0, 65, CGRectGetHeight(self.actualContentView.frame));
        _moreOptionsButton = [[UIButton alloc] initWithFrame:frame];
        _moreOptionsButton.backgroundColor = [UIColor lightGrayColor];
        [self.contextMenuView addSubview:_moreOptionsButton];
        [_moreOptionsButton addTarget:self action:@selector(moreButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        MLOG(@"%f %f", _moreOptionsButton.left, _moreOptionsButton.right);
    }
    return _moreOptionsButton;
}

- (UIButton *)deleteButton
{
    if (self.editable) {
        if (!_deleteButton) {
            CGRect frame = CGRectMake(kMainScreenWidth-65, 0, 65, CGRectGetHeight(self.actualContentView.frame));
            _deleteButton = [[UIButton alloc] initWithFrame:frame];
            _deleteButton.backgroundColor = [UIColor colorWithRed:251./255. green:34./255. blue:38./255. alpha:1.];
            [self.contextMenuView addSubview:_deleteButton];
            [_deleteButton addTarget:self action:@selector(deleteButtonTapped) forControlEvents:UIControlEventTouchUpInside];
            MLOG(@"%f %f", _deleteButton.left, _deleteButton.right);
        }
        return _deleteButton;
    }
    return nil;
}

#pragma mark * UIPanGestureRecognizer delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return fabs(translation.x) > fabs(translation.y);
    }
    return YES;
}

@end