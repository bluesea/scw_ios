//
//  AddEmployeeController.m
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AddEmployeeController.h"
#import "NSString+Extension.h"

@interface AddEmployeeController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

@property (nonatomic, copy) NSString *sex;

- (IBAction)sexAction:(UIButton *)sender;

- (IBAction)saveAction;

@end

@implementation AddEmployeeController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sex = @"1";
    self.title = @"添加员工";
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChange) name:UITextFieldTextDidChangeNotification object:self.usernameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChange) name:UITextFieldTextDidChangeNotification object:self.passwordField];
}

- (void) textInputChange{
    self.saveBtn.enabled = (self.nameField.text.length && self.phoneField.text.length && self.usernameField.text.length && self.passwordField.text.length >= 6);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)sexAction:(UIButton *)sender {
    if (sender == self.maleBtn){
        [_maleBtn setSelected:YES];
        [_femaleBtn setSelected:NO];
        _sex = @"1";
    } else {
        [_maleBtn setSelected:NO];
        [_femaleBtn setSelected:YES];
        _sex = @"2";
    }
    LSLog(@"sex == %@" ,_sex);
}


- (IBAction)saveAction {
    [MBProgressHUD showMessage:@"正在保存"];
    
    NSDictionary *param = @{
                            @"name":self.nameField.text,
                            @"sex":_sex,
                            @"phone":self.phoneField.text,
                            @"loginname":self.usernameField.text,
                            @"password":[self.passwordField.text md5Encryption]
                            };
    
    
    [[HttpRequest shareRequst] addManagerWithParam:param userId:UserDefaults(@"userId") success:^(id obj) {
        NSInteger code = [[obj valueForKey:@"code"] integerValue];
        if (code == 0){
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
    
}
@end
