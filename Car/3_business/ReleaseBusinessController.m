//
//  ReleaseBusinessViewController.m
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ReleaseBusinessController.h"
#import "NSString+Extension.h"
#import "AreaUtil.h"
#import "BusinessDetail.h"

@interface ReleaseBusinessController (){
    NSArray *driverTypeArray;
    NSArray *fuelArray;
    NSArray *carTypeArray;
    NSArray *carModelArray;
    NSArray *provinceArray;
    NSArray *carModelNames;
    
    NSInteger carTypdId;
    
    long ori1Select;
    long des1Select;
    long ori2Select;
    long des2Select;
    long sen1Selcet;
    long sen2Select;
    long rec1Select;
    long rec2Select;
    long flag;
}

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *paramDic;
@property (weak, nonatomic) UIPickerView *dataPicker;
@property (weak, nonatomic) UIDatePicker *timePicker;

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;

// business
@property (weak, nonatomic) IBOutlet CustomTextField *carTypeField;
@property (weak, nonatomic) IBOutlet CustomTextField *carModelField;
@property (weak, nonatomic) IBOutlet CustomTextField *driverTypeField;
@property (weak, nonatomic) IBOutlet CustomTextField *fuelNameField;
@property (weak, nonatomic) IBOutlet UITextField *carLongField;
@property (weak, nonatomic) IBOutlet UITextField *carWidthField;
@property (weak, nonatomic) IBOutlet UITextField *carHightField;
@property (weak, nonatomic) IBOutlet UITextField *carWeightField;
@property (weak, nonatomic) IBOutlet UITextField *seatNumField;
@property (weak, nonatomic) IBOutlet UITextField *carNumField;
@property (weak, nonatomic) IBOutlet UITextField *driverNumField;
@property (weak, nonatomic) IBOutlet CustomTextField *ori1Field;
@property (weak, nonatomic) IBOutlet CustomTextField *ori2Field;
@property (weak, nonatomic) IBOutlet CustomTextField *ori3Field;
@property (weak, nonatomic) IBOutlet UITextField *oriInfoField;
@property (weak, nonatomic) IBOutlet CustomTextField *des1Field;
@property (weak, nonatomic) IBOutlet CustomTextField *des2Field;
@property (weak, nonatomic) IBOutlet CustomTextField *des3Field;
@property (weak, nonatomic) IBOutlet UITextField *desInfoField;
@property (weak, nonatomic) IBOutlet CustomTextField *stimeField;
@property (weak, nonatomic) IBOutlet CustomTextField *etimeField;
@property (weak, nonatomic) IBOutlet UITextField *schedateField;
@property (weak, nonatomic) IBOutlet UITextField *transfeeField;

//sender
@property (weak, nonatomic) IBOutlet UITextField *senderField;
@property (weak, nonatomic) IBOutlet UITextField *senderPhoneField;
@property (weak, nonatomic) IBOutlet CustomTextField *sen1Field;
@property (weak, nonatomic) IBOutlet CustomTextField *sen2Field;
@property (weak, nonatomic) IBOutlet CustomTextField *sen3Field;
@property (weak, nonatomic) IBOutlet UITextField *senInfoField;

//receiver
@property (weak, nonatomic) IBOutlet UITextField *receiverField;
@property (weak, nonatomic) IBOutlet UITextField *receiverPhoneField;
@property (weak, nonatomic) IBOutlet CustomTextField *rec1Field;
@property (weak, nonatomic) IBOutlet CustomTextField *rec2Field;
@property (weak, nonatomic) IBOutlet CustomTextField *rec3Field;
@property (weak, nonatomic) IBOutlet UITextField *recInfoField;

//remark
@property (weak, nonatomic) IBOutlet UITextView *remarkField;


@property (nonatomic, strong) BusinessDetail *business;

- (IBAction)submitAction:(UIButton *)sender;


@end

@implementation ReleaseBusinessController

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
    [self initUI];
    
    [self initData];
}

