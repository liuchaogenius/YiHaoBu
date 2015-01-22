//
//  YHBOrderListCell.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/18.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderListCell.h"
#import "YHBOrderInfoView.h"

#define kTitleFont 16
#define kBtnWidth 70
#define kBtnHeight 25
@interface YHBOrderListCell ()

@property (strong, nonatomic) YHBOrderInfoView *orderInfoView;
@property (strong, nonatomic) UIView *priceNumView;
@property (strong, nonatomic) UIView *buttonsView;
@property (weak, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@end

@implementation YHBOrderListCell

- (UIView *)buttonsView
{
    if (!_buttonsView) {
        _buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.priceNumView.bottom, kMainScreenWidth, kBtnViewHeight)];
        _buttonsView.backgroundColor = [UIColor whiteColor];
        self.rightButton = [self customButtonWithFrame:CGRectMake(kMainScreenWidth-10-kBtnWidth, 5, kBtnWidth, kBtnHeight) Type:1];
        [_buttonsView addSubview:self.rightButton];
        self.leftButton = [self customButtonWithFrame:CGRectMake(self.rightButton.left - 10 - kBtnWidth, self.rightButton.top, kBtnWidth, kBtnHeight) Type:0];
        [_buttonsView addSubview:self.leftButton];
        
        [self.leftButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _buttonsView;
}

- (UIView *)priceNumView
{
    if (!_priceNumView) {
        _priceNumView = [[UIView alloc] initWithFrame:CGRectMake(0, self.orderInfoView.bottom, kMainScreenWidth, kpriceHeight)];
        _priceNumView.backgroundColor = [UIColor whiteColor];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-90, 0, 80, kpriceHeight)];
        price.textColor = KColor;
        price.backgroundColor = [UIColor clearColor];
        price.textAlignment = NSTextAlignmentRight;
        price.font = [UIFont systemFontOfSize:kTitleFont-1];
        [_priceNumView addSubview:price];
        _priceLabel = price;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(price.left-35, 0, 26, kpriceHeight)];
        title.font = kFont12;
        title.text = @"实付";
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor lightGrayColor];
        [_priceNumView addSubview:title];
        title.textAlignment = NSTextAlignmentRight;
    }
    return _priceNumView;
}


- (YHBOrderInfoView *)orderInfoView
{
    if (!_orderInfoView) {
        _orderInfoView = [[YHBOrderInfoView alloc] init];
        //_orderInfoView.top = 0;
    }
    return _orderInfoView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kMainScreenWidth, kpriceHeight+kBtnViewHeight+kInfoViewHeight);
        [self.contentView addSubview:self.orderInfoView];
        [self.contentView addSubview:self.priceNumView];
        [self.contentView addSubview:self.buttonsView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.buttonsView.hidden = YES;
    }
    return self;
}

- (void)setUIWithStatus:(NSInteger)status Title:(NSString *)title price:(NSString *)price number:(NSString *)num amount:(NSString *)amount itemID:(NSInteger)itemid
{
    self.tag = itemid;
    self.orderInfoView.titleLabel.text = title;
    self.orderInfoView.numberLabel.text = [NSString stringWithFormat:@"数量：%@",num];
    self.orderInfoView.priceLabel.text = [NSString stringWithFormat:@"价格：%@",price];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",amount];
    switch (status) {
        case 2://已支付
        case 5://卖家申请退款
        case 6://已退款给卖家
        case 8://买家关闭
        case 9://卖家关闭
        case 0:
        {
            //待确认
            self.buttonsView.hidden = YES;
            self.height = kpriceHeight+kInfoViewHeight;
        }
            break;
        case 1://待确认
        case 3:
        {
            //已发货
            self.buttonsView.hidden = NO;
            self.height = kpriceHeight+kInfoViewHeight+kBtnHeight;
            self.leftButton.hidden = NO;
            self.rightButton.hidden = NO;
            [self.leftButton setTitle:[self getButtonTitleWithWhitch:0 status:status] forState:UIControlStateNormal];
            [self.rightButton setTitle:[self getButtonTitleWithWhitch:1 status:status] forState:UIControlStateNormal];
        }
            break;
        case 4://交易成功
        case 7:
        {
            self.buttonsView.hidden = NO;
            self.height = kpriceHeight+kInfoViewHeight+kBtnHeight;
            self.leftButton.hidden = YES;
            self.rightButton.hidden = NO;
            //[self.leftButton setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.rightButton setTitle:[self getButtonTitleWithWhitch:1 status:status] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (void)touchButton : (UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(touchActionButtonWithItemID:actionStr:)]) {
        [self.delegate touchActionButtonWithItemID:self.tag actionStr:self.textLabel.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (NSString *)getButtonTitleWithWhitch:(int)whitch status:(NSInteger)status
{
    switch (status) {
        case 1:
            return (!whitch ?@"取消订单":@"付款");
            break;
        case 3:
            return (!whitch ? @"申请退款":@"确认收货");
            break;
        case 4:
            return (!whitch? @"":@"评价");
            break;
        case 7:
            return (!whitch? @"":@"申请退款");
            break;
        default:
            return @"";
            break;
    }
}

//type = 0 灰色，type = 1 正常
- (UIButton *)customButtonWithFrame:(CGRect)frame Type:(int)type
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    button.layer.cornerRadius = 2.0f;
    button.backgroundColor = type ? KColor : RGBCOLOR(238, 238, 238);
    [button setTitleColor:(type ? [UIColor whiteColor] : RGBCOLOR(155, 155, 155)) forState:UIControlStateNormal];
    button.titleLabel.font = kFont15;
    button.tag = type;
    
    return button;
}
@end