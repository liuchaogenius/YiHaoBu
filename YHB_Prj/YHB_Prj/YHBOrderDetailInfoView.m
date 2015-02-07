//
//  YHBOrderDetailInfoView.m
//  YHB_Prj
//
//  Created by yato_kami on 15/1/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "YHBOrderDetailInfoView.h"
#define kFont 12
#define kBlankHeight 6
@interface YHBOrderDetailInfoView()

@property (strong, nonatomic) NSMutableArray *labelsArray;
//@property (strong, nonatomic) UILabel *

@end

@implementation YHBOrderDetailInfoView

- (NSMutableArray *)labelsArray
{
    if (!_labelsArray) {
        _labelsArray = [NSMutableArray arrayWithCapacity:8];
        for (int i=0; i < 8; i++) {
            UILabel *label = [self customLabelWithY:10+(kFont + kBlankHeight)*i];
            [_labelsArray addObject:label];
        }
    }
    return _labelsArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kMainScreenWidth, (10+self.labelsArray.count*(kFont+kBlankHeight)));
        self.opaque = YES;
        
        for (int i = 0; i < self.labelsArray.count; i++) {
            [self addSubview:(UILabel *)(self.labelsArray[i])];
        }
    }
    return self;
}

- (void)setUIWithTextArray:(NSMutableArray *)array
{
    NSInteger titleCount = array.count;
    self.height = (10+titleCount*(kFont+kBlankHeight));
    for (int i=0; i < self.labelsArray.count; i++) {
        if ((i < titleCount)) {
            UILabel *label = self.labelsArray[i];
            label.hidden = NO;
            label.text = ((NSString *)array[i]);
        }else if(i < self.labelsArray.count){
            ((UILabel *)self.labelsArray[i]).hidden = YES;
        }
    }
}

- (UILabel *)customLabelWithY:(CGFloat)y
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kMainScreenWidth-20, kFont)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:kFont];
    label.textColor = [UIColor lightGrayColor];
    
    
    return label;
}

@end