- (void)initUI{
    
    if (_modifyBusiness){
        self.title = @"业务修改";
        
        [MBProgressHUD showMessage:@"正在加载..."];
        [self.mainView setHidden:YES];
    } else {
        CGRect frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height- 64);
        
        UIWebView *webView  = [[UIWebView alloc]initWithFrame:frame];
        webView.tag = 1234;
        [self.view addSubview:webView];
        
        NSURL *url = [NSURL URLWithString:@"http://121.40.177.96/songche/ws/app/busiNotice"];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
        UIBarButtonItem *agreeBtn = [[UIBarButtonItem alloc] initWithTitle:@"同意" style:UIBarButtonItemStyleDone target:self action:@selector(agree)];
        self.navigationItem.rightBarButtonItem = agreeBtn;
        
        self.title = @"业务发布须知";
        
    }

    
    self.mainView.contentSize = CGSizeMake(320, 1140);
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    _dataPicker = pickerView ;
    _dataPicker.delegate = self;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    _timePicker = datePicker;
    _timePicker.datePickerMode = UIDatePickerModeDate;
    _timePicker.timeZone = [NSTimeZone localTimeZone];
    [_timePicker addTarget:self action:@selector(dateSelect) forControlEvents:UIControlEventValueChanged];
    
    [self setFieldDelegate];
    
    _stimeField.inputView = _timePicker;
    _etimeField.inputView = _timePicker;
    
    _paramDic = [NSMutableDictionary dictionary];
}

- (void)setFieldDelegate{
    int  i = 0;
    NSArray *array = [self.mainView subviews];
    for (UIView *subview  in array){
        NSArray *subArray = [subview subviews];
        for (UIView *sub in subArray){
            if ([sub isKindOfClass:[UITextField class]]){
                ((UITextField *)sub).delegate = self;
                if ([sub isKindOfClass:[CustomTextField class]]){
                    ((UITextField *)sub).inputView = _dataPicker;
                }
                i++;
            }
        }
    }
    LSLog(@"count: %d", i);
}

- (void)initData{
    driverTypeArray = @[@"A1",@"A2",@"B1"];
    
    provinceArray = [[AreaUtil shareInstance] getProvinceArray];
    
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:SCBaseData];
    
    fuelArray = [dic valueForKey:@"fuels"];
    
    carTypeArray = [dic valueForKey:@"carTypes"];
    
    carModelArray = [dic valueForKeyPath:@"carModels"];
    
    if (_modifyBusiness) {
        [[HttpRequest shareRequst] getBusinessDetailForModifyWithId:_bzId success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                BusinessDetail *bz = [BusinessDetail businessDetailWithDic:[[obj valueForKey:@"record"] valueForKey:@"business"]];
                _business = bz;
                [self initUIWithData:bz];

            } else {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    }
    
    
}

