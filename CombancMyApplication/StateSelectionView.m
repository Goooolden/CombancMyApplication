//
//  StateSelectionView.m
//  MyApplyDemo
//
//  Created by Golden on 2018/9/13.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "StateSelectionView.h"
#import "UIColor+MyApplicaionCategory.h"

@interface StateSelectionView()

@property (nonatomic, copy  ) NSArray *titles;
@property (nonatomic, copy  ) NSArray *oldTitles;

@end

@implementation StateSelectionView

- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray<NSString *>*)titles {
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    if ([self.titles isEqualToArray:self.oldTitles]) {
        return;
    }else {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    
    NSInteger buttonNum = self.titles.count;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / buttonNum;
    CGFloat h = self.frame.size.height;
    CGFloat y = 0;
    for (int i = 0; i < buttonNum; i++) {
        CGFloat x = i * w;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(x, y, w, h);
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:@"#45454a"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        button.tag = i + 9999;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(w, 0, 1, h);
        border.backgroundColor = [UIColor colorWithHex:@"#EBEBF1"].CGColor;
        [button.layer addSublayer:border];
        [self addSubview:button];
    }
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    topLine.backgroundColor = [UIColor colorWithHex:@"#EBEBF1"];
    [self addSubview:topLine];
    UILabel *bottomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, h, self.frame.size.width, 1)];
    bottomLine.backgroundColor = [UIColor colorWithHex:@"#EBEBF1"];
    [self addSubview:bottomLine];
    self.oldTitles = [NSArray arrayWithObject:self.titles];
}

- (void)buttonClick:(UIButton *)sender {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(buttonClickedWithTag:)]) {
        [self.delegate buttonClickedWithTag:sender.tag - 9999];
    }
}

- (void)setButtonTitle:(NSString *)title WithTags:(NSInteger)tag {
    UIButton *button = [self viewWithTag:tag + 9999];
    [button setTitle:title forState:UIControlStateNormal];
}

@end
