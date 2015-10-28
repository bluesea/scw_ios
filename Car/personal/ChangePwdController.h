//
//  ChangePwdController.h
//  Car
//
//  Created by Leon on 9/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePwdController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UITextField *oldPwd;
@property (weak, nonatomic) IBOutlet UITextField *nPwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;

@property (nonatomic, assign) BOOL firstChange;

- (IBAction)cancelAction:(UIButton *)sender;
- (IBAction)submitAction:(UIButton *)sender;

@end