- (void) initUIWithData:(BusinessDetail *)bz{
    _carTypeField.text = bz.carTypeName;
    _carModelField.text = bz.carModelName;
    _driverTypeField.text = bz.driverType;
    _driverTypeField.enabled = NO;
    _fuelNameField.text = bz.fuelName;
    _carLongField.text = [NSString stringWithFormat:@"%@",bz.carLong];
    _carHightField.text=  [NSString stringWithFormat:@"%@",bz.carHight];
    _carNumField.text =  [NSString stringWithFormat:@"%d",bz.carNum];
    _seatNumField.text =  [NSString stringWithFormat:@"%d",bz.seatNum];
    _driverNumField.text = [NSString stringWithFormat:@"%d",bz.driverNum];
    _carWeightField.text =  [NSString stringWithFormat:@"%@",bz.carWeight];
    _carWidthField.text =  [NSString stringWithFormat:@"%@",bz.carWidth];
    _transfeeField.text = [NSString stringWithFormat:@"%@",bz.transfee];
    
    _ori1Field.text = bz.ori1;
    _ori2Field.text = bz.ori2;
    _ori2Field.enabled = YES;
    _ori3Field.text = bz.ori3;
    _ori3Field.enabled = YES;
    _oriInfoField.text = bz.oriInfo;
    _des1Field.text = bz.des1;
    _des2Field.text = bz.des2;
    _des2Field.enabled = YES;
    _des3Field.text = bz.des3;
    _des3Field.enabled = YES;
    _desInfoField.text =bz.desInfo;
    
    ori1Select = [provinceArray indexOfObject:bz.ori1];
    ori2Select = [[[AreaUtil shareInstance]getCityArrayByProId:ori1Select] indexOfObject:bz.ori2];
    
    des1Select = [provinceArray indexOfObject:bz.des1];
    des2Select = [[[AreaUtil shareInstance]getCityArrayByProId:des1Select] indexOfObject:bz.des2];
    

    
    _stimeField.text = [NSString stringWithFormat:@"%@ 00:00:00",bz.stime];
    _etimeField.text = [NSString stringWithFormat:@"%@ 00:00:00",bz.etime];
    
    _schedateField.text = [NSString stringWithFormat:@"%@",bz.schedate];
    
    _senderField.text = bz.sender;
    _sen1Field.text = bz.sen1;
    _sen2Field.text = bz.sen2;
    _sen3Field.text = bz.sen3;
    _senderPhoneField.text = bz.senderPhone;
    _senInfoField.text = bz.senInfo;
    
    _receiverField.text = bz.receiver;
    _rec1Field.text = bz.rec1;
    _rec2Field.text = bz.rec2;
    _rec3Field.text = bz.rec3;
    _receiverPhoneField.text = bz.receiverPhone;
    _recInfoField.text = bz.recInfo;
    
    if (bz.sen1.length > 0 ){
        sen1Selcet = [provinceArray indexOfObject:bz.sen1];
        _sen2Field.enabled = YES;
        if (bz.sen2.length > 0){
            sen2Select = [[[AreaUtil shareInstance]getCityArrayByProId:sen1Selcet] indexOfObject:bz.sen2];
            _sen3Field.enabled =YES;
        }
    }
    
    if (bz.rec1.length > 0 ){
        rec1Select = [provinceArray indexOfObject:bz.rec1];
        _rec2Field.enabled = YES;
        if (bz.rec2.length > 0){
            sen2Select = [[[AreaUtil shareInstance]getCityArrayByProId:rec2Select] indexOfObject:bz.rec2];
            _rec3Field.enabled =YES;
        }
    }
    
    self.mainView.hidden = NO;
    
    [MBProgressHUD hideHUD];
    
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
        case 1:
            carTypdId = [[[carTypeArray objectAtIndex:row] valueForKeyPath:@"id"]integerValue];
            [self filterCarModelNames];
            self.carModelField.text = @"";
            break;
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
        case 30:
            sen1Selcet = row;
            self.sen2Field.enabled = YES;
            [self.sen2Field becomeFirstResponder];
            self.sen3Field.enabled = NO;
            self.sen2Field.text = @"";
            self.sen3Field.text = @"";
            break;
        case 40:
            rec1Select = row;
            self.rec2Field.enabled = YES;
            [self.rec2Field becomeFirstResponder];
            self.rec3Field.enabled = NO;
            self.rec2Field.text = @"";
            self.rec3Field.text = @"";
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
        case 31:
            sen2Select = row;
            self.sen3Field.enabled = YES;
            [self.sen3Field becomeFirstResponder];
            self.sen3Field.text = @"";
            break;
        case 41:
            rec2Select= row;
            self.rec3Field.enabled = YES;
            [self.rec3Field becomeFirstResponder];
            self.rec3Field.text = @"";
            break;
        default:
            break;
    }
}

