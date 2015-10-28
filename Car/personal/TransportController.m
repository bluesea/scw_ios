//
//  TransportController.m
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "TransportController.h"
#import "AreaUtil.h"

@interface TransportController (){
    NSArray *_dataArray;
    NSArray *provinceArray;
    NSMutableDictionary *_paramDic;
    int ori1Select;
    int des1Select;
    int ori2Select;
    int des2Select;
    int flag;
}

@end

@implementation TransportController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"运力流向列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent =  NO;
    [self _initUI];
    [self _initData];
}

- (void)_initUI{

    _dataPicker = [[UIPickerView alloc] init];
    _dataPicker.delegate = self;
    
    _timePicker = [[UIDatePicker alloc]init];
    _timePicker.datePickerMode = UIDatePickerModeDate;
    _timePicker.timeZone = [NSTimeZone localTimeZone];
    [_timePicker addTarget:self action:@selector(dateSelect) forControlEvents:UIControlEventValueChanged];
    
    [self setFieldDelegate];
    
    _timeField.inputView = _timePicker;

}

- (void)setFieldDelegate{
    int  i = 0;
    NSArray *array = [self.view subviews];
    for (UIView *subview  in array){
        if ([subview isKindOfClass:[UITextField class]]){
            ((UITextField *)subview).delegate = self;
            if ([subview isKindOfClass:[CustomTextField class]]){
                ((UITextField *)subview).inputView = _dataPicker;
            }
            i++;
        }
    }
    LSLog(@"count: %d", i);
}

- (void)_initData{
    _paramDic = [NSMutableDictionary dictionary];
    provinceArray = [[AreaUtil shareInstance] getProvinceArray];
}



#pragma mark - pickerView Delegate
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
    UITextField *field = (UITextField *)[self.view viewWithTag:flag];
    field.text = [_dataArray objectAtIndex:row];
    field.selectedTextRange = 0;
    switch (flag) {
        case 10:
            ori1Select = row;
            self.ori2Field.enabled = YES;
            [self.ori2Field becomeFirstResponder];
            self.ori3Field.enabled = NO;
            self.ori2Field.text = @"";
            self.ori3Field.text = @"";
            break;
        case 20:
            des1Select = row;
            self.des2Field.enabled = YES;
            [self.des2Field becomeFirstResponder];
            self.des3Field.enabled = NO;
            self.des2Field.text = @"";
            self.des3Field.text = @"";
            break;
        case 11:
            ori2Select = row;
            self.ori3Field.enabled = YES;
            [self.ori3Field becomeFirstResponder];
            self.ori3Field.text = @"";
            break;
        case 21:
            des2Select = row;
            self.des3Field.enabled = YES;
            [self.des3Field becomeFirstResponder];
            self.des3Field.text = @"";
            break;
        default:
            break;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    flag = textField.tag;
    if ([textField isKindOfClass:[CustomTextField class]]){
        switch (flag) {
            case 10:
            case 20:
                _dataArray = provinceArray;
                break;
            case 11:
                _dataArray = [[AreaUtil shareInstance] getCityArrayByProId:ori1Select];
                break;
            case 21:
                _dataArray = [[AreaUtil shareInstance] getCityArrayByProId:des1Select];
                break;
            case 12:
                _dataArray = [[AreaUtil shareInstance] getDistrictArrayProId:ori1Select andCityId:ori2Select];
                break;
            case 22:
                _dataArray = [[AreaUtil shareInstance] getDistrictArrayProId:des1Select andCityId:des2Select];
                break;
            default:
                break;
        }
        [self.dataPicker reloadAllComponents];
//        [self.dataPicker selectedRowInComponent:0];
    }
}

- (void)dateSelect{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSString *time = [dateFormatter stringFromDate:self.timePicker.date];
    _timeField.text = time;
}

#define check(value,msg,key,element)  if (value.length == 0){AlertTitle(msg);[element becomeFirstResponder];return;} else {[_paramDic setObject:value forKey:key];}

- (IBAction)submitAction:(UIButton *)sender {
    NSString *ori1 = self.ori1Field.text;
    check(ori1, @"请选择原籍省份", @"native1", _ori1Field);
    NSString *ori2 = self.ori2Field.text;
    check(ori2, @"请选择原籍城市", @"native2", _ori2Field);
    NSString *ori3 = self.ori3Field.text;
    check(ori3, @"请选择原籍区县", @"native3", _ori3Field);
    
    NSString *des1= self.des1Field.text;
    check(des1, @"请选择预计省份", @"expect1", _des1Field);
    NSString *des2 = self.des2Field.text;
    check(des2, @"请选择预计城市", @"expect2", _des2Field);
    NSString *des3 = self.des3Field.text;
    check(des3, @"请选择预计区县", @"expect3", _des3Field);
    
    NSString *stime = self.timeField.text;
    check(stime, @"请选择预计时间", @"expectTime", _timeField);
    
    [_paramDic setValue:self.remark.text forKey:@"content"];

    
    [[HttpRequest shareRequst] flowAddWithDic:_paramDic success:^(id obj) {
        LSLog(@"------success");
        
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            [sender setEnabled:NO];
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        LSLog(@"------fail");
        [MBProgressHUD showError:errorMsg];
    }];
}
@end
