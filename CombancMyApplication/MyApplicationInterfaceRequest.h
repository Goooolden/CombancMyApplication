//
//  MyApplicationInterfaceRequest.h
//  AFNetworking
//
//  Created by Golden on 2018/11/11.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccess)(id json);
typedef void(^RequestFailed)(NSError *error);

@interface MyApplicationInterfaceRequest : NSObject

//获取报修类型
+ (void)requestRepairTypeList:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed;

//获取我的报修列表
+ (void)requestRepairList:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed;

//获取我的场地预约列表
+ (void)requestGroundList:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed;

//获取我的用车申请列表
+ (void)requestCarList:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed;

//撤销报修申请
+ (void)requestRevokeRepairApply:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed;

//撤销场地申请
+ (void)requestRevokeGroundApply:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed;

//撤销用车申请
+ (void)requestRevokeCarApply:(NSDictionary *)param success:(RequestSuccess)success failed:(RequestFailed)failed;
@end
