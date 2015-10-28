//
//  DriverConfirmListController.h
//  Car
//
//  Created by Leon on 9/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "SCBaseTableController.h"

typedef enum {
    /**
     *  身份确认
     */
    DriverScanTypeConfirmDirver = 0,
    /**
     *  指派领队
     */
    DriverScanTypeAppointHead ,
    /**
     *  提醒设置
     */
    DriverScanTypeAlertSet,
    /**
     *  司机扫描定位
     */
    DrverScanTypeLocation
    
} DriverScanType;

@interface DriverListController : SCBaseTableController

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cardNo;
@property (nonatomic, assign) DriverScanType scanType;

@end
