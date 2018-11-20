//
//  ApplicationDetailViewController.m
//  CombancOA
//
//  Created by Golden on 2018/10/25.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "ApplicationDetailViewController.h"
#import "ApplicationTypeManager.h"
#import "ApplicationDetailModel.h"
#import "Masonry.h"
#import "MyApplicationInterfaceMacro.h"
#import "MyApplicationInterfaceRequest.h"
#import "UIColor+MyApplicaionCategory.h"
#import "ApplicationStateView.h"

#import "ApplicationDetailTableViewCell.h"     //申请信息详情cell
#import "ShowImageTableViewCell.h"             //显示图片
#import "ApprovalProcessTableViewCell.h"       //显示流程

static NSString *const ApplicationDetailCELLID = @"ApplicationDetailCELLID";
static NSString *const ShowImageCellID         = @"ShowImageCellID";
static NSString *const ProcessCellID           = @"ProcessCellID";

@interface ApplicationDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) UIView *footView;

@end

@implementation ApplicationDetailViewController

- (UIView *)footView {
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
        _footView.backgroundColor = [UIColor whiteColor];
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.frame = _footView.bounds;
        [submitButton setTitle:@"撤销" forState:UIControlStateNormal];
        [submitButton setBackgroundColor:[UIColor whiteColor]];
        [submitButton setTitleColor:[UIColor colorWithHex:@"#007aff"] forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:submitButton];
    }
    return _footView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionArray = [ApplicationTypeManager sectionNumberOfApplicationCellWithDetailModelInfo:self.modelArray];
    [self configUI];
    if (self.applicationType == ApplicationTypeCar &&
        ([self.carModel.state isEqualToString:@"0"] ||
         [self.carModel.state isEqualToString:@"1"])) {
            self.myTableView.tableFooterView = self.footView;
        }else if (self.applicationType == ApplicationTypeGround &&
                  ([self.groundModel.state isEqualToString:@"0"] ||
                   [self.groundModel.state isEqualToString:@"1"])) {
            self.myTableView.tableFooterView = self.footView;
        }else if (self.applicationType == ApplicationTypeRepair &&
                ([self.repairModel.state isEqualToString:@"0"] ||
                [self.repairModel.state isEqualToString:@"1"])) {
            self.myTableView.tableFooterView = self.footView;
        }
    
    if (self.applicationType == ApplicationTypeCar) {
        ApplicationStateView *stateView = [[ApplicationStateView alloc]initWithState:self.carModel.state];
        self.myTableView.tableHeaderView = stateView;
    }else if (self.applicationType == ApplicationTypeGround) {
        ApplicationStateView *stateView = [[ApplicationStateView alloc]initWithState:self.groundModel.state];
        self.myTableView.tableHeaderView = stateView;
    }else if (self.applicationType == ApplicationTypeRepair) {
        ApplicationStateView *stateView = [[ApplicationStateView alloc]initWithState:self.repairModel.state];
        self.myTableView.tableHeaderView = stateView;
    }
}

- (void)configUI {
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.tableFooterView = [UIView new];
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 80;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)self.sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplicationDetailModel *model = self.sectionArray[indexPath.section][indexPath.row];
    return [self creatCellWithTableView:tableView appllyModel:model];
}

