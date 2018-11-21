//
//  MyApplicationViewController.m
//  MyApplyDemo
//
//  Created by Golden on 2018/9/12.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "MyApplicationViewController.h"
#import "StateSelectionView.h"
#import "MyApplicationTableViewCell.h"
#import "ApplicationDetailViewController.h"
#import "ApplicationDetailModel.h"
#import "PickerSelectView.h"

#import "MyApplyDefine.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UIColor+MyApplicaionCategory.h"

#import "MyApplicationInterfaceMacro.h"
#import "MyApplicationInterfaceRequest.h"
#import "MyApplicationModel.h"
#import "ApplicationStateManager.h"

static NSString *const ApplicationCellID = @"ApplicationCellID";

@interface MyApplicationViewController ()<
UITableViewDelegate,
UITableViewDataSource,
StateSelectionViewDelegate
>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) StateSelectionView *stateSelectionView;
@property (nonatomic, copy  ) NSArray *titles;
@property (nonatomic, copy  ) NSArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation MyApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.pageSize = 10;
    [self configUI];
    [self requestList];
    [self createRefresh];
}

- (void)createRefresh {
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageSize = 10;
        [self requestList];
    }];
    
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageSize += 10;
        [self requestList];
    }];
}

- (void)configUI {
    switch (self.applyType) {
        case CarApplyType:{
            self.titles = @[@"请假类型",@"审批状态",@"开始日期",@"结束日期"];
            break;
        }
        case GroundApplyType:{
            self.titles = @[@"请假类型",@"开始日期",@"结束日期"];
            break;
        }
        case RepairApplyType:{
            self.titles = @[@"请假类型",@"审批状态",@"开始日期",@"结束日期"];
            break;
        }
        default:
            break;
    }
    
    self.stateSelectionView = [[StateSelectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, getHeight(33)) WithTitles:self.titles];
    self.stateSelectionView.delegate = self;
    //[self.view addSubview:self.stateSelectionView];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.tableFooterView = [UIView new];
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 80;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = [UIColor colorWithHex:@"#EBEBF1"];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.stateSelectionView.mas_bottom);
//        make.left.right.bottom.equalTo(self.view);
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

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyApplicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ApplicationCellID];
    if (!cell) {
        cell = [[MyApplicationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ApplicationCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithHex:@"#EBEBF1"];
    if (self.applyType == RepairApplyType) {
        RepairListModel *model = self.dataArray[indexPath.row];
        cell.nameLabel.text = model.type;
        [cell.applicationStateLbl setTitle:[ApplicationStateManager getStatestrWithStates:model.state] forState:UIControlStateNormal];
        [cell.applicationStateLbl setBackgroundColor:[[ApplicationStateManager getColorWithStates:model.state] colorWithAlphaComponent:0.3]];
        [cell.applicationStateLbl setTitleColor:[ApplicationStateManager getColorWithStates:model.state] forState:UIControlStateNormal];
        cell.timeLabel.text = [[model.applyTime componentsSeparatedByString:@" "] firstObject];
        cell.beginTimeLabel.text = [NSString stringWithFormat:@"申请人：%@",model.applyUser];
        cell.endTimeLabel.text = [NSString stringWithFormat:@"服务时间：%@",model.freeTime];
    }else if (self.applyType == GroundApplyType) {
        GroundListModel *model = self.dataArray[indexPath.row];
        cell.nameLabel.text = model.venueName;
        [cell.applicationStateLbl setTitle:[ApplicationStateManager getStatestrWithStates:model.state] forState:UIControlStateNormal];
        [cell.applicationStateLbl setBackgroundColor:[[ApplicationStateManager getColorWithStates:model.state] colorWithAlphaComponent:0.3]];
        [cell.applicationStateLbl setTitleColor:[ApplicationStateManager getColorWithStates:model.state] forState:UIControlStateNormal];
        cell.timeLabel.text = [[model.applyTime componentsSeparatedByString:@" "] firstObject];
        cell.beginTimeLabel.text = [NSString stringWithFormat:@"开始时间：%@",model.stime];
        cell.endTimeLabel.text = [NSString stringWithFormat:@"结束时间：%@",model.etime];
    }else if (self.applyType == CarApplyType) {
        CarListModel *model = self.dataArray[indexPath.row];
        cell.nameLabel.text = model.title;
        [cell.applicationStateLbl setTitle:[ApplicationStateManager getStatestrWithStates:model.state] forState:UIControlStateNormal];
        [cell.applicationStateLbl setBackgroundColor:[[ApplicationStateManager getColorWithStates:model.state] colorWithAlphaComponent:0.3]];
        [cell.applicationStateLbl setTitleColor:[ApplicationStateManager getColorWithStates:model.state] forState:UIControlStateNormal];
        cell.timeLabel.text = [[model.applyTime componentsSeparatedByString:@" "] firstObject];
        cell.beginTimeLabel.text = [NSString stringWithFormat:@"申请人：%@",model.name];
        cell.endTimeLabel.text = [NSString stringWithFormat:@"申请原因：%@",model.describ];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplicationDetailViewController *detailVC = [[ApplicationDetailViewController alloc]init];
    if (self.applyType == RepairApplyType) {
        detailVC.modelArray = [self getData:@"RepairApplicationDetail"];
        detailVC.applicationType = ApplicationTypeRepair;
        detailVC.repairModel = self.dataArray[indexPath.row];
        detailVC.title = @"报修详情";
    }else if (self.applyType == GroundApplyType) {
        detailVC.modelArray = [self getData:@"GroundApplicationDetail"];
        detailVC.applicationType = ApplicationTypeGround;
        detailVC.groundModel = self.dataArray[indexPath.row];
        detailVC.title = @"场地详情";
    }else if (self.applyType == CarApplyType) {
        detailVC.modelArray = [self getData:@"CarApplicationDetail"];
        detailVC.applicationType = ApplicationTypeCar;
        detailVC.carModel = self.dataArray[indexPath.row];
        detailVC.title = @"用车详情";
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - StateSelectionViewDelegate
- (void)buttonClickedWithTag:(NSInteger)tag {
    if (self.applyType == CarApplyType ||
        self.applyType == RepairApplyType) {
        if (tag == 0) {
            [PickerSelectView showPickerSelecterWithTitle:@"" selectInfo:@[@[@"类型1",@"类型2",@"类型3"]] resultBlock:^(NSArray *selectValue) {
                [self.stateSelectionView setButtonTitle:[selectValue firstObject] WithTags:0];
            }];
        }else if (tag == 1) {
            [PickerSelectView showPickerSelecterWithTitle:@"" selectInfo:@[@[@"状态1",@"状态2",@"状态3"]] resultBlock:^(NSArray *selectValue) {
                [self.stateSelectionView setButtonTitle:[selectValue firstObject] WithTags:1];
            }];
        }else {
            
        }
    }
}

#pragma mark - 获取数据
- (NSArray *)getData:(NSString *)resourceName {
    NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return [ApplicationDetailModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
}

#pragma mark - 请求列表
- (void)requestList {
    if (self.applyType == RepairApplyType) {
        [MyApplicationInterfaceRequest requestRepairList:repairApplylistParam(@"0", @"100", @"") success:^(id json) {
            self.dataArray = json;
            [self.myTableView reloadData];
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
        } failed:^(NSError *error) {
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
        }];
    }else if (self.applyType == GroundApplyType) {
        [MyApplicationInterfaceRequest requestGroundList:groundApplylistParam([@(self.page) description], [@(self.pageSize) description], @"", @"") success:^(id json) {
            self.dataArray = json;
            [self.myTableView reloadData];
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
        } failed:^(NSError *error) {
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
        }];
    }else if (self.applyType == CarApplyType) {
        [MyApplicationInterfaceRequest requestCarList:carApplylistParam(@"", @"", @"", [@(self.page) description], [@(self.pageSize) description]) success:^(id json) {
            self.dataArray = json;
            [self.myTableView reloadData];
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
        } failed:^(NSError *error) {
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
        }];
    }
}

@end
