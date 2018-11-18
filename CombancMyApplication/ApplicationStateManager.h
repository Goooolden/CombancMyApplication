//
//  ApplicationStateManager.h
//  AFNetworking
//
//  Created by Golden on 2018/11/18.
//

#import <Foundation/Foundation.h>

// -1->已撤销 0->待处理 1->处理中 2->处理完成 3->不能处理

@interface ApplicationStateManager : NSObject

+ (UIColor *)getColorWithStates:(NSString *)state;

+ (NSString *)getStatestrWithStates:(NSString *)states;

@end
