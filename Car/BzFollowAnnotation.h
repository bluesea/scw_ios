//
//  DriverAnnotation.h
//  Car
//
//  Created by Leon on 10/16/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <MapKit/MapKit.h>
@class DriverModel;
@class BusinessTrace;

@interface BzFollowAnnotation : MKPointAnnotation

@property (nonatomic, strong) DriverModel *driver;
@property (nonatomic, strong) BusinessTrace *bz;

@end
