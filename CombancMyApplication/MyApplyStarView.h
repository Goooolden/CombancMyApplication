//
//  StarView.h
//  TeachAssistant
//
//  Created by Golden on 2019/3/20.
//  Copyright © 2019 王楠. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyApplyStarView;
@protocol StarViewDelegate <NSObject>
@optional
// 星星百分比（得分值）发生变化的代理
- (void)starView:(MyApplyStarView *)starView scorePercentDidChange:(CGFloat)newScorePercent;
@end

@interface MyApplyStarView : UIView
@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0~1，默认1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, weak) id<StarViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
@end

NS_ASSUME_NONNULL_END
