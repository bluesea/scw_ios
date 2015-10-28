//
//  TransportController.h
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface TransportController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet CustomTextField *ori1Field;
@property (weak, nonatomic) IBOutlet CustomTextField *ori2Field;
@property (weak, nonatomic) IBOutlet CustomTextField *ori3Field;
@property (weak, nonatomic) IBOutlet CustomTextField *des1Field;
@property (weak, nonatomic) IBOutlet CustomTextField *des2Field;
@property (weak, nonatomic) IBOutlet CustomTextField *des3Field;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property (strong, nonatomic) IBOutlet UIPickerView *dataPicker;

@property (nonatomic, strong) UIDatePicker *timePicker;
- (IBAction)submitAction:(UIButton *)sender;
@end
