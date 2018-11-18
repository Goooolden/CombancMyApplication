//
//  MyApplicationTableViewCell.m
//  MyApplyDemo
//
//  Created by Golden on 2018/9/12.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "MyApplicationTableViewCell.h"
#import "UIColor+MyApplicaionCategory.h"
#import "Masonry.h"

@interface MyApplicationTableViewCell()

@property (nonatomic, strong) UIView *backGroundView;

@end

@implementation MyApplicationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backGroundView = [[UIView alloc]init];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    self.backGroundView.layer.cornerRadius = 10;
    [self.contentView addSubview:self.backGroundView];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.nameLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    self.nameLabel.numberOfLines = 0;
    [self.backGroundView addSubview:self.nameLabel];
    
    self.applicationStateLbl = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applicationStateLbl.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [self.applicationStateLbl setTitleColor:[UIColor colorWithHex:@"#71ca58"] forState:UIControlStateNormal];
    self.applicationStateLbl.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.applicationStateLbl setBackgroundImage:[UIImage imageNamed:@"apply_green_bg"] forState:UIControlStateNormal];
    self.applicationStateLbl.layer.cornerRadius = 16;
    [self.backGroundView addSubview:self.applicationStateLbl];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.timeLabel.textColor = [UIColor colorWithHex:@"#8e8e93"];
    [self.backGroundView addSubview:self.timeLabel];
    
    self.beginTimeLabel = [[UILabel alloc]init];
    self.beginTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.beginTimeLabel.textColor = [UIColor colorWithHex:@"#8e8e93"];
    [self.backGroundView addSubview:self.beginTimeLabel];
    
    self.endTimeLabel = [[UILabel alloc]init];
    self.endTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.endTimeLabel.textColor = [UIColor colorWithHex:@"#8e8e93"];
    self.endTimeLabel.numberOfLines = 0;
    [self.backGroundView addSubview:self.endTimeLabel];
    
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backGroundView.mas_left).offset(10);
        make.top.equalTo(self.backGroundView.mas_top).offset(15);
        make.width.mas_offset(200);
    }];
    
    [self.applicationStateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.width.mas_offset(80);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView.mas_top).offset(16);
        make.right.equalTo(self.backGroundView.mas_right).offset(-10);
    }];
    
    [self.beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backGroundView.mas_left).offset(10);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
    }];
    
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backGroundView.mas_left).offset(10);
        make.right.equalTo(self.backGroundView.mas_right).offset(-10);
        make.top.equalTo(self.beginTimeLabel.mas_bottom).offset(6);
        make.bottom.equalTo(self.backGroundView.mas_bottom).offset(-15);
    }];
}

@end
