//
//  YHBSearchInputVC.m
//  YHB_Prj
//
//  Created by yato_kami on 15/2/9.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBSearchInputVC.h"
#import "CCListCellView.h"

@interface YHBSearchInputVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,CCListCellDelegate>
{
    SearchHandle _sHandel;
    CancelHandle _cHandel;
    SearchType _type;
}

#define kCancelBtnWidth 50
#define kSearchViewHeight 64
#define kTextfieldHeight 35
#define kSearchDicKey @"searchDic"
#define kClearBtnHeight 40
#define kLeftViewWidth 65

#define kTitleTag 101

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITextField *searachTF;
@property (strong, nonatomic) NSMutableDictionary *searchDic;//搜索数据
@property (strong, nonatomic) UIView *searchView;//最上方view
@property (strong, nonatomic) UIView *clearView;//清除历史记录footer
@property (strong ,nonatomic) UILabel *noDataLabel;
@property (strong, nonatomic) UIView *tfLeftView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) CCListCellView *listCellView;

@end

@implementation YHBSearchInputVC
#pragma  mark - getter and setter
- (CCListCellView *)listCellView
{
    if (!_listCellView) {
        _listCellView = [[CCListCellView alloc] initWithTitleArray:self.titleArray];
        _listCellView.delegate = self;
    }
    return _listCellView;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"采购",@"供应",@"店铺",@"产品"];
    }
    return _titleArray;
}

- (UIView *)tfLeftView
{
    if (!_tfLeftView) {
        _tfLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, kTextfieldHeight)];
        _tfLeftView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSelTypeView)];
        [_tfLeftView addGestureRecognizer:tap];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kLeftViewWidth, kTextfieldHeight)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = self.titleArray[_type - kSegBase];
        titleLabel.font = kFont16;
        titleLabel.tag = kTitleTag;
        [_tfLeftView addSubview:titleLabel];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftViewWidth-20, 0, 10,6)];
        imageview.centerY = _tfLeftView.centerY;
        imageview.image = [UIImage imageNamed:@"downArrow"];
        [_tfLeftView addSubview:imageview];
    }
    return _tfLeftView;
}

- (UILabel *)noDataLabel
{
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.searchView.bottom+40, 160, 20)];
        _noDataLabel.text = @"没有搜索历史记录";
        _noDataLabel.textColor = [UIColor lightGrayColor];
        [_noDataLabel setTextAlignment:NSTextAlignmentCenter];
        _noDataLabel.centerX = kMainScreenWidth/2.0;
    }
    return _noDataLabel;
}

- (UIView *)clearView
{
    if (!_clearView) {
        _clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 20+kClearBtnHeight+10)];
        _clearView.backgroundColor = [UIColor clearColor];
        UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake((kMainScreenWidth-150)/2.0, 20, 150, kClearBtnHeight)];
        clearBtn.layer.borderColor = [kLineColor CGColor];
        clearBtn.layer.borderWidth = 1.0f;
        clearBtn.layer.cornerRadius = 2.0;
        [clearBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [clearBtn setTitle:@"清空历史记录" forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(touchClearBtn) forControlEvents:UIControlEventTouchUpInside];
        [_clearView addSubview:clearBtn];
    }
    return _clearView;
}

- (NSMutableDictionary *)searchDic
{
    if (!_searchDic) {
        NSDictionary *dic =  [[NSUserDefaults standardUserDefaults] objectForKey:kSearchDicKey];
        _searchDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        if (!_searchDic) {
            _searchDic = [NSMutableDictionary dictionaryWithCapacity:4];
        }
    }
    return _searchDic;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, kMainScreenWidth, kMainScreenHeight-self.searchView.bottom) style:UITableViewStylePlain];
        _tableView.backgroundColor = kViewBackgroundColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (instancetype)initWithSearchType:(SearchType)type SearchHandle:(SearchHandle)sHandle cancelHandle:(CancelHandle)cHandel
{
    self = [super init];
    if (self) {
        _sHandel = sHandle;
        _cHandel = cHandel;
        _type = type;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBar.hidden = YES;
    }
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBackgroundColor;
    
    [self creatSearchView];
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
    
    [self.searachTF becomeFirstResponder];
}

