//
//  ApplicationStateManager.m
//  AFNetworking
//
//  Created by Golden on 2018/11/18.
//

#import "ApplicationStateManager.h"
#import "MyApplicationInterfaceMacro.h"

@implementation ApplicationStateManager

+ (UIColor *)getColorWithStates:(NSString *)state {
    switch ([state intValue]) {
        case -1:{
            return RGBA(186, 186, 186, 1);
            break;
        }
        case 0:{
            return RGBA(244, 160, 85, 1);
            break;
        }
        case 1:{
            return RGBA(244, 160, 85, 1);
            break;
        }
        case 2:{
            return RGBA(108, 199, 83, 1);
            break;
        }
        case 3:{
            return RGBA(250, 86, 89, 1);
            break;
        }
        default:
            break;
    }
    return nil;
}

+ (NSString *)getStatestrWithStates:(NSString *)states {
    if (![states integerValue] && ![states isEqualToString:@"0"]) {
        return states;
    }
    switch ([states integerValue]) {
        case -1:{
            return @"已撤销";
            break;
        }
        case 0:{
            return @"待处理";
            break;
        }
        case 1:{
            return @"处理中";
            break;
        }
        case 2:{
            return @"处理完成";
            break;
        }
        case 3:{
            return @"不能处理";
            break;
        }
        default:
            break;
    }
    return @"";
}

@end
