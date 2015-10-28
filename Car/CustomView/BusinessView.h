//
//  OrderView.h
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderAbstract;
@class EndorseAbstract;

typedef enum  {
    /** 显示承运费用 */
    BzViewStyleWithMoney = 0,
    /** 显示发布时间 */
    BzViewStyleWithTime,
    /** 不显示费用和时间 */
    BzViewStyleWithNone
    
} BzViewStyle;

@interface BusinessView : UIView

@property (nonatomic, strong) OrderAbstract *order;
@property (nonatomic, strong) EndorseAbstract *endorse;
@property (nonatomic, assign) BzViewStyle bzViewStyle;

+ (instancetype) businessViewStyle:(BzViewStyle ) style;

@end
