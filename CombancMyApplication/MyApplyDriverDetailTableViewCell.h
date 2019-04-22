//
//  ApproveDriverDetailTableViewCell.h
//  TeachAssistant
//
//  Created by Golden on 2019/3/19.
//  Copyright © 2019 王楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyApplicationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyApplyDriverDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *carImageView;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UILabel *fourLabel;
@property (nonatomic, strong) UILabel *fiveLabel;

@property (nonatomic, strong) MyApplyDriverModel *driverModel;
@end

NS_ASSUME_NONNULL_END
