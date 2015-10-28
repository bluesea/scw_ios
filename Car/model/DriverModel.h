//
//  DriverModel.h
//  Car
//
//  Created by Leon on 14-9-18.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//  司机模型

#import <Foundation/Foundation.h>

@interface DriverModel : NSObject
/** 头像照片 */
@property (nonatomic, copy) NSString *headPicUrl;
/** 司机姓名 */
@property (nonatomic, copy) NSString *name;
/** 司机编码 */
@property (nonatomic, copy) NSString *code;
/** 司机电话 */
@property (nonatomic, copy) NSString *phone;
/** 司机驾照类型 */
@property (nonatomic, copy) NSString *driverType;
/** 司机身份证号码 */
@property (nonatomic, copy) NSString *cardNo;
/** 司机个人照片 */
@property (nonatomic, copy) NSString *photo;
/** 司机驾驶证号 */
@property (nonatomic, copy) NSString *licenseNo;
/** 司机身份证照片 */
@property (nonatomic, copy) NSString *cardPhoto;
/** 司机驾驶证照片 */
@property (nonatomic, copy) NSString *licensePhoto;
/** 司机住址 */
@property (nonatomic, copy) NSString *address;
/** 司机年龄 */
@property (nonatomic, copy) NSString *age;
/** 司机id */
@property (nonatomic, assign)NSInteger driverId;
/** 司机状态 */
@property (nonatomic, assign)NSInteger status;
/** 司机状态名称 */
@property (nonatomic, copy) NSString *statusName;
/** 司机性别 */
@property (nonatomic, assign)NSInteger sex;
/** 性别名称 */
@property (nonatomic, copy) NSString *sexName;
/** 司机行驶里程数 */
@property (nonatomic, copy) NSString * mileage;
/** 司机事故数 */
@property (nonatomic, copy) NSString * acdntNum;
/** 司机等级 */
@property (nonatomic, copy) NSString * level;
/** 司机经度 */
@property (nonatomic, copy) NSString *longitude;
/** 司机纬度 */
@property (nonatomic, copy) NSString *latitude;
/** 司机资格证编号 */
@property (nonatomic, copy) NSString *qualificationNo;
/** 司机资格证照片 */
@property (nonatomic, copy) NSString *qualificationPhoto;
/** 司机公司名称 */
@property (nonatomic, copy) NSString *comName;

- (instancetype) initWithDic:(NSDictionary *)dic;

+ (instancetype) driverWithDic:(NSDictionary *)dic;

@end
