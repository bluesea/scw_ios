//
//  EndorseAbstract.h
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

//GRABED(1, "已抢单"),
//UNDOED(2, "已取消"),
//PASSED(3, "已通过"),
//TRANSPORTING(4, "承运中"),
//SETTLED(5, "已结算");

#import "Business.h"
typedef enum {
    /** 已抢单 */
    EndorseStatusGrabed = 1,
    /** 已取消*/
    EndorseStatusUndoed,
    /** 已通过 */
    EndorseStatusPassed,
    /** 承运中 */
    EndorseStatusTransporting,
    /** 已结算 */
    EndorseStatusSettled
} EndorseStatus;

@interface EndorseAbstract : Business

@property (nonatomic ,assign) EndorseStatus status;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, assign) double money;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) endorseAbstractWithDic:(NSDictionary *)dic;


@end
