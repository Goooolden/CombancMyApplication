//
//  StateSelectionView.h
//  MyApplyDemo
//
//  Created by Golden on 2018/9/13.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StateSelectionViewDelegate <NSObject>

- (void)buttonClickedWithTag:(NSInteger)tag;

@end

@interface StateSelectionView : UIView

@property (nonatomic, weak) id<StateSelectionViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray<NSString *>*)titles;

- (void)setButtonTitle:(NSString *)title WithTags:(NSInteger)tag;

@end
