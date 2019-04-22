//
//  ApproveStarTableViewCell.h
//  TeachAssistant
//
//  Created by Golden on 2019/3/20.
//  Copyright © 2019 王楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyApplyStarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyApplyStarTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) MyApplyStarView *starView;

@end

NS_ASSUME_NONNULL_END
