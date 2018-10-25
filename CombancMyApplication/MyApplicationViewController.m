//
//  MyApplicationViewController.m
//  MyApplyDemo
//
//  Created by Golden on 2018/9/12.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "MyApplicationViewController.h"
#import "Masonry.h"
#import "UIColor+MyApplicaionCategory.h"
#import "MyApplicationTableViewCell.h"
#import "StateSelectionView.h"

static NSString *const ApplicationCellID = @"ApplicationCellID";

@interface MyApplicationViewController ()<
UITableViewDelegate,
UITableViewDataSource,
StateSelectionViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) StateSelectionView *stateSelectionView;

@end

@implementation MyApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    self.stateSelectionView = [[StateSelectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 33) WithTitles:@[@"请假类型",@"审批状态",@"开始日期",@"结束日期"]];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyApplicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ApplicationCellID];
    if (!cell) {
        cell = [[MyApplicationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ApplicationCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithHex:@"#EBEBF1"];
    cell.nameLabel.text = @"事假";
    [cell.applicationStateLbl setTitle:@"审核通过" forState:UIControlStateNormal];
    cell.timeLabel.text = @"2018-07-07";
    cell.beginTimeLabel.text = @"开始时间：2018-07-31 上午";
    cell.endTimeLabel.text = @"结束时间：2018-03-31 下午";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - StateSelectionViewDelegate
- (void)buttonClickedWithTag:(NSInteger)tag {
    NSLog(@"Tag -- %ld",tag);
}

@end
