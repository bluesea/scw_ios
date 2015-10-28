//
//  OrderListController.h
//  Car
//
//  Created by Leon on 14-9-24.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "SCBaseTableController.h"

#define ALL_ORDER   0;  //全部
#define UN_PAY      2;  //未付款
#define UN_START    1;  //未出发

@interface OrderListController : SCBaseTableController

@property (nonatomic) int type;

@end
