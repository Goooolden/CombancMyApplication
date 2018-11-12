//
//  MyApplicationModel.m
//  AFNetworking
//
//  Created by Golden on 2018/11/11.
//

#import "MyApplicationModel.h"
#import "MJExtension.h"

@implementation MyApplicationModel

@end

@implementation ApplyRepairTypeModel

@end

@implementation RepairListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"assets":@"AssetsModel",
             @"photos":@"PhotosModel",
             @"processList":@"ProcessListModel"
             };
}

@end

@implementation AssetsModel

@end

@implementation PhotosModel

@end

@implementation ProcessListModel

@end

@implementation GroundListModel

@end

@implementation CarListModel

@end
