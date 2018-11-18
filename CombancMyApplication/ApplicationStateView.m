//
//  ApplicationStateView.m
//  AFNetworking
//
//  Created by Golden on 2018/11/18.
//

#import "ApplicationStateView.h"
#import "ApplicationStateManager.h"
#import "UIColor+MyApplicaionCategory.h"
#import "MyApplicationInterfaceMacro.h"

@interface ApplicationStateView()

@property (nonatomic, strong) NSString *state;

@end

@implementation ApplicationStateView

- (instancetype)initWithState:(NSString *)state {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
        self.backgroundColor = [UIColor whiteColor];
        _state = state;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIColor *stateColor = [ApplicationStateManager getColorWithStates:_state];
    NSString *stateStr = [ApplicationStateManager getStatestrWithStates:_state];
    [stateBtn setTitleColor:stateColor forState:UIControlStateNormal];
    [stateBtn setBackgroundColor:[stateColor colorWithAlphaComponent:0.3]];
    [stateBtn setTitle:stateStr forState:UIControlStateNormal];
    stateBtn.frame = CGRectMake(20, 12, 90, 25);
    stateBtn.layer.cornerRadius = 16;
    [self addSubview:stateBtn];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(20, 43, [UIScreen mainScreen].bounds.size.width - 20, 1);
    lineLabel.backgroundColor = RGBA(208, 208, 208, 1);
    [self addSubview:lineLabel];
}

@end
