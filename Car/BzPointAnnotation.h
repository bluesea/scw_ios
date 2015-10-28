//
//  BzPointAnnotation.h
//  Car
//
//  Created by Leon on 10/14/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <MapKit/MapKit.h>

@class BusinessTrace;

@interface BzPointAnnotation : MKPointAnnotation

@property (nonatomic, strong) BusinessTrace *bzModel;

@end
