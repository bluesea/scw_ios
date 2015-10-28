//
//  BzFollowViewController.m
//  Car
//
//  Created by Leon on 10/15/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BzFollowViewController.h"
#import "BzFollowAnnotation.h"
#import "BzAnnoView.h"
#import "BzFollowDetailAnnotation.h"
#import "DriverAnnoCell.h"
#import "UIImageView+WebCache.h"
#import "BzFollowAnnoCell.h"
#import "DriverModel.h"

@interface BzFollowViewController (){
    BzFollowDetailAnnotation *calloutAnno;
}

@end

@implementation BzFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"业务追踪";
    _mapView.delegate = self;
    _mapView.hidden = YES;
//    _manager = [[CLLocationManager alloc] init];
//    _manager.delegate = self;
//    [_manager startUpdatingLocation];
    
    [self addDrivers];
    
}

- (void)addDrivers{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(id obj  in _driverArray){
        
        BzFollowAnnotation *point = [[BzFollowAnnotation alloc] init];
        
        if (_showBusiness){
            BusinessTrace *bz = (BusinessTrace *)obj;
            [point setCoordinate:CLLocationCoordinate2DMake([bz.latitude doubleValue], [bz.longitude doubleValue])];
            [point setBz:bz];
        } else{
            DriverModel *driver = (DriverModel *)obj;
            [point setCoordinate:CLLocationCoordinate2DMake([driver.latitude doubleValue], [driver.longitude doubleValue])];
            [point setDriver:driver];
        }
        
        [array addObject:point];
        
        [_mapView addAnnotation:point];
    }
    
    [_mapView addAnnotations:array];
    
}

//#pragma mark - CLLocationManagerDelegate
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    
//    CLLocation *location = [locations lastObject];
//    
//    MKCoordinateSpan span = {5 ,5};
//    MKCoordinateRegion region;
//    if (_longitude != 0 && _latitude != 0){
//        region = (MKCoordinateRegion){CLLocationCoordinate2DMake(_latitude, _longitude),span};
//    } else {
//        region = (MKCoordinateRegion){location.coordinate, span};
//    }
//    
//    [_mapView setRegion:region];
//    _mapView.hidden = NO;
//    [_manager stopUpdatingLocation];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    switch (status) {
//    case kCLAuthorizationStatusNotDetermined:
//        if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//            [manager requestWhenInUseAuthorization];
//        }
//        break;
//    }
//}

#pragma mark - Map Delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *annotationIdentifier = @"bzPointAnnotation";
    if ([annotation isKindOfClass:[BzFollowAnnotation class]]) {
        
        BzFollowAnnotation *driverAnno = (BzFollowAnnotation *)annotation;
        
        MKAnnotationView *annotationview = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        
//        [annotationview se
        annotationview.canShowCallout = NO;
        NSString *imageName;
        if (_showBusiness){
             imageName = [NSString stringWithFormat:@"%@.png",driverAnno.bz.driverType];
        } else {
             imageName = [NSString stringWithFormat:@"%@.png",driverAnno.driver.driverType];
        }
        LSLog(@"-->%@" ,imageName);
        annotationview.image = [UIImage imageNamed:imageName];
        return annotationview;
        
    } else if ([annotation isKindOfClass:[BzFollowDetailAnnotation class]]) {
        BzFollowDetailAnnotation *ann = (BzFollowDetailAnnotation*)annotation;
        BzAnnoView *bzView = (BzAnnoView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"bzView"];
        
        //否则创建新的calloutView
        if (!bzView) {
            bzView = [[BzAnnoView alloc] initWithAnnotation:ann reuseIdentifier:@"bzView"];
            
            if (_showBusiness){
                
                BzFollowAnnoCell *view = [[[NSBundle mainBundle] loadNibNamed:@"BzFollowAnnoCell" owner:self options:nil] lastObject];
                view.tag = 1000;
                
                CGRect frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height );
                
                [bzView setFrame:frame];
                [bzView setCenterOffset:CGPointMake(0, -60)];
                
                [bzView.contentView addSubview:view];
                
                bzView.cellView = view;
                
            } else {
                int  viewindex = _showCompany?0:1;
                
                DriverAnnoCell *view = [[[NSBundle mainBundle] loadNibNamed:@"DriverAnnoCell" owner:self options:nil] objectAtIndex:viewindex];
                
                view.tag = 1000;
                
                CGRect frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height+ Arror_height );
                
                [bzView setFrame:frame];
                [bzView setCenterOffset:CGPointMake(0, -60)];
                
                [bzView.contentView addSubview:view];
                
                bzView.cellView = view;
            }
            

        }
        
        if (_showBusiness){
            BzFollowAnnoCell *view = (BzFollowAnnoCell *)[bzView.contentView viewWithTag:1000];
            view.business = ann.business;
            
        } else {
            DriverAnnoCell *view = (DriverAnnoCell *)[bzView.contentView viewWithTag:1000];
            
            view.nameLbl.text = ann.driver.name;
            view.phoneLbl.text = ann.driver.phone;
            view.comNameLbl.text = ann.driver.comName;
            if (![ann.driver.headPicUrl isKindOfClass:[NSNull class]]){
                [view.photoImg sd_setImageWithURL:[NSURL URLWithString:ann.driver.headPicUrl] placeholderImage:[UIImage imageNamed:@"avator"]];
            }
        }
        

        [bzView setCanShowCallout:YES];
        
        return bzView;
        
    }
    return nil;
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    BzFollowAnnotation *driverAnno = (BzFollowAnnotation*)view.annotation;
    
    if ([view.annotation isKindOfClass:[BzFollowAnnotation class]]) {
        
        //如果点到了这个marker点，什么也不做
        if (calloutAnno.coordinate.latitude == view.annotation.coordinate.latitude&&
            calloutAnno.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        //如果当前显示着calloutview，又触发了select方法，删除这个calloutview annotation
        if (calloutAnno) {
            [mapView removeAnnotation:calloutAnno];
            
        }
        //创建搭载自定义calloutview的annotation
        if (_showBusiness){
            calloutAnno = [[BzFollowDetailAnnotation alloc]initWithLatitude:driverAnno.coordinate.latitude andLongitude:driverAnno.coordinate.longitude andBusiness:driverAnno.bz];
        } else {
            calloutAnno = [[BzFollowDetailAnnotation alloc]initWithLatitude:driverAnno.coordinate.latitude andLongitude:driverAnno.coordinate.longitude andDriver:driverAnno.driver];
        }

        
        [mapView addAnnotation:calloutAnno];
        
        [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
