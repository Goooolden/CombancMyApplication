//
//  ApproveCarDetailTableViewCell.h
//  AFNetworking
//
//  Created by Golden on 2019/3/19.
//

#import <UIKit/UIKit.h>
#import "MyApplicationModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ApproveCarCellDelegate <NSObject>
- (void)carImageClicked:(NSArray *)imagePathModelArray;
@end

@interface MyApplyCarDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *carImageView;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *thirdLabel;
@property (nonatomic, strong) UILabel *fourLabel;
@property (nonatomic, strong) UILabel *fiveLabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, weak  ) id<ApproveCarCellDelegate> delegate;

@property (nonatomic, strong) CarListModel *carModel;
@property (nonatomic, strong) MyApplyDriverModel *selectDriverModel;
@property (nonatomic, strong) MyApplyDriverModel *driverModel;
@property (nonatomic, strong) MyApplyCarInfoModel *carInfoModel;
@end

NS_ASSUME_NONNULL_END
