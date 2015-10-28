//
//  IdConfirmViewController.h
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface IdConfirmViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *driverNum;
@property (weak, nonatomic) IBOutlet UITextField *driverName;
@property (weak, nonatomic) IBOutlet UITextField *driverId;

- (IBAction)search:(id)sender;

@end
