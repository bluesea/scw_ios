//
//  DriverScanController.m
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverScanController.h"
#import "DriverListController.h"


@interface DriverScanController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *cardNoField;
- (IBAction)searchAction;

@end

@implementation DriverScanController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchAction {
    [self.view endEditing:YES];
    
    DriverListController *driverList = [[DriverListController alloc] init];
    driverList.name = self.nameField.text;
    driverList.cardNo = self.cardNoField.text;
    
    if ([self.title isEqualToString: @"个性提醒设置"]) {
        driverList.scanType = DriverScanTypeAlertSet;
    } else if ([self.title isEqualToString:@"领队查找"]){
        driverList.scanType = DriverScanTypeAppointHead;
    } else {
        driverList.scanType = DrverScanTypeLocation;
    }
    
    [self.navigationController pushViewController:driverList animated:YES];
}
@end
