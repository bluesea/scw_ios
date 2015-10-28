//
//  DriverRegistViewController.m
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverRegistViewController.h"
#import "NSString+Extension.h"
#import "AreaUtil.h"


@interface DriverRegistViewController () <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

//UI
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet CustomTextField *driverType;
@property (weak, nonatomic) IBOutlet UITextField *driverAgeField;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (weak, nonatomic) IBOutlet CustomTextField *provinceField;
@property (weak, nonatomic) IBOutlet CustomTextField *cityField;
@property (weak, nonatomic) IBOutlet CustomTextField *districField;
@property (weak, nonatomic) IBOutlet UIPickerView *dataPicker;

//ACTION
- (IBAction)submit:(UIButton *)sender;
- (IBAction)selectSex:(UIButton *)sender;


//PARAM
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *driverTypes;
@property (nonatomic, strong) NSMutableDictionary *paramDic;

@property (nonatomic, assign) NSInteger proId;
@property (nonatomic, assign) NSInteger cityId;
@property (nonatomic, assign) NSInteger flag;

@end

@implementation DriverRegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"驾驶员信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self initData];
}

- (void)initUI{
    self.infoView.layer.cornerRadius = 5;
    self.submitBtn.layer.cornerRadius = 5;
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    _dataPicker = picker;
    
    self.provinceField.inputView = self.dataPicker;
    self.cityField.inputView = self.dataPicker;
    self.districField.inputView = self.dataPicker;
    self.driverType.inputView = self.dataPicker;
    self.driverType.delegate = self;
    self.provinceField.delegate = self;
    self.cityField.delegate = self;
    self.districField.delegate = self;
}

- (void)initData{
    _driverTypes = @[@"A1",@"A2",@"B1"];
    _paramDic = [NSMutableDictionary dictionary];
    _provinces = [[AreaUtil shareInstance] getProvinceArray];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_dataArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_dataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITextField *field = (UITextField *)[self.view viewWithTag:_flag];
    field.text = [_dataArray objectAtIndex:row];
    field.selectedTextRange = 0;
    switch (_flag) {
        case 10:
            _proId = row;
            self.cityField.enabled = YES;
            [self.cityField becomeFirstResponder];
            self.districField.enabled = NO;
            self.cityField.text = @"";
            self.districField.text = @"";
            break;
        case 11:
            _cityId = row;
            self.districField.enabled = YES;
            [self.districField becomeFirstResponder];
            self.districField.text = @"";
            break;
        default:
            break;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _flag = textField.tag;
    if ([textField isKindOfClass:[CustomTextField class]]){
        switch (_flag) {
            case 10:
                _dataArray = _provinces;
                break;
            case 11:
                _dataArray = [[AreaUtil shareInstance] getCityArrayByProId:_proId];
                break;
            case 12:
                _dataArray = [[AreaUtil shareInstance] getDistrictArrayProId:_proId andCityId:_cityId];
                break;
            default:
                _dataArray = _driverTypes;
                break;
        }
        [self.dataPicker reloadAllComponents];
    }
}


- (IBAction)reset:(UIButton *)sender {
    self.nameField.text = @"";
    self.ageField.text = @"";
    self.idField.text = @"";
    self.phoneField.text = @"";
    self.provinceField.text = @"";
    self.cityField.text = @"";
    self.districField.text = @"";
    [self.maleBtn setSelected:NO];
    [self.femaleBtn setSelected:NO];

    [_paramDic removeAllObjects];
    
}

#define check(value,msg,key,element)  if (value.length == 0){AlertTitle(msg);[element becomeFirstResponder];return;} else {[_paramDic setObject:value forKey:key];}

- (IBAction)submit:(UIButton *)sender {
    NSString *name = [self.nameField.text trimBlank];
    check(name,@"请填写姓名",@"name",_nameField);
    NSString *age = [self.ageField.text trimBlank];
    check(age,@"请填写年龄",@"age",_ageField);
    NSString *driveAge = [self.driverAgeField.text trimBlank];
    check(driveAge, @"请填写驾龄", @"driveAge", _driverAgeField);
    NSString *idNum = [self.idField.text trimBlank];
    check(idNum,@"请填写身份证号码",@"cardNo",_idField);
    NSString *phone = [self.phoneField.text trimBlank];
    check(phone,@"请填写联系电话",@"phone",_phoneField);
    NSString *province = self.provinceField.text;
    check(province,@"请选择省份",@"province",_provinceField);
    NSString *city = self.cityField.text;
    check(city,@"请选择城市",@"city",_cityField);
    NSString *district = self.districField.text;
    check(district,@"请选择区县",@"district",_districField);

    if([_paramDic objectForKey:@"sex"] == nil){
        [MBProgressHUD showError:@"请选择性别"];
        return;
    }
    
    [[HttpRequest shareRequst] driverApplyWithDic:_paramDic success:^(id obj) {
        LSLog(@"----");
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            [self.submitBtn setEnabled:NO];
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else  {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
        
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
    
}


- (IBAction)selectSex:(UIButton *)sender {
    if (sender == self.maleBtn){
        [_maleBtn setSelected:YES];
        [_femaleBtn setSelected:NO];
        [_paramDic setValue:@"1" forKey:@"sex"];
    } else {
        [_maleBtn setSelected:NO];
        [_femaleBtn setSelected:YES];
        [_paramDic setObject:@"2" forKey:@"sex"];
    }
}
@end
