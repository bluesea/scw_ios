//
//  AddDriverController.m
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AddDriverController.h"
#import "CustomTextField.h"

@interface AddDriverController () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *cardNoField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UIPickerView *dataPicker;
@property (nonatomic, strong) NSArray *driveTypeArray;
@property (weak, nonatomic) IBOutlet CustomTextField *driveType;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic, copy) NSString *sex;

- (IBAction)sexAction:(UIButton *)sender;
- (IBAction)saveAction;


@end

@implementation AddDriverController

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
    _dataPicker = [[UIPickerView alloc] init];
    _dataPicker.delegate = self;
    _driveType.inputView = _dataPicker;
    _driveTypeArray  = @[@"A1",@"A2",@"B1"];
    _sex = @"1";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChange) name:UITextFieldTextDidChangeNotification object:self.cardNoField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

- (void) textInputChange{
    self.saveBtn.enabled = (self.nameField.text.length && self.phoneField.text.length && self.phoneField.text.length && self.driveType.text.length);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_driveTypeArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_driveTypeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.driveType.text = [_driveTypeArray objectAtIndex:row];
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
                            @"cardNo":self.cardNoField.text,
                            @"driverType":self.driveType.text
                            };
    
    
    [[HttpRequest shareRequst] addDriverWithParam:param userId:UserDefaults(@"userId") success:^(id obj) {
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
