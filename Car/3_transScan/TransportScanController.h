//
//  TransportScanController.h
//  Car
//
//  Created by Leon on 14-10-9.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class CustomTextField;

@interface TransportScanController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate/**,CLLocationManagerDelegate**/>

@property (weak, nonatomic) IBOutlet CustomTextField *scan1Fld;
@property (weak, nonatomic) IBOutlet CustomTextField *scan2Fld;
@property (weak, nonatomic) IBOutlet CustomTextField *scan3Fld;
@property (weak, nonatomic) IBOutlet CustomTextField *distanceFld;
@property (weak, nonatomic) IBOutlet UITextField *nameFld;
@property (weak, nonatomic) IBOutlet UITextField *phoneFld;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *busyBtn;
@property (weak, nonatomic) IBOutlet UIButton *freeBtn;
@property (weak, nonatomic) IBOutlet UIButton *onDutyBtn;
//@property (nonatomic, strong) CLLocationManager *manager;


- (IBAction)selectAction:(UIButton *)sender;

- (IBAction)scanAction:(UIButton *)sender;
@end
