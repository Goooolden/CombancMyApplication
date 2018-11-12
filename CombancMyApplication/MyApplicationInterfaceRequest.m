//
//  MyApplicationInterfaceRequest.m
//  AFNetworking
//
//  Created by Golden on 2018/11/11.
//

#import "MyApplicationInterfaceRequest.h"
#import "MyApplicationModel.m"
#import "MyApplicationInterfaceMacro.h"
#import "MJExtension.h"
#import "HTTPTool.h"

@implementation MyApplicationInterfaceRequest

+ (void)requestRepairTypeList:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed {
    [HTTPTool postWithURL:RepairTypelist_URL headers:header(MyToken) params:param success:^(id json) {
        if ([[MyApplicationInterfaceRequest new] isRequestSuccess:json]) {
            //操作成功
            NSArray *dataArray = [ApplyRepairTypeModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            //报修名称列表
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (ApplyRepairTypeModel *model in dataArray) {
                NSDictionary *dic = [NSDictionary dictionaryWithObject:model.id forKey:model.name];
                [array addObject:dic];
            }
            success(array);
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)requestRepairList:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed {
    [HTTPTool postWithURL:RepairApplylist_URL headers:header(MyToken) params:param success:^(id json) {
        if ([[MyApplicationInterfaceRequest new] isRequestSuccess:json]) {
            NSArray *dataArray = [RepairListModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
            success(dataArray);
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)requestGroundList:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed {
    [HTTPTool postWithURL:GroundApplylist_URL headers:header(MyToken) params:param success:^(id json) {
        if ([[MyApplicationInterfaceRequest new] isRequestSuccess:json]) {
            NSArray *dataArray = [GroundListModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
            success(dataArray);
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)requestCarList:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed {
    [HTTPTool postWithURL:CarApplylist_URL headers:header(MyToken) params:param success:^(id json) {
        if ([[MyApplicationInterfaceRequest new] isRequestSuccess:json]) {
            NSArray *dataArray = [CarListModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
            success(dataArray);
        }
    } failure:^(NSError *error) {
        
    }];
}

//请求参数成功检测
- (BOOL)isRequestSuccess:(id)json {
    switch ([json[@"result"] intValue]) {
        case 1:{
            //操作成功
            return YES;
            break;
        }
        case 0:{
            //没有查询到数据
            return NO;
            break;
        }
        case -1:{
            //操作过程中出现异常
            return NO;
            break;
        }
        case -2:{
            //数据重复，一般在新增接口中
            return NO;
            break;
        }
        case -100:{
            //用户会话过期，需重新登陆
            return NO;
            break;
        }
        default:{
            return NO;
            break;
        }
    }
    return NO;
}

@end
