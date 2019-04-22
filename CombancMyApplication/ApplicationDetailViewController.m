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
#import "CombancHUD.h"
#import "MJExtension.h"
#import "ServiceScoreViewController.h"
#import "ServiceScoreManager.h"
#import "XLPhotoBrowser.h"

#import "ApplicationDetailTableViewCell.h"     //申请信息详情cell
#import "ShowImageTableViewCell.h"             //显示图片
#import "ApprovalProcessTableViewCell.h"       //显示流程
#import "TextViewTableViewCell.h"              //审批意见
#import "MyApplyCarDetailTableViewCell.h"      //用车详情车辆信息
#import "MyApplyDriverDetailTableViewCell.h"   //用车详情司机信息
#import "MyApplyStarTableViewCell.h"           //服务评价打分

static NSString *const ApplicationDetailCELLID = @"ApplicationDetailCELLID";
static NSString *const ShowImageCellID         = @"ShowImageCellID";
static NSString *const ProcessCellID           = @"ProcessCellID";
static NSString *const TextViewCellID          = @"TextViewCellID";
static NSString *const CarDetailCellID         = @"CarDetailCellID";
static NSString *const DriverDetailCellID      = @"DriverDetailCellID";
static NSString *const StarDetailCellID        = @"StarDetailCellID";

@interface ApplicationDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource,
ApproveCarCellDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) UIView *footView;

@end

@implementation ApplicationDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ServiceScoreManager *manager = [ServiceScoreManager shareInstance];
    if (manager.carListModel) {
        self.carModel = manager.carListModel;
        self.sectionArray = [ApplicationTypeManager carSectionNumberOfApplicationCellWithDetailModelInfo:self.modelArray withState:self.carModel.state];
        ApplicationStateView *stateView = [[ApplicationStateView alloc]initWithState:self.carModel.stateStr];
        self.myTableView.tableHeaderView = stateView;
        self.myTableView.tableFooterView = [UIView new];
        [self.myTableView reloadData];
        manager.carListModel = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.applicationType == ApplicationTypeCar) {
        self.sectionArray = [ApplicationTypeManager carSectionNumberOfApplicationCellWithDetailModelInfo:self.modelArray withState:self.carModel.state];
    }else {
        self.sectionArray = [ApplicationTypeManager sectionNumberOfApplicationCellWithDetailModelInfo:self.modelArray];
    }
    [self configUI];
    //底部按钮
    if (self.applicationType == ApplicationTypeCar) {
        //派车撤销：评价结束前均可撤销
        if ([self.carModel.state isEqualToString:@"4"]) {
            //司机已确认 可以评价
            self.myTableView.tableFooterView = [self createFootViewWithTitle:@"评价"];
        }else if ([self.carModel.state isEqualToString:@"6"] ||
                  [self.carModel.state isEqualToString:@"-1"]) {
            //评价完成或者已撤销 不显示按钮
        }else {
            //其余显示撤销按钮
            self.myTableView.tableFooterView = [self createFootViewWithTitle:@"撤销"];
        }
    }else if (self.applicationType == ApplicationTypeGround &&
              ([self.groundModel.state isEqualToString:@"0"] ||
               [self.groundModel.state isEqualToString:@"1"])) {
        self.myTableView.tableFooterView = [self createFootViewWithTitle:@"撤销"];
    }else if (self.applicationType == ApplicationTypeRepair &&
             ([self.repairModel.state isEqualToString:@"0"] ||
             [self.repairModel.state isEqualToString:@"1"])) {
        self.myTableView.tableFooterView = [self createFootViewWithTitle:@"撤销"];
    }
    //顶部状态
    if (self.applicationType == ApplicationTypeCar) {
        ApplicationStateView *stateView = [[ApplicationStateView alloc]initWithState:self.carModel.stateStr];
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
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.edges.equalTo(self.view);
        }
    }];
}

