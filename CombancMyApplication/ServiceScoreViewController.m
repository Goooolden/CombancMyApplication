//
//  ServiceScoreViewController.m
//  TeachAssistant
//
//  Created by Golden on 2019/3/27.
//  Copyright © 2019 王楠. All rights reserved.
//

#import "ServiceScoreViewController.h"
#import "Masonry.h"
#import "MyApplyDefine.h"
#import "MyApplicationInterfaceMacro.h"
#import "MyApplicationInterfaceRequest.h"
#import "UIColor+MyApplicaionCategory.h"
#import "ServiceScoreManager.h"
#import "MyApplicationModel.h"
#import "MJExtension.h"

#import "MyApplyStarTableViewCell.h"
#import "TextViewTableViewCell.h"

static NSString *const StarViewCellID = @"StarViewCellID";
static NSString *const TextViewCellID = @"TextViewCellID";

@interface ServiceScoreViewController ()<
UITableViewDelegate,
UITableViewDataSource,
StarViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy  ) NSArray *sectionNameArray;
@property (nonatomic, copy  ) NSString *starStr;
@property (nonatomic, copy  ) NSString *evaStr;
@end

@implementation ServiceScoreViewController

- (NSArray *)sectionNameArray {
    if (!_sectionNameArray) {
        _sectionNameArray = [[NSArray alloc]initWithObjects:@"  满意度",@"服务评价", nil];
    }
    return _sectionNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"服务评价";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.starStr = @"5";
    self.evaStr = @"";
    [self creatUI];
}

- (void)creatUI {
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = false;
    self.myTableView.showsHorizontalScrollIndicator = false;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 150;
    self.myTableView.tableFooterView = [UIView new];
    self.myTableView.backgroundColor = RGBA(235, 235, 241, 1);
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-40);
        } else {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 40, 0));
        }
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [submitButton setTitle:@"提 交" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor whiteColor]];
    [submitButton setTitleColor:[UIColor colorWithHex:@"#007aff"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myTableView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(40);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MyApplyStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StarViewCellID];
        if (!cell) {
            cell = [[MyApplyStarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StarViewCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium"size:16];
        cell.nameLabel.textColor = [UIColor colorWithHex:@"#38383d"];
        cell.starView.userInteractionEnabled = true;
        cell.starView.delegate = self;
        cell.nameLabel.text = self.sectionNameArray[indexPath.row];
        return cell;
    }else if (indexPath.row == 1) {
        TextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextViewCellID];
        if (!cell) {
            cell = [[TextViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextViewCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setWordLimt:100];
        cell.nameLabel.text = self.sectionNameArray[indexPath.row];
        [cell textViewDidChange:^{
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
        } withDidEndEditingBlock:^(NSString *string) {
            self.evaStr = string;
        }];
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - StarViewDelegate
- (void)starView:(MyApplyStarView *)starView scorePercentDidChange:(CGFloat)newScorePercent {
    self.starStr = [@(newScorePercent * 5) stringValue];
}

#pragma mark - DoAction
- (void)submitButtonClick:(UIButton *)sender {
    [MyApplicationInterfaceRequest requestUpdateApply:ServiceUpdateApplyParam(self.applyID, @"6", self.evaStr, self.starStr) success:^(id json) {
        CarListModel *model = [CarListModel mj_objectWithKeyValues:json[@"data"]];
        ServiceScoreManager *manager = [ServiceScoreManager shareInstance];
        manager.carListModel = model;
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error) {
        
    }];
}

@end
