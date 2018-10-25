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

@end
