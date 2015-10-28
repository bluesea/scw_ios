//
//  BzSearchVC.m
//  Car
//
//  Created by Leon on 14-9-24.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "BzSearchVC.h"
#import "AreaUtil.h"

@interface BzSearchVC (){
    NSArray *provinceArray;
    NSMutableArray *carTypeArray;
    int flag;
    int ori1Select;
    int ori2Select;
    int des1Select;
    int des2Select;
}

@end

@implementation BzSearchVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"业务搜索";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = [[NSArray alloc]init];
    self.paramDic = [NSMutableDictionary dictionary];
    [self _initUI];
    [self _initData];
    // Do any additional setup after loading the view from its nib.
}

- (void)_initUI{
    self.ori1Field.inputView = self.dataPicker;
    self.ori2Field.inputView = self.dataPicker;
    self.ori3Field.inputView = self.dataPicker;
    self.des1Field.inputView = self.dataPicker;
    self.des2Field.inputView = self.dataPicker;
    self.des3Field.inputView = self.dataPicker;
    self.carTypeField.inputView = self.dataPicker;
    self.stimeField.inputView = self.timePicker;
    [self.dataPicker setFrame:CGRectMake(0, 0, 320, 162)];
    [self.timePicker setFrame:CGRectMake(0, 0, 320, 162)];

    [_timePicker addTarget:self action:@selector(dateSelect) forControlEvents:UIControlEventValueChanged];
}

- (void)_initData{
    _paramDic = [NSMutableDictionary dictionary];
    carTypeArray = [NSMutableArray array];
    provinceArray = [[AreaUtil shareInstance] getProvinceArray];
    
    [[HttpRequest shareRequst] getCarType:^(id obj) {
        LSLog(@"---成功");
        NSString  *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            NSArray *array = [obj objectForKey:@"records"];
            for(NSDictionary *dic in array){
                [carTypeArray addObject:[dic objectForKey:@"name"]];
            }
        }
    } fail:^(NSString *errorMsg) {
        LSLog(@"----失败");
    }];
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
            self.ori3Field.enabled = NO;
            self.ori2Field.text = @"";
            self.ori3Field.text = @"";
            break;
        case 20:
            des1Select = row;
            self.des2Field.enabled = YES;
            self.des3Field.enabled = NO;
            self.des2Field.text = @"";
            self.des3Field.text = @"";
            break;
        case 11:
            ori2Select = row;
            self.ori3Field.enabled = YES;
            self.ori3Field.text = @"";
            break;
        case 21:
            des2Select = row;
            self.des3Field.enabled = YES;
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
            case 30:
                _dataArray = carTypeArray;
                break;
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
    }
}

- (void)dateSelect{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [dateFormatter stringFromDate:self.timePicker.date];
    self.stimeField.text = time;
}

- (IBAction)searchAction:(UIButton *)sender {
    [_paramDic setObject:self.ori1Field.text forKey:@"ori1"];
     [_paramDic setObject:self.ori2Field.text forKey:@"ori2"];
     [_paramDic setObject:self.ori3Field.text forKey:@"ori3"];
     [_paramDic setObject:self.des1Field.text forKey:@"des1"];
     [_paramDic setObject:self.des2Field.text forKey:@"des2"];
     [_paramDic setObject:self.des3Field.text forKey:@"des3"];
     [_paramDic setObject:self.carTypeField.text forKey:@"carType"];
     [_paramDic setObject:self.stimeField.text forKey:@"stime"];
    
    self.block(self.paramDic);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
