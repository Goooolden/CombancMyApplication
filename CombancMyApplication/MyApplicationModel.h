//
//  MyApplicationModel.h
//  AFNetworking
//
//  Created by Golden on 2018/11/11.
//

#import <Foundation/Foundation.h>

@interface MyApplicationModel : NSObject

@end

#pragma mark - 报修列表
@interface ApplyRepairTypeModel : NSObject

@property (nonatomic, copy) NSString *id;       //维修类型ID
@property (nonatomic, copy) NSString *name;     //维修类型名称
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *layer;
@property (nonatomic, copy) NSString *sys;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *isParent;
@property (nonatomic, copy) NSString *pId;

@end

@interface RepairListModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *applyTime;
@property (nonatomic, copy) NSString *applyUser;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *freeTime;
@property (nonatomic, copy) NSString *stateStr;
@property (nonatomic, copy) NSString *stateClass;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *process;
@property (nonatomic, copy) NSString *stars;
@property (nonatomic, copy) NSString *open;
@property (nonatomic, copy) NSArray  *assets;
@property (nonatomic, copy) NSArray  *photos;
@property (nonatomic, copy) NSArray  *processList;

@end

@interface AssetsModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@end

@interface PhotosModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@end

@interface ProcessListModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *receiverUser;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *receiveTime;
@property (nonatomic, copy) NSString *handleTime;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *stateStr;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *num;
@end

#pragma mark - 场地申请列表
@interface GroundListModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *describ;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *venueName;
@property (nonatomic, copy) NSString *stime;
@property (nonatomic, copy) NSString *etime;
@property (nonatomic, copy) NSString *applyTime;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *cdate;
@property (nonatomic, copy) NSArray  *list;

@end

#pragma mark - 用车申请列表
@interface CarListModel : NSObject

@property (nonatomic, copy) NSString *outDate;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *handleTime;
@property (nonatomic, copy) NSString *carName;
@property (nonatomic, copy) NSString *stateClass;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *destination;
@property (nonatomic, copy) NSString *carTypeId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *carId;
@property (nonatomic, copy) NSString *stateStr;
@property (nonatomic, copy) NSString *describ;
@property (nonatomic, copy) NSString *driverId;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *driverName;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *applyTime;
@property (nonatomic, copy) NSString *outTime;

@end
