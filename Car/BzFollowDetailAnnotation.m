//
//  DriverDetailAnnotation.m
//  Car
//
//  Created by Leon on 10/16/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BzFollowDetailAnnotation.h"

@implementation BzFollowDetailAnnotation

- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon andDriver:(DriverModel *)driver{
    if (self = [super init]) {
        self.latitude = lat;
        self.longitude = lon;
        self.driver = driver;
    }
    return self;
}

- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon andBusiness:(BusinessTrace *)business{
    if (self = [super init]) {
        self.latitude = lat;
        self.longitude = lon;
        self.business = business;
    }
    return self;
}


-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

@end
