//
//  BzDetailAnnotation.h
//  Car
//
//  Created by Leon on 10/14/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <MapKit/MapKit.h>

@class BusinessTrace;

@interface BzDetailAnnotation : NSObject<MKAnnotation>

@property (nonatomic,assign) CLLocationDegrees latitude;
@property (nonatomic,assign) CLLocationDegrees longitude;
@property (nonatomic,copy) NSString *title;

@property (nonatomic, strong) BusinessTrace *bzModel;

- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon andBzModel:(BusinessTrace *)bzModel;

@end
