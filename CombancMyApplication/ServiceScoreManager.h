//
//  ServiceScoreManager.h
//  AFNetworking
//
//  Created by Golden on 2019/3/28.
//

#import <Foundation/Foundation.h>
#import "MyApplicationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ServiceScoreManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) CarListModel *carListModel;

@end

NS_ASSUME_NONNULL_END