- (void)filterCarModelNames{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"carTypeId =  %d",carTypdId];
    carModelNames  = [[carModelArray filteredArrayUsingPredicate:predicate] valueForKeyPath:@"name"];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    flag = textField.tag;
    if ([textField isKindOfClass:[CustomTextField class]]){
        switch (flag) {
            case 1:
                _dataArray = [carTypeArray valueForKeyPath:@"name"];
                break;
            case 2:
                _dataArray = carModelNames ;
                break;
            case 3:
                _dataArray = driverTypeArray;
                break;
            case 4:
                _dataArray = fuelArray;
                break;
            case 10:
            case 20:
            case 30:
            case 40:
                _dataArray = provinceArray;
                break;
            case 11:
                _dataArray = [[AreaUtil shareInstance]getCityArrayByProId:ori1Select];
                break;
            case 21:
                _dataArray = [[AreaUtil shareInstance]getCityArrayByProId:des1Select];
                break;
            case 31:
                _dataArray = [[AreaUtil shareInstance]getCityArrayByProId:sen1Selcet];
                break;
            case 41:
                _dataArray = [[AreaUtil shareInstance]getCityArrayByProId:rec1Select];
                break;
            case 12:
                _dataArray = [[AreaUtil shareInstance]getDistrictArrayProId:ori1Select andCityId:ori2Select];
                break;
            case 22:
                _dataArray = [[AreaUtil shareInstance]getDistrictArrayProId:des1Select andCityId:des2Select];
                break;
            case 32:
                _dataArray = [[AreaUtil shareInstance]getDistrictArrayProId:sen1Selcet andCityId:sen2Select];
                break;
            case 42:
                _dataArray = [[AreaUtil shareInstance]getDistrictArrayProId:rec1Select andCityId:rec2Select];
                break;
            default:
                break;
        }
        [self.dataPicker reloadAllComponents];
    }
}

- (void)dateSelect{
    UITextField *field = (UITextField *)[self.view viewWithTag:flag];
    //    field.text = [_dataArray objectAtIndex:row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSString *time = [dateFormatter stringFromDate:self.timePicker.date];
    field.text = time;
    //    [self.paramDic setObject:stime forKey:@"stime"];
}

#define check(value,msg,key,element)  if (value.length == 0){AlertTitle(msg);[element becomeFirstResponder];return;} else {[_paramDic setObject:value forKey:key];}


