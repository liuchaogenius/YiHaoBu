//
//  YHBAlbumViewController.m
//  TestButton
//
//  Created by Johnny's on 14/11/17.
//  Copyright (c) 2014年 Johnny's. All rights reserved.
//

#import "YHBAlbumViewController.h"
#import "UIViewAdditions.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "YHBPhotoViewController.h"
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define kMainScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface YHBAlbumViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) void(^ myBlock)(NSArray *array);
@property(nonatomic, assign) int photoCount;

@property(nonatomic, strong) ALAssetsLibrary *library;
@property(nonatomic, strong) NSMutableArray *photoArray;
@property(nonatomic, strong) NSMutableArray *albumArray;
@property(nonatomic, strong) UITableView *showAlbumTableView;
@end

@implementation YHBAlbumViewController

- (instancetype)initWithBlock:(void(^)(NSArray *aArray))aBlock andPhotoCount:(int)aPhotoCount
{
    if (self = [super init]) {
        self.myBlock = aBlock;
        _photoCount = aPhotoCount;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"相册";
    self.albumArray = [NSMutableArray new];
    self.photoArray = [NSMutableArray new];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    self.showAlbumTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.showAlbumTableView.delegate = self;
    self.showAlbumTableView.dataSource = self;
    self.showAlbumTableView.tableFooterView = [UIView new];
    self.showAlbumTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.showAlbumTableView];
    
    [self enumerationTraversalMyPhoto];
}

- (void)enumerationTraversalMyPhoto
{
    _library = [[ALAssetsLibrary alloc] init];
    __weak YHBAlbumViewController *weakself = self;
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop){
        if (group != nil)
        {
             NSLog(@"%@", group);
             [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [self.albumArray addObject:group];
        }
        NSMutableArray *mutaleArray = [NSMutableArray new];
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result != nil) {
                //将result对象存储到数组中
                [mutaleArray addObject:result];
            }
        }];
        [weakself.photoArray addObject:mutaleArray];
        [weakself.showAlbumTableView reloadData];
     }
     failureBlock: ^(NSError *error){
         NSLog(@"No groups");
         
     }];

}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.albumArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"imageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ALAssetsGroup *group = [self.albumArray objectAtIndex:indexPath.row];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 80, 80)];
    
    UILabel *albumLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, 30, 180, 20)];
    albumLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(albumLabel.left, albumLabel.bottom, 80, 10)];
    countLabel.font = [UIFont systemFontOfSize:12];
    NSArray *array = [self.photoArray objectAtIndex:indexPath.row];
    if (array.count>0)
    {
        countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        
        ALAsset *asset = [array lastObject];
        CGImageRef cgImage = [asset thumbnail];
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        
        imgView.image = image;
    }
    
    
    [cell addSubview:countLabel];
    [cell addSubview:albumLabel];
    [cell addSubview:imgView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self.photoArray objectAtIndex:indexPath.row];
    ALAssetsGroup *group = [self.albumArray objectAtIndex:indexPath.row];
    NSString *title = [group valueForProperty:ALAssetsGroupPropertyName];
    [self.navigationController pushViewController:[[YHBPhotoViewController alloc] initWithPhotoArray:array andTitle:title andBlock:self.myBlock andPhotoCount:self.photoCount] animated:YES];
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
