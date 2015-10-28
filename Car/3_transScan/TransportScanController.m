//
//  TransportScanController.m
//  Car
//
//  Created by Leon on 14-10-9.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "TransportScanController.h"
#import "CustomTextField.h"
#import "AreaUtil.h"
#import "TransScanListController.h"

@interface TransportScanController (){
    NSArray *dataArray;
    NSArray *distanceArray;
    int scan1Select;
    int scan2Select;
    int textFieldTag;
}

@property (nonatomic, weak) UIPickerView *dataPicker;
@property (nonatomic, strong) NSMutableDictionary *paramDic;
@property (nonatomic, assign) double longtitude;
@property (nonatomic, assign) double latitude;

@end

@implementation TransportScanController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"运力扫描";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _paramDic = [NSMutableDictionary dictionary];
    distanceArray = @[@"100",@"200",@"300"];
//    _manager = [[CLLocationManager alloc] init];
//    _manager.delegate = self;
    [self initUI];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    LSLog(@"--->定位");
//    [_manager startUpdatingLocation];
    
    //清空所有输入框
    self.scan1Fld.text = @"";
    self.scan2Fld.text = @"";
    self.scan3Fld.text = @"";
    self.distanceFld.text =@"";
    self.nameFld.text = @"";
    self.phoneFld.text = @"";
}

- (void)initUI{
    
    self.navigationController.navigationBar.translucent = NO;
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    self.dataPicker = picker;
    
    self.scan1Fld.inputView = self.dataPicker;
    self.scan2Fld.inputView = self.dataPicker;
    self.scan3Fld.inputView = self.dataPicker;
    self.distanceFld.inputView = self.dataPicker;
    

    
}

//#pragma mark - CLLocationManagerDelegate
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    CLLocation *location = [locations lastObject];
//    
//    _latitude = location.coordinate.latitude;
//    _longtitude = location.coordinate.longitude;
//    
//    [_manager stopUpdatingLocation];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    switch (status) {
//        case kCLAuthorizationStatusNotDetermined:
//            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//                [manager requestWhenInUseAuthorization];
//            }
//            break;
//    }
//}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [dataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITextField *field = (UITextField *)[self.view viewWithTag:textFieldTag];
    field.text = [dataArray objectAtIndex:row];
    field.selectedTextRange = 0;
    switch (textFieldTag) {
        case 10:
            scan1Select = row;
            self.scan2Fld.enabled = YES;
            self.scan3Fld.enabled = NO;
            self.scan2Fld.text = @"";
            self.scan3Fld.text = @"";
            break;
        case 11:
            scan2Select = row;
            self.scan3Fld.enabled = YES;
            self.scan3Fld.text = @"";
            break;
        default:
            break;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textFieldTag = textField.tag;
    if ([textField isKindOfClass:[CustomTextField class]]){
        switch (textFieldTag) {
            case 10:
                dataArray = [[AreaUtil shareInstance] getProvinceArray];
                break;
            case 11:
                dataArray = [[AreaUtil shareInstance] getCityArrayByProId:scan1Select];
                break;
            case 12:
                dataArray = [[AreaUtil shareInstance] getDistrictArrayProId:scan1Select andCityId:scan2Select];
                break;
            default:
                dataArray = distanceArray;
                break;
        }
        [self.dataPicker reloadAllComponents];
    }
}

- (IBAction)selectAction:(UIButton *)sender {
    
    if (sender == self.allBtn){
        if(![sender isSelected]){
            self.busyBtn.selected = NO;
            self.freeBtn.selected = NO;
            self.onDutyBtn.selected = NO;
            [sender setSelected:YES];
        } else {
            [sender setSelected:NO];
        }
    } else {
        if (![sender isSelected]) {
            [self.allBtn setSelected:NO];
            [sender setSelected:YES];
        } else {
            [sender setSelected:NO];
        }
    }
}

- (IBAction)scanAction:(UIButton *)sender {
    [_paramDic removeAllObjects];
    
    [_paramDic setValue:[NSString stringWithFormat:@"%f",_longtitude]forKey:@"mylng"];
    [_paramDic setValue:[NSString stringWithFormat:@"%f",_latitude] forKey:@"mylat"];
    
    if ([self.allBtn isSelected]){
        [_paramDic setObject:@"1,2,3" forKey:@"statuses"];
    } else {
        NSMutableString *str = [NSMutableString string];
        if ([self.freeBtn isSelected]){
            [str appendString:@"1,"];
        }
        if([self.busyBtn isSelected]){
            [str appendString:@"2,"];
        }
        if ([self.onDutyBtn isSelected]){
            [str appendString:@"3,"];
        }
        if (str.length == 0){
            AlertTitle(@"请至少选择一种状态");
            return;
        }
        [_paramDic setObject:[str substringToIndex:str.length-1] forKey:@"statuses"];
    }
    
    [_paramDic setObject:self.scan1Fld.text forKey:@"scan1"];
    [_paramDic setObject:self.scan2Fld.text forKey:@"scan2"];
    [_paramDic setObject:self.scan3Fld.text forKey:@"scan3"];
    [_paramDic setObject:self.distanceFld.text forKey:@"distance"];
    [_paramDic setObject:self.nameFld.text forKey:@"name"];
    [_paramDic setObject:self.phoneFld.text forKey:@"phone"];
    [_paramDic setObject:UserDefaults(@"userId") forKey:@"userId"];
    
    TransScanListController *scanlist = [[TransScanListController alloc]init];
    scanlist.paramDic = _paramDic;
    scanlist.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:scanlist animated:YES];
    
}


@end
