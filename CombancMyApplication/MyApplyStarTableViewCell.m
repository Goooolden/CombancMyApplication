//
//  ApproveStarTableViewCell.m
//  TeachAssistant
//
//  Created by Golden on 2019/3/20.
//  Copyright © 2019 王楠. All rights reserved.
//

#import "MyApplyStarTableViewCell.h"
#import "UIColor+MyApplicaionCategory.h"
#import "MyApplyDefine.h"
#import "Masonry.h"

@implementation MyApplyStarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textColor = [UIColor colorWithHex:@"#8e8e93"];
    self.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(getHeight(8));
        make.left.equalTo(self.contentView.mas_left).offset(getWidth(16));
        make.width.mas_offset(getWidth(60));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(getHeight(-8));
    }];
    
    self.starView = [[MyApplyStarView alloc] initWithFrame:CGRectMake(getWidth(80), 8, 175, 25) numberOfStars:5];
    self.starView.userInteractionEnabled = false;
    [self.contentView addSubview:self.starView];
}

@end
