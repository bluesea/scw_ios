//
//  ReleaseBusinessViewController.h
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface ReleaseBusinessController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic ,assign) BOOL modifyBusiness;
@property (nonatomic, copy) NSString *bzId;

@end
