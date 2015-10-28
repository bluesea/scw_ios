//
//  BusinessAbstract.h
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "Business.h"
typedef enum {
    /** 未审核 */
    BusinessStatusUncheck = 1,
    /** 已通过 */
    BusinessStatusChecked,
    /** 已通过 */
    BusinessStatusFtfChecked,
    /** 报名截止 */
    BusinessStatusClose,
    /** 承运中 */
    BusinessStatusTransporting,
    /** 已送达 */
    BusinessStatusArrived,
    /** 已结算 */
    BusinessStatusSettled
} BusinessStatus;

@interface BusinessAbstract : Business

/** 状态 */
@property (nonatomic, assign) BusinessStatus status;
/** 状态名称 */
@property (nonatomic, copy) NSString *statusName;
/** 驾驶员名称 */
@property (nonatomic, copy) NSString *driverName;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) businessAbstractWithDic:(NSDictionary *)dic;

@end
