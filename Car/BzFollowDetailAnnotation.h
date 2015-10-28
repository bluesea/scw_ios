//
//  DriverDetailAnnotation.h
//  Car
//
//  Created by Leon on 10/16/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <MapKit/MapKit.h>

@class DriverModel;
@class BusinessTrace;

@interface BzFollowDetailAnnotation : NSObject<MKAnnotation>

@property (nonatomic,assign) CLLocationDegrees latitude;
@property (nonatomic,assign) CLLocationDegrees longitude;
@property (nonatomic,copy) NSString *title;

@property (nonatomic, strong) DriverModel *driver;
@property (nonatomic, strong) BusinessTrace *business;

- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon andDriver:(DriverModel *)driver;
- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon andBusiness:(BusinessTrace *)business;

@end
