//
//  BzFollowViewController.h
//  Car
//
//  Created by Leon on 10/15/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BzFollowViewController : UIViewController <MKMapViewDelegate/*,CLLocationManagerDelegate*/>

@property(nonatomic, strong) NSArray *driverArray;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

//@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, assign) BOOL showCompany;

@property (nonatomic, assign) BOOL showBusiness;

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

@end
