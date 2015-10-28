//
//  ManageOrderListController.h
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseTableController.h"

typedef enum
{
    /**
     *  我方发布
     */
    OrderTypeMyPublish= 1,
    /**
     *  我方承运
     */
    OrderTypeMyGet
}OrderType;

@class OrderManageListController;

@protocol ManageOrderListDelgate <NSObject>

@optional
- (void)managerOrderListShowDetial;
- (void)managerOrderListShowDetial:(OrderManageListController *)controller index:(NSInteger )index;

@end

@interface OrderManageListController : SCBaseTableController

- (void)viewDidCurrentView;

@property (nonatomic, weak) id<ManageOrderListDelgate> manageOrderListDelgate;
@property (nonatomic, assign) OrderType orderType;

@end
