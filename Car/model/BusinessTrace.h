//
//  BusinessTrace.h
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BusinessAbstract.h"
@interface BusinessTrace : BusinessAbstract

@property (nonatomic, copy) NSString *distance;   //距离
@property (nonatomic, copy) NSString *longitude;  //经纬度
@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *carPic;
@property (nonatomic, copy) NSString *driverType;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) businessTraceWithDic:(NSDictionary *)dic;

@end