- (id)creatCellWithTableView:(UITableView *)tableView appllyModel:(ApplicationDetailModel *)model{
    if ([model.type isEqualToString:@"1"]) {
        ApplicationDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ApplicationDetailCELLID];
        if (!cell) {
            cell = [[ApplicationDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ApplicationDetailCELLID];
        }
        cell.nameLabel.text = model.name;
        if (self.applicationType == ApplicationTypeRepair) {
            if ([model.key isEqualToString:@"applyUser"]) {
                cell.infoLabel.text = self.repairModel.applyUser;
            }else if ([model.key isEqualToString:@"type"]) {
                cell.infoLabel.text = self.repairModel.type;
            }else if ([model.key isEqualToString:@"freeTime"]) {
                cell.infoLabel.text = self.repairModel.freeTime;
            }else if ([model.key isEqualToString:@"phone"]) {
                cell.infoLabel.text = self.repairModel.phone;
            }else if ([model.key isEqualToString:@"location"]) {
                cell.infoLabel.text = self.repairModel.location;
            }else if ([model.key isEqualToString:@"assets"]) {
                NSMutableString *string = [[NSMutableString alloc]init];
                for (AssetsModel *assetModel in self.repairModel.assets) {
                    [string appendString:assetModel.name];
                }
                cell.infoLabel.text = string;
            }
        }else if (self.applicationType == ApplicationTypeGround) {
            if ([model.key isEqualToString:@"venueName"]) {
                cell.infoLabel.text = self.groundModel.venueName;
            }else if ([model.key isEqualToString:@"cdate"]) {
                cell.infoLabel.text = self.groundModel.cdate;
            }else if ([model.key isEqualToString:@"time"]) {
                cell.infoLabel.text = [NSString stringWithFormat:@"%@-%@",self.groundModel.stime,self.groundModel.etime];
            }else if ([model.key isEqualToString:@"num"]) {
                cell.infoLabel.text = self.groundModel.num;
            }else if ([model.key isEqualToString:@"reason"]) {
                cell.infoLabel.text = self.groundModel.reason;
            }
        }else if (self.applicationType == ApplicationTypeCar) {
            if ([model.key isEqualToString:@"name"]) {
                cell.infoLabel.text = self.carModel.name;
            }else if ([model.key isEqualToString:@"applyTime"]) {
                cell.infoLabel.text = self.carModel.applyTime;
            }else if ([model.key isEqualToString:@"location"]) {
                cell.infoLabel.text = self.carModel.location;
            }else if ([model.key isEqualToString:@"destination"]) {
                cell.infoLabel.text = self.carModel.destination;
            }else if ([model.key isEqualToString:@"num"]) {
                cell.infoLabel.text = self.carModel.count;
            }else if ([model.key isEqualToString:@"outTime"]) {
                cell.infoLabel.text = [NSString stringWithFormat:@"%@ %@",self.carModel.outDate,self.carModel.outTime];
            }
        }
        return cell;
    }else if ([model.type isEqualToString:@"2"]) {
        ShowImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShowImageCellID];
        if (!cell) {
            cell = [[ShowImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShowImageCellID];
        }
        if (self.applicationType == ApplicationTypeRepair) {
            NSMutableArray *imagePathArray = [[NSMutableArray alloc]init];
            for (PhotosModel *photosModel in self.repairModel.photos) {
                [imagePathArray addObject:[NSString stringWithFormat:@"%@%@",NewsImageURL,photosModel.path]];
            }
            [cell setImageArray:imagePathArray];
        }
        return cell;
    }else if ([model.type isEqualToString:@"3"]) {
        ApprovalProcessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProcessCellID];
        if (!cell) {
            cell = [[ApprovalProcessTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProcessCellID];
        }
        return cell;
    }
    return nil;
}

#pragma mark - DoAction
//点击撤销按钮
- (void)submitClick:(UIButton *)sender {
    if (self.applicationType == ApplicationTypeCar) {
        [MyApplicationInterfaceRequest requestRevokeCarApply:revokeCarParam(self.carModel.id) success:^(id json) {} failed:^(NSError *error) {}];
    }else if (self.applicationType == ApplicationTypeGround) {
        [MyApplicationInterfaceRequest requestRevokeCarApply:revokeGroundParam(self.groundModel.id) success:^(id json) {} failed:^(NSError *error) {}];
    }else if (self.applicationType == ApplicationTypeRepair) {
        [MyApplicationInterfaceRequest requestRevokeRepairApply:revokeRepairParam(@"-1", self.repairModel.id) success:^(id json) {} failed:^(NSError *error) {}];
    }
}

@end
