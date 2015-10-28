//
//  BzDetailAnnotation.m
//  Car
//
//  Created by Leon on 10/14/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BzDetailAnnotation.h"

@implementation BzDetailAnnotation

- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon andBzModel:(BusinessTrace *)bz{
    if (self = [super init]) {
        self.latitude = lat;
        self.longitude = lon;
        self.bzModel = bz;
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
