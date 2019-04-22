//
//  ApproveCarDetailTableViewCell.m
//  AFNetworking
//
//  Created by Golden on 2019/3/19.
//

#import "MyApplyCarDetailTableViewCell.h"
#import "Masonry.h"
#import "UIColor+MyApplicaionCategory.h"
#import "MyApplicationInterfaceMacro.h"

#import "MJExtension.h"
#import "MyApplicationModel.h"
#import "UIImageView+WebCache.h"

@interface MyApplyCarDetailTableViewCell ()
@property (nonatomic, copy) NSArray *carImagePathModelArray;
@end

@implementation MyApplyCarDetailTableViewCell

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
    
    self.backView.layer.borderWidth = 1.0f;
    self.backView.layer.borderColor = RGBA(0, 156, 255, 1).CGColor;
    
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectButton setImage:[UIImage imageNamed:@"approval_assign_rb_false"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.width.equalTo(@30);
    }];
    
    self.carImageView = [[UIImageView alloc]init];
    [self.backView addSubview:self.carImageView];
    [self.carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(30);
        make.centerY.equalTo(self.backView.mas_centerY);
        make.width.equalTo(self.backView.mas_width).multipliedBy(0.4);
        make.height.equalTo(self.backView.mas_width).multipliedBy(0.3);
    }];
    self.carImageView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.carImageView addGestureRecognizer:tap];
    
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
    [self.backView addSubview:self.fourLabel];
    [self.fourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLabel.mas_left);
        make.right.equalTo(self.firstLabel.mas_right);
        make.top.equalTo(self.thirdLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-10);
    }];
    
#if 0
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.contentView.bounds];
    [shapeLayer setPosition:self.contentView.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor redColor] CGColor]];

    [shapeLayer setLineWidth:0.3f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:2], nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //这两个是设置横线两端的起始位置
    CGPathMoveToPoint(path, NULL, 0, 10);
    CGPathAddLineToPoint(path, NULL, width, 10);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[self.contentView layer] addSublayer:shapeLayer];
#endif
    
#if 0
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = [UIColor blueColor].CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, K_SCREEN_WIDTH - 20, 130)].CGPath;
    border.frame = CGRectMake(0, 0, K_SCREEN_WIDTH - 20, 130);
    //虚线的宽度
    border.lineWidth = 1.f;
    //设置线条的样式
    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    [self.backView.layer addSublayer:border];
#endif
}

#pragma mark - DoAction
- (void)tapClick:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(carImageClicked:)]) {
        [self.delegate carImageClicked:self.carImagePathModelArray];
    }
}

#pragma mark - 设置数据
- (void)setCarModel:(CarListModel *)carModel {
    self.carImagePathModelArray = [MyApplyCarImagePathModel mj_objectArrayWithKeyValuesArray:carModel.car.imgPaths];
    if (self.carImagePathModelArray.count > 0) {
        MyApplyCarImagePathModel *imageModel = self.carImagePathModelArray[0];
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",[BASE_URL stringByReplacingOccurrencesOfString:@"oa" withString:@"file/upload"],imageModel.path];
        [self.carImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
    }
    self.firstLabel.text = [NSString stringWithFormat:@"车辆名称：%@",carModel.car.name];
    self.secondLabel.text = [NSString stringWithFormat:@"车辆类型：%@",carModel.car.type];
    self.thirdLabel.text = [NSString stringWithFormat:@"车牌号：%@",carModel.car.carNum];
    self.fourLabel.text = [NSString stringWithFormat:@"载客人数：%@",carModel.car.capacity];
}

- (void)setSelectDriverModel:(MyApplyDriverModel *)selectDriverModel {
    [self.carImageView setImage:[UIImage imageNamed:@"mine_avator_default"]];
    self.firstLabel.text = [NSString stringWithFormat:@"司机姓名：%@",selectDriverModel.name];
    self.secondLabel.text = [NSString stringWithFormat:@"证件编号：%@",selectDriverModel.driNum];
    self.thirdLabel.text = [NSString stringWithFormat:@"联系电话：%@",selectDriverModel.phone];
    self.fourLabel.text = [NSString stringWithFormat:@"当日行程：%@",selectDriverModel.type];
}

- (void)setDriverModel:(MyApplyDriverModel *)driverModel {
    [self.carImageView setImage:[UIImage imageNamed:@"mine_avator_default"]];
    self.firstLabel.text = [NSString stringWithFormat:@"司机姓名：%@",driverModel.name];
    self.secondLabel.text = [NSString stringWithFormat:@"驾照类型：%@",driverModel.type];
    self.thirdLabel.text = [NSString stringWithFormat:@"证件编号：%@",driverModel.driNum];
    self.fourLabel.textColor = RGBA(0, 156, 255, 1);
    self.fourLabel.text = [NSString stringWithFormat:@"当日行程：%lu",(unsigned long)driverModel.applys.count];
}

- (void)setCarInfoModel:(MyApplyCarInfoModel *)carInfoModel {
    self.carImagePathModelArray = [MyApplyCarImagePathModel mj_objectArrayWithKeyValuesArray:carInfoModel.imgPaths];
    if (self.carImagePathModelArray.count > 0) {
        MyApplyCarImagePathModel *imageModel = self.carImagePathModelArray[0];
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",[BASE_URL stringByReplacingOccurrencesOfString:@"oa" withString:@"file/upload"],imageModel.path];
        [self.carImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
    }
    self.firstLabel.text = [NSString stringWithFormat:@"车辆名称：%@",carInfoModel.factory];
    self.secondLabel.text = [NSString stringWithFormat:@"车牌号：%@",carInfoModel.carNum];
    self.thirdLabel.text = [NSString stringWithFormat:@"载客人数：%@",carInfoModel.capacity];
    self.fourLabel.text = [NSString stringWithFormat:@"当日行程：%lu",(unsigned long)carInfoModel.applys.count];
}

@end