#pragma mark - 发布业务
- (IBAction)submitAction:(UIButton *)sender {
    
    [_paramDic removeAllObjects];
    
    if(_modifyBusiness){
        [_paramDic setValue:[NSString stringWithFormat:@"%d",_business.id]  forKeyPath:@"id"];
        [_paramDic setValue:[NSString stringWithFormat:@"%d",_business.status] forKeyPath:@"status"];
        [_paramDic setValue:_business.ctime forKeyPath:@"ctime"];
        [_paramDic setValue:_business.seqNo forKeyPath:@"seqNo"];
    }
    
    NSString *carTypeName = self.carTypeField.text;
    check(carTypeName, @"请选择业务车型", @"carTypeName", _carTypeField);
    
    NSString *carModelName = self.carModelField.text;
    check(carModelName, @"请选择规格", @"carModelName", _carModelField);
    
    NSString *driverType = self.driverTypeField.text;
    check(driverType, @"请选择准驾车型", @"driverType", _driverTypeField);
    
    NSString *fuelName = self.fuelNameField.text;
    check(fuelName, @"请选择燃料类型", @"fuelName",_fuelNameField);
    
    [_paramDic setObject:[self.carLongField.text trimBlank] forKey:@"carLong"];
    [_paramDic setObject:[self.carWidthField.text trimBlank] forKey:@"carWidth"];
    [_paramDic setObject:[self.carHightField.text trimBlank] forKey:@"carHight"];
    [_paramDic setObject:[self.seatNumField.text trimBlank] forKey:@"seatNum"];
    
    NSString *carWeight = [self.carWeightField.text trimBlank];
    check(carWeight, @"请填写吨位", @"carWeight", _carWeightField);
    
    NSString *carNum = [self.carNumField.text trimBlank];
    check(carNum, @"请填写车数", @"carNum", _carNumField);
    
    NSString *driverNum = [self.driverNumField.text trimBlank];
    check(driverNum, @"请填写驾驶员数量", @"driverNum", _driverNumField);
    
    NSString *ori1 = self.ori1Field.text;
    check(ori1, @"请选择始发省份", @"ori1", _ori1Field);
    NSString *ori2 = self.ori2Field.text;
    check(ori2, @"请选择始发城市", @"ori2", _ori2Field);
    NSString *ori3 = self.ori3Field.text;
    check(ori3, @"请选择始发区县", @"ori3", _ori3Field);
    [_paramDic setObject:[self.oriInfoField.text trimBlank] forKey:@"oriInfo"];
    
    NSString *des1= self.des1Field.text;
    check(des1, @"请选择目的省份", @"des1", _des1Field);
    NSString *des2 = self.des2Field.text;
    check(des2, @"请选择目的城市", @"des2", _des2Field);
    NSString *des3 = self.des3Field.text;
    check(des3, @"请选择目的区县", @"des3", _des3Field);
    [_paramDic setObject:[self.desInfoField.text trimBlank] forKey:@"desInfo"];
    
    NSString *stime = self.stimeField.text;
    check(stime, @"请选择始发时间", @"stime", _stimeField);
    NSString *etime = self.etimeField.text;
    check(etime, @"请选择到达时间", @"etime", _etimeField);
    [_paramDic setObject:[self.schedateField.text trimBlank] forKey:@"schedate"];
    
    NSString *transfee = [self.transfeeField.text trimBlank];
    check(transfee, @"请填写承运费用", @"transfee", _transfeeField);
    
    NSString *sendername = [self.senderField.text trimBlank];
    check(sendername, @"请填写发车人", @"sender", _senderField);
    NSString *senderPhone = [self.senderPhoneField.text trimBlank];
    check(senderPhone, @"请填写发车人手机号码", @"senderPhone", _senderPhoneField);
    [_paramDic setObject:self.sen1Field.text forKey:@"sen1"];
    [_paramDic setObject:self.sen2Field.text forKey:@"sen2"];
    [_paramDic setObject:self.sen3Field.text forKey:@"sen3"];
    [_paramDic setObject:self.senInfoField.text forKey:@"senInfo"];
    
    NSString *receiver = [self.receiverField.text trimBlank];
    check(receiver, @"请填写接车人", @"receiver", _receiverField);
    NSString *receiverPhone = [self.receiverPhoneField.text trimBlank];
    check(receiverPhone, @"请填写接车人手机号码", @"receiverPhone", _receiverPhoneField);
    [_paramDic setObject:self.rec1Field.text forKey:@"rec1"];
    [_paramDic setObject:self.rec2Field.text forKey:@"rec2"];
    [_paramDic setObject:self.rec3Field.text forKey:@"rec3"];
    [_paramDic setObject:self.recInfoField.text forKey:@"recInfo"];
    
    [_paramDic setObject:[self.remarkField.text trimBlank] forKey:@"remark"];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    //    [_paramDic setObject:[NSString stringWithFormat:@"%@",userId] forKey:@"userId1"];
    //    [_paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"comId"] forKey:@"comId"];
    [MBProgressHUD showMessage:@"正在提交..."];
    
    [[HttpRequest shareRequst] savaorupdateBzWithParam:_paramDic userId:userId success:^(id obj) {
        //        LSLog(@"%@",obj);
        //        ShowAlert([obj objectForKey:@"msg"], nil, @"确定");
        if ( [[obj objectForKey:@"code"] intValue] == 0){
            
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
            
            [sender setEnabled:NO];
            
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];;
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
    
    
}


- (void)agree{
    UIView *view = [self.view viewWithTag:1234];
    [view removeFromSuperview];
    self.navigationItem.rightBarButtonItem = nil;
    self.title = @"发布业务";
}

@end
