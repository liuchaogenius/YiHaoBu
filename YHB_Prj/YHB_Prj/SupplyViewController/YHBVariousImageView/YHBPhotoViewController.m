//
//  YHBPhotoViewController.m
//  TestButton
//
//  Created by Johnny's on 14/11/17.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import "YHBPhotoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "YHBPhotoButton.h"
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define kMainScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface YHBPhotoViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *temPhotoArray;
    UIActivityIndicatorView *activityView;
}
@property(nonatomic, strong) void(^ myBlock)(NSArray *array);
@property(nonatomic, assign) int photoCount;

@property(nonatomic, strong) NSMutableDictionary *photoDictionary;
@property(nonatomic, assign) int currentSelectCount;
@property(nonatomic, strong) NSString *myTitle;
@property(nonatomic, assign) CGFloat interval;
@property(nonatomic, assign) CGFloat photoHeight;
@property(nonatomic, strong) NSArray *photoArray;
@property(nonatomic, strong) UITableView *showPhotoTableView;
@end

@implementation YHBPhotoViewController

- (instancetype)initWithPhotoArray:(NSArray *)aPhotoArray andTitle:(NSString *)aTitle andBlock:(void(^)(NSArray *aArray))aBlock andPhotoCount:(int)aPhotoCount
{
    if (self = [super init]) {
        temPhotoArray = aPhotoArray;
        self.myTitle = aTitle;
        self.title = aTitle;
        self.myBlock = aBlock;
        self.photoCount = aPhotoCount;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _interval = 9/3;
    _photoHeight = (kMainScreenWidth-9)/4;
    _currentSelectCount = 0;
    _photoDictionary = [NSMutableDictionary new];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    
    self.showPhotoTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.showPhotoTableView.delegate = self;
    self.showPhotoTableView.dataSource = self;
    self.showPhotoTableView.tableFooterView = [UIView new];
    self.showPhotoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.showPhotoTableView];
    
    activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-20, kMainScreenHeight/2-20, 40, 40)];
    activityView.color = [UIColor blackColor];
    [activityView startAnimating];
    [self.view addSubview:activityView];
    
    [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.1];
}

- (void)reloadTableView
{
    self.photoArray = temPhotoArray;
    [self.showPhotoTableView reloadData];
    [activityView stopAnimating];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoArray.count%4==0?self.photoArray.count/4:self.photoArray.count/4+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _photoHeight+_interval;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (int i=0; i<self.photoArray.count-indexPath.row*4; i++)
    {
        YHBPhotoButton *btn = [[YHBPhotoButton alloc] initWithFrame:CGRectMake((_interval+_photoHeight)*i, 0, _photoHeight, _photoHeight)];
        ALAsset *asset = [self.photoArray objectAtIndex:indexPath.row*4+i];
        CGImageRef cgImage = [asset thumbnail];
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        btn.tag = 100+i+indexPath.row*4;
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
    }
    
    return cell;
}

- (void)done
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.myBlock([_photoDictionary allValues]);
    }];
}

- (void)touchPhoto:(YHBPhotoButton *)aBtn
{
    if (aBtn.isSelected == NO)
    {
        if (_currentSelectCount<_photoCount)
        {
            _currentSelectCount++;
            aBtn.isSelected = !aBtn.isSelected;
            long index = aBtn.tag-100;
            ALAsset *asset = [self.photoArray objectAtIndex:index];
            CGImageRef cgImage = [asset thumbnail];
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            [_photoDictionary setObject:image forKey:[NSString stringWithFormat:@"%ld", index]];
        }
    }
    else
    {
        aBtn.isSelected = !aBtn.isSelected;
        _currentSelectCount--;
        long index = aBtn.tag-100;
        [_photoDictionary removeObjectForKey:[NSString stringWithFormat:@"%ld", index]];
    }
    [self setTitle];
}

- (void)setTitle
{
    if (_currentSelectCount==0)
    {
        self.title = _myTitle;
    }
    else
    {
        self.title = [NSString stringWithFormat:@"%d Photo Selected", _currentSelectCount];
    }
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
