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

@end

@implementation ApplicationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionArray = [ApplicationTypeManager sectionNumberOfApplicationCellWithDetailModelInfo:self.modelArray];
    [self configUI];
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
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
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
        cell.infoLabel.text = model.content;
        return cell;
    }else if ([model.type isEqualToString:@"2"]) {
        ShowImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShowImageCellID];
        if (!cell) {
            cell = [[ShowImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShowImageCellID];
        }
        NSArray *imageArray = [model.content componentsSeparatedByString:@","];
        [cell setImageArray:imageArray];
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
@end