- (void)creatSearchView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 20+kSearchViewHeight)];

    view.backgroundColor = [UIColor whiteColor];
    
    UITextField *searchTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 20+(kSearchViewHeight-kTextfieldHeight)/2.0, kMainScreenWidth-20-kCancelBtnWidth-20, kTextfieldHeight)];
    //searchTF.textAlignment = NSTextAlignmentCenter;
    searchTF.layer.borderColor = [KColor CGColor];
    searchTF.layer.borderWidth = 1.0;
    searchTF.returnKeyType = UIReturnKeySearch;
    searchTF.layer.cornerRadius = 4.0;
    //searchTF.textAlignment = NSTextAlignmentCenter;
    searchTF.placeholder = @"请输入搜索关键词";
    [view addSubview:searchTF];
    searchTF.delegate = self;
    searchTF.leftView = self.tfLeftView;
    [searchTF setLeftViewMode:UITextFieldViewModeAlways];
    self.searachTF = searchTF;
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(searchTF.right+10, searchTF.top, kCancelBtnWidth, kTextfieldHeight)];
    cancelBtn.layer.borderWidth = 1.0;
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = kFont16;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.layer.borderColor = [kLineColor CGColor];
    cancelBtn.layer.cornerRadius = 4.0;
    [cancelBtn addTarget:self action:@selector(touchCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBtn];
    self.searchView = view;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom-1, kMainScreenWidth, 1)];
    line.backgroundColor = kLineColor;
    [view addSubview:line];
    
    [self.view addSubview:view];
}

#pragma mark - 数据源方法
#pragma mark 数据行数
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self getCurrentDataArray].count) {
        if (_noDataLabel && [_noDataLabel superview]) {
            [_noDataLabel removeFromSuperview];
        }
        return self.clearView.height;
    }else{
        [self.view addSubview:self.noDataLabel];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self getCurrentDataArray].count) {
        return self.clearView;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.searchDic[[NSString stringWithFormat:@"%lu",_type]];
    return array.count;
}

#pragma mark 每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = kViewBackgroundColor;
        
    }
    NSArray *array = self.searchDic[[NSString stringWithFormat:@"%lu",_type]];
    if (array.count > indexPath.row) {
        cell.textLabel.text = (NSString *)array[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *text =  ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).textLabel.text;
    if (_sHandel) {
        _sHandel(_type,[text copy]);
    }
    [self.navigationController popViewControllerAnimated:NO];
    
}

#pragma mark - action
- (void)touchSelTypeView
{
    [self.listCellView showWithPoint:CGPointMake(self.searachTF.left+10, self.searchView.bottom-20) Animate:YES];
}

- (void)touchCancelBtn
{
    if (_cHandel) {
        _cHandel();
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)touchClearBtn
{
    [self.searchDic removeObjectForKey:[NSString stringWithFormat:@"%lu",_type]];
    [self.tableView reloadData];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([self.searachTF isFirstResponder]) {
        [self.searachTF resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length) {
        NSArray *array = (NSArray *)self.searchDic[[NSString stringWithFormat:@"%lu",_type]];
        NSMutableArray *mutableArray;
        if (array) {
            mutableArray = [NSMutableArray arrayWithCapacity:array.count+1];
            [mutableArray addObjectsFromArray:array];
            [mutableArray addObject:textField.text];
        }else{
            mutableArray = [NSMutableArray arrayWithObject:textField.text];
        }
        [self.searchDic setObject:mutableArray forKey:[NSString stringWithFormat:@"%lu",_type]];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.searchDic forKey:kSearchDicKey];
        
        _sHandel(_type,[textField.text copy]);
    }
    [self.navigationController popViewControllerAnimated:NO];
    
    return YES;
}

#pragma mark 点击搜索类别分类
- (void)touchListCellWithRow:(long)row
{
    if (row+kSegBase != _type) {
        _type = row + kSegBase;
        ((UILabel *)[self.tfLeftView viewWithTag:kTitleTag]).text = self.titleArray[row];
        [self.tableView reloadData];
    }
}

- (NSArray *)getCurrentDataArray
{
    return (NSArray *)self.searchDic[[NSString stringWithFormat:@"%lu",_type]];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
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
