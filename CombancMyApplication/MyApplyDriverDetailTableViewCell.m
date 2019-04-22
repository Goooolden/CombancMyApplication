//
//  ApproveDriverDetailTableViewCell.m
//  TeachAssistant
//
//  Created by Golden on 2019/3/19.
//  Copyright © 2019 王楠. All rights reserved.
//

#import "MyApplyDriverDetailTableViewCell.h"
#import "Masonry.h"
#import "MyApplicationInterfaceMacro.h"
#import "MyApplyDefine.h"
#import "UIColor+MyApplicaionCategory.h"

@implementation MyApplyDriverDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.backView = [[UIView alloc]init];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    self.backView.layer.borderColor = RGBA(0, 156, 255, 1).CGColor;
    self.backView.layer.borderWidth = 1.0f;
    
    self.carImageView = [[UIImageView alloc]init];
    [self.backView addSubview:self.carImageView];
    [self.carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(30);
        make.centerY.equalTo(self.backView.mas_centerY);
        make.width.equalTo(self.backView.mas_width).multipliedBy(0.4);
        make.height.equalTo(self.backView.mas_width).multipliedBy(0.3);
    }];
    
    self.firstLabel = [[UILabel alloc]init];
    self.firstLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    self.firstLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.firstLabel.numberOfLines = 0;
    [self.backView addSubview:self.firstLabel];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carImageView.mas_right).offset(10);
        make.right.equalTo(self.backView.mas_right).offset(-10);
        make.top.equalTo(self.backView.mas_top).offset(10);
    }];
    
    self.secondLabel = [[UILabel alloc]init];
    self.secondLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    self.secondLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.secondLabel.numberOfLines = 0;
    [self.backView addSubview:self.secondLabel];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLabel.mas_left);
        make.right.equalTo(self.firstLabel.mas_right);
        make.top.equalTo(self.firstLabel.mas_bottom).offset(10);
    }];
    
    self.thirdLabel = [[UILabel alloc]init];
    self.thirdLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    self.thirdLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.thirdLabel.numberOfLines = 0;
    [self.backView addSubview:self.thirdLabel];
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLabel.mas_left);
        make.right.equalTo(self.firstLabel.mas_right);
        make.top.equalTo(self.secondLabel.mas_bottom).offset(10);
    }];
    
    self.fourLabel = [[UILabel alloc]init];
    self.fourLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    self.fourLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.fourLabel.numberOfLines = 0;
    self.fourLabel.numberOfLines = 0;
    [self.backView addSubview:self.fourLabel];
    [self.fourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLabel.mas_left);
        make.right.equalTo(self.firstLabel.mas_right);
        make.top.equalTo(self.thirdLabel.mas_bottom).offset(10);
    }];
    
    self.fiveLabel = [[UILabel alloc]init];
    self.fiveLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    self.fiveLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.fiveLabel.numberOfLines = 0;
    [self.backView addSubview:self.fiveLabel];
    [self.fiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLabel.mas_left);
        make.right.equalTo(self.firstLabel.mas_right);
        make.top.equalTo(self.fourLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-5);
    }];
    
#if 0
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = [UIColor blueColor].CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, K_SCREEN_WIDTH - 20, 160)].CGPath;
    border.frame = CGRectMake(0, 0, K_SCREEN_WIDTH - 20, 160);
    //虚线的宽度
    border.lineWidth = 1.f;
    //设置线条的样式
    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    [self.backView.layer addSublayer:border];
#endif
}

- (void)setDriverModel:(MyApplyDriverModel *)driverModel {
    [self.carImageView setImage:[UIImage imageNamed:@"mine_avator_default"]];
    self.firstLabel.text = [NSString stringWithFormat:@"司机姓名：%@",driverModel.name];
    self.secondLabel.text = [NSString stringWithFormat:@"驾照类型：%@",driverModel.type];
    self.thirdLabel.text = [NSString stringWithFormat:@"证件编号：%@",driverModel.driNum];
    self.fourLabel.text = [NSString stringWithFormat:@"联系电话：%@",driverModel.phone];
    self.fiveLabel.textColor = [UIColor redColor];
    self.fiveLabel.text = [NSString stringWithFormat:@"退回原因："];
}

@end
