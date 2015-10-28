//
//  Business.h
//  Car
//
//  Created by Leon on 14-9-28.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessAbstract.h"

@interface BusinessDetail : BusinessAbstract

/** 发布人 */
//@property (nonatomic, copy) NSString *publisher;
/** 公司Id */
//@property (nonatomic, copy) NSString *comId;
/** 序列号 */
@property (nonatomic, copy) NSString *seqNo;
//@property (nonatomic, copy) NSString *status1;
/** 用户Id */
@property (nonatomic, copy) NSString *userId;
/** 规格 */
@property (nonatomic, copy) NSString *carModelName;
/** 准驾车型 */
@property (nonatomic, copy) NSString *driverType;
/** 车长 */
@property (nonatomic, copy) NSString *carLong;
/** 车宽 */
@property (nonatomic, copy) NSString *carWidth;
/** 车高 */
@property (nonatomic, copy) NSString *carHight;
/** 吨位 */
@property (nonatomic, copy) NSString *carWeight;
/** 燃料 */
@property (nonatomic, copy) NSString *fuelName;
/** 驾驶员数量 */
@property (nonatomic, assign) NSInteger driverNum;
/** 始发区域 */
@property (nonatomic, copy) NSString *oriArea;
/** 始发地址 */
@property (nonatomic, copy) NSString *oriInfo;
/** 目的区域 */
@property (nonatomic, copy) NSString *desArea;
/** 目的地址 */
@property (nonatomic, copy) NSString *desInfo;

/** 结束时间 */
@property (nonatomic, copy) NSString *etime;

/** 预计天数 */
@property (nonatomic, strong) NSNumber *schedate;
/** 运费 */
@property (nonatomic, copy) NSString *transfee;
/** 发车人 */
@property (nonatomic, copy) NSString *sender;
/** 发车人电话 */
@property (nonatomic, copy) NSString *senderPhone;
/** 接车人 */
@property (nonatomic, copy) NSString *receiver;
/** 接车人电话 */
@property (nonatomic, copy) NSString *receiverPhone;
/** 发车省 */
@property (nonatomic, copy) NSString *sen1;
/** 发车市 */
@property (nonatomic, copy) NSString *sen2;
/** 发车县 */
@property (nonatomic, copy) NSString *sen3;
/** 发车地址 */
@property (nonatomic, copy) NSString *senInfo;
/** 接车省 */
@property (nonatomic, copy) NSString *rec1;
/** 接车市 */
@property (nonatomic, copy) NSString *rec2;
/** 接车县 */
@property (nonatomic, copy) NSString *rec3;
/** 接车地址 */
@property (nonatomic, copy) NSString *recInfo;
/** 备注 */
@property (nonatomic, copy) NSString *remark;
/** 操作员Id */
//@property (nonatomic, copy) NSString *operatorId;
/** 运费 */
@property (nonatomic, copy) NSString *money;
/** 状态名 */
@property (nonatomic, copy) NSString *statusName;
/** 接车区域 */
@property (nonatomic, copy) NSString *recArea;
/** 发车区域 */
@property (nonatomic, copy) NSString *senArea;
/** 驾驶员姓名 */
@property (nonatomic, copy) NSString *driverName;
/** 座位数 */
@property (nonatomic, assign) NSInteger seatNum;
/** 路径 **/
@property (nonatomic, copy) NSString *wayName;
/** 方式 **/
@property (nonatomic, copy) NSString *formName;
/**  **/
@property (nonatomic, copy) NSString *total;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) businessDetailWithDic:(NSDictionary *)dic;


@end
