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
#import "MJExtension.h"
#import "UIColor+MyApplicaionCategory.h"

#import "MyApplicationInterfaceMacro.h"
#import "MyApplicationInterfaceRequest.h"
#import "MyApplicationModel.h"

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

@end

@implementation MyApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestList];
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
    [self.view addSubview:self.stateSelectionView];
    
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
        make.top.equalTo(self.stateSelectionView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
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
        [cell.applicationStateLbl setTitle:model.stateStr forState:UIControlStateNormal];
        cell.timeLabel.text = [[model.applyTime componentsSeparatedByString:@" "] firstObject];
        cell.beginTimeLabel.text = [NSString stringWithFormat:@"申请人：%@",model.applyUser];
        cell.endTimeLabel.text = [NSString stringWithFormat:@"服务时间：%@",model.freeTime];
    }else if (self.applyType == GroundApplyType) {
        GroundListModel *model = self.dataArray[indexPath.row];
        cell.nameLabel.text = model.venueName;
        [cell.applicationStateLbl setTitle:model.state forState:UIControlStateNormal];
        cell.timeLabel.text = [[model.applyTime componentsSeparatedByString:@" "] firstObject];
        cell.beginTimeLabel.text = [NSString stringWithFormat:@"开始时间：%@",model.stime];
        cell.endTimeLabel.text = [NSString stringWithFormat:@"结束时间：%@",model.etime];
    }else if (self.applyType == CarApplyType) {
        CarListModel *model = self.dataArray[indexPath.row];
        cell.nameLabel.text = model.title;
        [cell.applicationStateLbl setTitle:model.stateStr forState:UIControlStateNormal];
        cell.timeLabel.text = [[model.applyTime componentsSeparatedByString:@" "] firstObject];
        cell.beginTimeLabel.text = [NSString stringWithFormat:@"申请人：%@",model.name];
        cell.endTimeLabel.text = [NSString stringWithFormat:@"申请原因：%@",model.describ];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplicationDetailViewController *detailVC = [[ApplicationDetailViewController alloc]init];
    detailVC.modelArray = [self getData:@"ApplicationDetail"];
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
        } failed:^(NSError *error) {}];
    }else if (self.applyType == GroundApplyType) {
        [MyApplicationInterfaceRequest requestGroundList:groundApplylistParam(@"1", @"10", @"", @"") success:^(id json) {
            self.dataArray = json;
            [self.myTableView reloadData];
        } failed:^(NSError *error) {}];
    }else if (self.applyType == CarApplyType) {
        [MyApplicationInterfaceRequest requestCarList:carApplylistParam(@"", @"", @"", @"1", @"10") success:^(id json) {
            self.dataArray = json;
            [self.myTableView reloadData];
        } failed:^(NSError *error) {}];
    }
}

@end
