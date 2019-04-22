//
//  ApplicationTypeManager.m
//  CombancOA
//
//  Created by Golden on 2018/10/25.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "ApplicationTypeManager.h"

@implementation ApplicationTypeManager

+ (NSMutableArray *)sectionNumberOfApplicationCellWithDetailModelInfo:(NSArray<ApplicationDetailModel *> *)modelArray {
    //最后要返回的结果
    NSMutableArray *sectionArray = [[NSMutableArray alloc]init];
    //多行分组和单行分组
    NSMutableArray *mulSection    = [[NSMutableArray alloc]init];
    NSMutableArray *singleSection = [[NSMutableArray alloc]init];
    for (int i = 0; i < modelArray.count; i++) {
        ApplicationDetailModel *model = modelArray[i];
        if ([model.type isEqualToString:@"1"] ||
            [model.type isEqualToString:@"2"]) {
            [mulSection addObject:model];
        }else {
            [singleSection addObject:model];
        }
    }
    //组合最后要返回的结果
    [sectionArray addObject:mulSection];
    for (int i = 0; i < singleSection.count; i++) {
        [sectionArray addObject:[NSMutableArray arrayWithObject:singleSection[i]]];
    }
    return sectionArray;
}

+ (NSMutableArray *)carSectionNumberOfApplicationCellWithDetailModelInfo:(NSArray<ApplicationDetailModel *> *)modelArray withState:(NSString *)stateStr {
    //最后要返回的结果
    NSMutableArray *sectionArray = [[NSMutableArray alloc]init];
    //多行分组和单行分组
    NSMutableArray *mulSection    = [[NSMutableArray alloc]init];
    NSMutableArray *secMulSection = [[NSMutableArray alloc]init];
    //判断状态
    NSInteger state = [stateStr integerValue];
    for (ApplicationDetailModel *model in modelArray) {
        if (state == -1 || state == 1) {
            //已撤回 未处理 无车辆和司机信息
            if ([model.type isEqualToString:@"1"] && ![model.key isEqualToString:@"eva"]) {
                [mulSection addObject:model];
            }
        }
        if (state == 2 || state == 4 || state == 5) {
            //已派车司机未确认 已确认 司机退回 显示车辆和司机信息
            if ([model.type isEqualToString:@"1"] && ![model.key isEqualToString:@"eva"]) {
                [mulSection addObject:model];
            }
            if ([model.type isEqualToString:@"9"]) {
                [secMulSection addObject:model];
            }
        }
        if (state == 3) {
            //申请驳回 无车辆和司机信息 但有申请驳回原因
            if ([model.type isEqualToString:@"1"] && ![model.key isEqualToString:@"eva"]) {
                [mulSection addObject:model];
            }
            if ([model.type isEqualToString:@"3"]) {
                [secMulSection addObject:model];
            }
        }
        if (state == 6) {
            //评价完成 显示评价服务以及满意度 显示车辆和司机信息
            if ([model.type isEqualToString:@"1"] || [model.type isEqualToString:@"10"]) {
                [mulSection addObject:model];
            }
            if ([model.type isEqualToString:@"9"]) {
                [secMulSection addObject:model];
            }
        }
    }
    //组合最后要返回的结果
    [sectionArray addObject:mulSection];
    if (secMulSection.count > 0) {
        [sectionArray addObject:secMulSection];
    }
    return sectionArray;
}

@end
