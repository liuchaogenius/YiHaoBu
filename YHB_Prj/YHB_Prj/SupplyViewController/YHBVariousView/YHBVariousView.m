//
//  YHBVariousView.m
//  TestButton
//
//  Created by Johnny's on 14/11/17.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import "YHBVariousView.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1]
#define kCellHeight 25
@implementation YHBVariousView

- (void)setAItemArray:(NSArray *)aItemArray andSelectedItem:(int)aSelectedIndex
{
    self.selectedItem = aSelectedIndex;
    self.itemArray = aItemArray;
    self.itemLabel.text = [self.itemArray objectAtIndex:aSelectedIndex];
    [self.showItemTableView reloadData];
    self.backImg.userInteractionEnabled = YES;
    _trueViewFrame = self.frame;
    _trueViewFrame.size.height = self.frame.size.height + aItemArray.count*kCellHeight;
    
    _trueFrame = CGRectMake(self.backImg.left, self.backImg.bottom, self.backImg.right-self.backImg.left, _itemArray.count*kCellHeight);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _isExtend = NO;
        _selectedItem = 0;
        _hideViewFrame = frame;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideItemTableView)];
        self.backImg = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backImg.image = [UIImage imageNamed:@"down"];

        [self.backImg addGestureRecognizer:tapGestureRecognizer];
        
        _hideFrame = CGRectMake(self.backImg.left, self.backImg.bottom, self.backImg.right-self.backImg.left, 0);

        
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-20, frame.size.height)];
        self.itemLabel.textAlignment = NSTextAlignmentCenter;
        self.itemLabel.font = [UIFont systemFontOfSize:12];
        self.itemLabel.textColor = [UIColor whiteColor];
        
        self.showItemTableView = [[UITableView alloc] initWithFrame:_hideFrame];
        self.showItemTableView.hidden = YES;
        self.showItemTableView.alpha = 1;
        self.showItemTableView.opaque = 1;
        self.showItemTableView.delegate = self;
        self.showItemTableView.dataSource = self;
        self.showItemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.backImg addSubview:self.itemLabel];
        [self addSubview:self.backImg];
        [self addSubview:self.showItemTableView];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andItemArray:(NSArray *)aItemArray andSelectedItem:(int)aSelectedIndex
{
    if (self = [self initWithFrame:frame]) {
        _selectedItem = aSelectedIndex;
        _itemArray = aItemArray;
        self.backImg.userInteractionEnabled = YES;
        self.itemLabel.text = [_itemArray objectAtIndex:_selectedItem];
        
        _trueViewFrame = self.frame;
        _trueViewFrame.size.height = frame.size.height + aItemArray.count*kCellHeight;
        
        _trueFrame = CGRectMake(self.backImg.left, self.backImg.bottom, self.backImg.right-self.backImg.left, _itemArray.count*kCellHeight);
    }
    return self;
}

- (void)showOrHideItemTableView
{
    if (_isExtend==NO)
    {
        [self showMyItemTableView];
    }
    else
    {
        [self hideMyItemTableView];
    }
}

- (void)showMyItemTableView
{
    _isExtend = YES;
    self.showItemTableView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showItemTableView.frame = _trueFrame;
        self.frame = _trueViewFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideMyItemTableView
{
    _isExtend = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showItemTableView.frame = _hideFrame;
        self.frame = _hideViewFrame;
    } completion:^(BOOL finished) {
        self.showItemTableView.hidden = YES;
    }];
}

#pragma mark dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor whiteColor];
    cell.alpha = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *itemLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(0, 0, _trueFrame.size.width, kCellHeight)];
    itemLabel.font = [UIFont systemFontOfSize:12];
    itemLabel.text = [_itemArray objectAtIndex:indexPath.row];
    itemLabel.textColor = [UIColor blackColor];
    itemLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.layer.borderColor = [KColor CGColor];
    cell.layer.borderWidth = 0.5;
    
    [cell addSubview:itemLabel];
    return cell;
}

#pragma mark delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedItem = indexPath.row;
    self.itemLabel.text = [_itemArray objectAtIndex:_selectedItem];
    [self hideMyItemTableView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
