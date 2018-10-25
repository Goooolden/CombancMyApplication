//
//  MyApplicationViewController.h
//  MyApplyDemo
//
//  Created by Golden on 2018/9/12.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ApplyType{
    LeaveApplyType = 0,
    ApproveApplyType,
    RepairApplyType
}ApplyType;

@interface MyApplicationViewController : UIViewController

@property (nonatomic, assign) ApplyType applyType;

@end
