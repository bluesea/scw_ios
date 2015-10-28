//
//  OrderAbstract.h
//  Car
//  订单摘要
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "Business.h"

typedef enum {
    /** 已抢单 */
    kOrderStatusGrabed = 1,
    /** 已取消 */
    kOrderStatusUndoed,
    /** 已通过 */
    kOrderStatusPassed,
    /** 承运中 */
    kOrderStatusTransporting,
    /** 已到达 */
    kOrderStatusArrived,
    /** 到达确认 */
    kOrderStatusConfirm,
    /** 回单寄出 */
    kOrderStatusSlipsent,
    /** 回单收到 */
    kOrderStatusSlipgot,
    /** 出事故 */
    kOrderStatusAccident,
    /** 因故终止 */
    kOrderStatusAccover,
    /** 已结算 */
    kOrderStatusSettled,
    /** 已收款 */
    kOrderStatusPaid
} OrderAbstractStatus;

@interface OrderAbstract : Business

/** 订单状态 */
@property (nonatomic,assign) OrderAbstractStatus status;
/** 订单状态名称 */
@property (nonatomic, copy) NSString *statusName;
/** 驾驶员名称 */
@property (nonatomic, copy) NSString *driverName;
/** 费用 */
@property (nonatomic, copy) NSString *money;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) orderAbstractWithDic:(NSDictionary *)dic;

@end
