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
#import "MyApplicationInterfaceMacro.h"

@interface MyApplicationPageViewController ()

@end

@implementation MyApplicationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:MyApplicatonToken];
}

- (void)setBaseUrl:(NSString *)baseUrl {
    [[NSUserDefaults standardUserDefaults] setObject:baseUrl forKey:MyApplicationBaseUrl];
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
    return @[@"报修",@"约车",@"场地"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    MyApplicationViewController *newsListVC = [[MyApplicationViewController alloc]init];
    switch (index) {
        case 0:{
            newsListVC.applyType = RepairApplyType;
            break;
        }
        case 1:{
            newsListVC.applyType = CarApplyType;
            break;
        }
        case 2:{
            newsListVC.applyType = GroundApplyType;
            break;
        }
        default:
            break;
    }
    return newsListVC;
}

@end