- (UIView *)createFootViewWithTitle:(NSString *)title {
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
    self.footView.backgroundColor = [UIColor whiteColor];
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = self.footView.bounds;
    [submitButton setTitle:title forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor whiteColor]];
    [submitButton setTitleColor:[UIColor colorWithHex:@"#007aff"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:submitButton];
    return self.footView;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            if ([model.key isEqualToString:@"loc"]) {
                cell.infoLabel.text = [NSString stringWithFormat:@"%@~%@",self.carModel.startLoc,self.carModel.endLoc];
            }else if ([model.key isEqualToString:@"describ"]) {
                cell.infoLabel.text = self.carModel.describ;
            }else if ([model.key isEqualToString:@"phone"]) {
                cell.infoLabel.text = self.carModel.phone;
            }else if ([model.key isEqualToString:@"useTime"]) {
                cell.infoLabel.text = self.carModel.useTime;
            }else if ([model.key isEqualToString:@"count"]) {
                cell.infoLabel.text = self.carModel.count;
            }else if ([model.key isEqualToString:@"names"]) {
                cell.infoLabel.text = self.carModel.names;
            }else if ([model.key isEqualToString:@"applyUser"]) {
                MyApplyCarApplyUsersModel *model = [MyApplyCarApplyUsersModel mj_objectWithKeyValues:self.carModel.applyUsers];
                cell.infoLabel.text = model.name;
            }else if ([model.key isEqualToString:@"applyTime"]) {
                cell.infoLabel.text = self.carModel.applyTime;
            }else if ([model.key isEqualToString:@"eva"]) {
                cell.infoLabel.text = self.carModel.eva;
            }
#if 0
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
#endif
        }
        return cell;
    }else if ([model.type isEqualToString:@"2"]) {
        ShowImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShowImageCellID];
        if (!cell) {
            cell = [[ShowImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShowImageCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.applicationType == ApplicationTypeRepair) {
            NSMutableArray *imagePathArray = [[NSMutableArray alloc]init];
            for (PhotosModel *photosModel in self.repairModel.photos) {
                [imagePathArray addObject:[NSString stringWithFormat:@"%@%@",NewsImageURL,photosModel.path]];
            }
            [cell setImageArray:imagePathArray];
        }
        return cell;
    }else if ([model.type isEqualToString:@"3"]) {
        if (self.applicationType == ApplicationTypeCar) {
            //显示驳回意见
            TextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextViewCellID];
            if (!cell) {
                cell = [[TextViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextViewCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameLabel.text = model.name;
            if ([model.key isEqualToString:@"refuse"]) {
                cell.infoTextView.editable = false;
                cell.infoTextView.text = self.carModel.reason;
            }
            return cell;
        }else {
            ApprovalProcessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProcessCellID];
            if (!cell) {
                cell = [[ApprovalProcessTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProcessCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if ([model.type isEqualToString:@"9"]) {
        if ([self.carModel.state isEqualToString:@"5"]) {
            if ([model.key isEqualToString:@"car"])  {
                MyApplyCarDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CarDetailCellID];
                if (!cell) {
                    cell = [[MyApplyCarDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarDetailCellID];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                cell.selectButton.hidden = YES;
                [cell setCarModel:self.carModel];
                return cell;
            }else if ([model.key isEqualToString:@"driver"]) {
                MyApplyDriverDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DriverDetailCellID];
                if (!cell) {
                    cell = [[MyApplyDriverDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DriverDetailCellID];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setDriverModel:self.carModel.driver];
                return cell;
            }
        }else {
            MyApplyCarDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CarDetailCellID];
            if (!cell) {
                cell = [[MyApplyCarDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarDetailCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectButton.hidden = YES;
            if ([model.key isEqualToString:@"driver"]) {
                [cell setDriverModel:self.carModel.driver];
            }else {
                cell.delegate = self;
                [cell setCarModel:self.carModel];
            }
            return cell;
        }
    }else if ([model.type isEqualToString:@"10"]) {
        MyApplyStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StarDetailCellID];
        if (!cell) {
            cell = [[MyApplyStarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StarDetailCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = model.name;
        cell.starView.scorePercent = [self.carModel.stars floatValue] > 0 ? [self.carModel.stars floatValue]/5 : 0;
        return cell;
    }
    return nil;
}

- (void)carImageClicked:(NSArray *)imagePathModelArray {
    NSMutableArray *imagePathArray = [[NSMutableArray alloc]init];
    for (MyApplyCarImagePathModel *model in imagePathModelArray) {
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",[BASE_URL stringByReplacingOccurrencesOfString:@"oa" withString:@"file/upload"],model.path];
        [imagePathArray addObject:[NSURL URLWithString:imagePath]];
    }
    [XLPhotoBrowser showPhotoBrowserWithImages:imagePathArray currentImageIndex:0];
}

#pragma mark - DoAction
//点击撤销按钮
- (void)submitClick:(UIButton *)sender {
    if (self.applicationType == ApplicationTypeCar) {
        if ([self.carModel.state isEqualToString:@"4"]) {
            //评价打分
            ServiceScoreViewController *serviceScoreVC = [[ServiceScoreViewController alloc]init];
            serviceScoreVC.applyID = self.carModel.id;
            [self.navigationController pushViewController:serviceScoreVC animated:YES];
        }else {
            //撤销
            [MyApplicationInterfaceRequest requestRevokeCarApply:revokeCarParam(self.carModel.id,@"-1") success:^(id json) {
                [CombancHUD showSuccessMessage:@"撤销成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } failed:^(NSError *error) {
                [CombancHUD showErrorMessage:@"撤销失败"];
            }];
        }
    }else if (self.applicationType == ApplicationTypeGround) {
        [MyApplicationInterfaceRequest requestRevokeCarApply:revokeGroundParam(self.groundModel.id) success:^(id json) {
            [CombancHUD showSuccessMessage:@"撤销成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(NSError *error) {
            [CombancHUD showErrorMessage:@"撤销失败"];
        }];
    }else if (self.applicationType == ApplicationTypeRepair) {
        [MyApplicationInterfaceRequest requestRevokeRepairApply:revokeRepairParam(@"-1", self.repairModel.id) success:^(id json) {
            [CombancHUD showSuccessMessage:@"撤销成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(NSError *error) {
            [CombancHUD showErrorMessage:@"撤销失败"];
        }];
    }
}

@end
