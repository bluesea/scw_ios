//
//  BzViewController.h
//  Car
//
//  Created by Leon on 10/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SCBaseTableController.h"


@interface BzViewController : SCBaseTableController <MKMapViewDelegate>

@property (nonatomic, weak) MKMapView *mapView;
@property (strong, nonatomic) NSDictionary *searchDic;

@end
