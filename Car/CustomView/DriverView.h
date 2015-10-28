//
//  DriverView.h
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DriverModel.h"

@interface DriverView : UIView

@property (nonatomic, strong) DriverModel *driver;

+(instancetype) driverView;

@end
