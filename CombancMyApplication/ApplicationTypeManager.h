//
//  ApplicationTypeManager.h
//  CombancOA
//
//  Created by Golden on 2018/10/25.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationDetailModel.h"

@interface ApplicationTypeManager : NSObject

+ (NSMutableArray *)sectionNumberOfApplicationCellWithDetailModelInfo:(NSArray<ApplicationDetailModel *>*)modelArray;

@end
