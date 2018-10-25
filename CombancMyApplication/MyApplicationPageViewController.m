//
//  MyApplicationPageViewController.m
//  MyApplyDemo
//
//  Created by Golden on 2018/9/12.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "MyApplicationPageViewController.h"
#import "UIColor+MyApplicaionCategory.h"
#import "MyApplicationViewController.h"

@interface MyApplicationPageViewController ()

@end

@implementation MyApplicationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)init {
    if (self = [super init]) {
        self.pageAnimatable = NO;
        self.titleSizeSelected = 16;
        self.titleSizeNormal = 16;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleColorSelected = [UIColor colorWithHex:@"#007aff"];
        self.titleColorNormal = [UIColor colorWithHex:@"#38383d"];
        self.titleFontName = @"PingFangSC-Medium";
        self.menuHeight = 44.0f;
        self.menuItemWidth = 40.0f;
        self.menuBGColor = [UIColor whiteColor];
        self.progressWidth = 40.0f;
    }
    return self;
}

- (NSArray *)titles {
    return @[@"请假",@"预约",@"报修"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    MyApplicationViewController *newsListVC = [[MyApplicationViewController alloc]init];
    return newsListVC;
}

@end
