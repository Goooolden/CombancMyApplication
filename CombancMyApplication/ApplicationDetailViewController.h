//
//  ApplicationDetailViewController.h
//  CombancOA
//
//  Created by Golden on 2018/10/25.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyApplicationModel.h"

typedef enum ApplicationType {
    ApplicationTypeRepair = 0,
    ApplicationTypeGround,
    ApplicationTypeCar
}ApplicationType;

@interface ApplicationDetailViewController : UIViewController

@property (nonatomic, assign) ApplicationType applicationType;
@property (nonatomic, strong) RepairListModel *repairModel;
@property (nonatomic, strong) GroundListModel *groundModel;
@property (nonatomic, strong) CarListModel    *carModel;
@property (nonatomic, strong) NSArray *modelArray;

@end
