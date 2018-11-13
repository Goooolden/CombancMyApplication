//
//  MyApplicationInterfaceMacro.h
//  Pods
//
//  Created by Golden on 2018/11/11.
//
#import <UIKit/UIKit.h>
#ifndef MyApplicationInterfaceMacro_h
#define MyApplicationInterfaceMacro_h

#define isNilOrNull(obj) (obj == nil || [obj isEqual:[NSNull null]])

#define setObjectForKey(object) \
do { \
[dictionary setObject:object forKey:@#object]; \
} while (0)

#define setObjectForParameter(object) \
do { \
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil]; \
NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]; \
[paramDic setObject:str forKey:@"param"]; \
} while (0)

#define MyApplicatonToken (@"MyApplicatonToken")
#define BASE_URL (@"https://campus.shuxiaoyun.cn/micro/oa")
#define NewsImageURL (@"https://campus.shuxiaoyun.cn/micro/file/upload")
#define MyToken [[NSUserDefaults standardUserDefaults] objectForKey:MyApplicatonToken]

//请求header
NS_INLINE NSDictionary *header(NSString *token) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(token);
    return dictionary;
}

#pragma mark - 我的报修
//我的报修申请列表
#define RepairApplylist_URL ([NSString stringWithFormat:@"%@/repair/applyList",BASE_URL])
/**
 我的报修申请参数
 @param typeId 维修类型ID
 @param state 维修状态 100->全部，0->,1->处理中,2->处理完成,3->不能处理,4->已撤销
 @param search 维修主题内容，空查全部
 */
NS_INLINE NSDictionary *repairApplylistParam(NSString *typeId,NSString *state,NSString *search) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(typeId);
    setObjectForKey(state);
    setObjectForKey(search);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

//维修类型查询
#define RepairTypelist_URL ([NSString stringWithFormat:@"%@/dic/listByCode",BASE_URL])
/**
 获取报修类型参数
 @param code repairType
 */
NS_INLINE NSDictionary *repairTypelistParam(NSString *code) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(code);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

#pragma mark - 我的申请场地列表
//我的场地预约申请列表
#define GroundApplylist_URL ([NSString stringWithFormat:@"%@/venue/myApply",BASE_URL])
NS_INLINE NSDictionary *groundApplylistParam(NSString *page,NSString *pageSize,NSString *searchStr,NSString *state) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(page);
    setObjectForKey(pageSize);
    setObjectForKey(searchStr);
    setObjectForKey(state);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

#pragma mark - 我的用车申请列表
#define CarApplylist_URL ([NSString stringWithFormat:@"%@/car/apply/page",BASE_URL])
NS_INLINE NSDictionary *carApplylistParam(NSString *q,NSString *state,NSString *outDate,NSString *currentPage,NSString *pageSize) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(q);
    setObjectForKey(state);
    setObjectForKey(outDate);
    setObjectForKey(currentPage);
    setObjectForKey(pageSize);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

//撤销用车申请
#define RevokeCar_URL ([NSString stringWithFormat:@"%@/car/apply/cancel",BASE_URL])
NS_INLINE NSDictionary *revokeCarParam(NSString *id) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(id);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

//撤销场地申请
#define RevokeGround_URL ([NSString stringWithFormat:@"%@/venue/cancelApply",BASE_URL])
NS_INLINE NSDictionary *revokeGroundParam(NSString *applyId) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(applyId);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

//撤销报修申请
#define RevokeRepair_URL ([NSString stringWithFormat:@"%@/repair/updateApply",BASE_URL])
NS_INLINE NSDictionary *revokeRepairParam(NSString *state,NSString *id) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(state);
    setObjectForKey(id);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}
#endif /* MyApplicationInterfaceMacro_h */
