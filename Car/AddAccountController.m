//
//  AddAccountController.m
//  Car
//
//  Created by Leon on 10/20/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AddAccountController.h"
#import "CustomTextField.h"

@interface AddAccountController () <UIPickerViewDataSource,UIPickerViewDelegate>
//UI
@property (weak, nonatomic) IBOutlet CustomTextField *bankNameFld;
@property (weak, nonatomic) IBOutlet UITextField *accountNameFld;
@property (weak, nonatomic) IBOutlet UITextField *accountNoFld;
@property (nonatomic, weak) UIPickerView *dataPicker;

//ACTION
- (IBAction)saveAction:(UIButton *)sender;

//PARAM
@property (nonatomic, strong) NSArray *bankArray;

@end

@implementation AddAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加账号";
    _bankArray = @[@"支付宝",@"工商银行",@"交通银行",@"建设银行",@"招商银行",@"中国银行",@"农业银行",@"邮政储蓄"];
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    _dataPicker = pickerView;
    self.dataPicker.delegate = self;
    self.dataPicker.dataSource = self;
    self.bankNameFld.inputView = self.dataPicker;
}


#pragma  mark - PickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _bankArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_bankArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.bankNameFld.text = [_bankArray objectAtIndex:row];
    if(row != 0){
        self.accountNoFld.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        self.accountNoFld.keyboardType = UIKeyboardTypeDefault;
    }
}

#pragma mark - 保存
- (IBAction)saveAction:(UIButton *)sender {
    if (self.bankNameFld.text.length == 0){
        AlertTitle(@"请选择开户行!");
        return;
    }
    if (self.accountNameFld.text.length == 0){
        AlertTitle(@"请填写开户人姓名!");
        return;
    }
    if (self.accountNoFld.text.length == 0){
        AlertTitle(@"请填写开户账号!");
        return;
    }
    
    [MBProgressHUD showMessage:@"正在保存"];
    
    [[HttpRequest shareRequst] addAccountByUserId:UserDefaults(@"userId") bankName:self.bankNameFld.text accName:self.accountNameFld.text accNo:self.accountNoFld.text success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if(code.intValue == 0){
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
            
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
    
}


@end
