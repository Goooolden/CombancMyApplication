//
//  ServiceScoreManager.m
//  AFNetworking
//
//  Created by Golden on 2019/3/28.
//

#import "ServiceScoreManager.h"

static ServiceScoreManager *manager;

@implementation ServiceScoreManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServiceScoreManager alloc]init];
    });
    return manager;
}

@end
