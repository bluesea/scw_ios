//
//  CompanyRegistViewController.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "CompanyRegistViewController.h"
#import "AreaUtil.h"
#import "NSString+Extension.h"
#import "UploadView.h"
#import "ComType.h"
#import "ComSubType.h"
#import "CustomTextField.h"

@interface CompanyRegistViewController () <UploadViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (nonatomic, weak) IBOutlet UIView *picView;

//UI

@property (nonatomic, weak) UIWebView *webView;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;


@property (weak, nonatomic) IBOutlet UploadView *licensePhoto;
@property (weak, nonatomic) IBOutlet UploadView *orgPhoto;
@property (weak, nonatomic) IBOutlet UploadView *taxRegPhoto;
@property (weak, nonatomic) IBOutlet UploadView *logoPhoto;

@property (weak, nonatomic) IBOutlet CustomTextField *comTypeField;
@property (weak, nonatomic) IBOutlet CustomTextField *comSubTypeField;
@property (weak, nonatomic) IBOutlet UITextField *compangNameField;
@property (weak, nonatomic) IBOutlet CustomTextField *provinceField;
@property (weak, nonatomic) IBOutlet CustomTextField *cityField;
@property (weak, nonatomic) IBOutlet CustomTextField *districtField;
@property (weak, nonatomic) IBOutlet UITextField *companyAddressField;
@property (weak, nonatomic) IBOutlet UITextField *corpField;
@property (weak, nonatomic) IBOutlet UITextField *moneyField;

@property (weak, nonatomic) IBOutlet UITextField *licenseNoField;
@property (weak, nonatomic) IBOutlet UITextField *taxRegNoField;
@property (weak, nonatomic) IBOutlet UITextField *orgNoField;


@property (weak, nonatomic) IBOutlet UITextField *contactNameField;
@property (weak, nonatomic) IBOutlet UITextField *contactTelField;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneField;
@property (weak, nonatomic) IBOutlet UITextField *contactPostcodeField;

//@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

//Action
- (IBAction)submitAction:(UIButton *)sender;

//PARAM
@property (nonatomic, weak) UIPickerView *dataPicker;
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *comTypes;
@property (nonatomic, strong) NSArray *comSubTypes;

@property (nonatomic, assign) NSInteger viewTag;
@property (nonatomic, assign) NSInteger comTypeId;
@property (nonatomic, assign) NSInteger comSubTypeId;

@property (nonatomic, strong) NSMutableDictionary *paramDic;
@property (nonatomic, assign) NSInteger proId;
@property (nonatomic, assign) NSInteger cityId;
@property (nonatomic, assign) NSInteger textfieldTag;
@property (nonatomic, assign) BOOL pickerFlag;


@end

@implementation CompanyRegistViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *agreeBtn = [[UIBarButtonItem alloc] initWithTitle:@"同意" style:UIBarButtonItemStyleDone target:self action:@selector(agree)];
        self.navigationItem.rightBarButtonItem = agreeBtn;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"公司注册协议";

    //通过Webview加载公司协议
    CGRect frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height- 64);
    
    UIWebView *webView  = [[UIWebView alloc]initWithFrame:frame];
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"http://121.40.177.96/songche/ws/app/comAgree"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    _webView = webView;
    
    
    [self initUI];
    [self initData];
}

- (void)initData{
    
    _paramDic = [NSMutableDictionary dictionary];
    
    _provinces = [[AreaUtil shareInstance] getProvinceArray];
    
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:SCBaseData];
    
    _comTypes = [dic valueForKey:@"comTypes"];
    
    _comSubTypes = [dic valueForKey:@"comSubTypes"];

}



#pragma mark - UI
- (void)initUI{
    self.mainScrollView.contentSize = CGSizeMake(320, 1150);

    self.licensePhoto.uploadViewDelegate = self;
    self.taxRegPhoto.uploadViewDelegate = self;
    self.logoPhoto.uploadViewDelegate = self;
    self.orgPhoto.uploadViewDelegate = self;
    
    [self setFieldDelegate];
}

- (void)setFieldDelegate{
//    int  i = 0;
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    _dataPicker = pickerView;
    
    NSArray *array = [self.mainScrollView subviews];
    for (UIView *subview  in array){
        NSArray *subArray = [subview subviews];
        for (UIView *sub in subArray){
            if ([sub isKindOfClass:[UITextField class]]){
                ((UITextField *)sub).delegate = self;
                if ([sub isKindOfClass:[CustomTextField class]]){
                    ((UITextField *)sub).inputView = _dataPicker;
                }
//                i++;
            }
        }
    }
//    LSLog(@"count: %d", i);
}



#define check(value,msg,key,element)  if (value.length == 0){AlertTitle(msg);[element becomeFirstResponder];return;} else {[_paramDic setObject:value forKey:key];}

#pragma mark - IBAction
#pragma mark 提交注册
- (IBAction)submitAction:(UIButton *)sender {
    
    
    NSString *username = [self.usernameField.text trimBlank];
    check(username, @"请填写用户名", @"username", self.usernameField)
    
    NSString *email = [self.emailField.text trimBlank];
    check(email, @"请填写邮箱", @"email", self.emailField)
    
    if (self.passwordField.text.length < 6){
        AlertTitle(@"密码不能少于6位");
        [self.passwordField becomeFirstResponder];
        return;
    }
    
    NSString *password = self.passwordField.text;
    
    if (![password isEqualToString:self.confirmPasswordField.text]){
        AlertTitle(@"两次密码不一样");
        self.confirmPasswordField.text = @"";
        [self.confirmPasswordField becomeFirstResponder];
        return;
    }
    
    [_paramDic setValue:password forKey:@"password"];
    
    if (self.comTypeField.text.length == 0 ){
        AlertTitle(@"请选择企业大类");
        [self.comTypeField becomeFirstResponder];
        return;
    } else {
        [_paramDic setValue:[NSString stringWithFormat:@"%d",_comTypeId] forKey:@"comTypeId"];
    }
    
    if (self.comSubTypeField.text.length == 0 ){
        AlertTitle(@"请选择企业小类");
        [self.comSubTypeField becomeFirstResponder];
        return;
    } else {
        [_paramDic setValue:[NSString stringWithFormat:@"%d",_comSubTypeId] forKey:@"comSubTypeId"];
    }
    
    NSString *companyName = [self.compangNameField.text trimBlank];
    check(companyName, @"请填写公司名称", @"companyName", self.compangNameField)
    
    NSString *province = self.provinceField.text;
    check(province, @"请选择公司省份", @"province", _provinceField)
    NSString *city = self.cityField.text;
    check(city, @"请选择公司城市", @"city", _cityField);
    NSString *district = self.districtField.text;
    check(district, @"请选择公司区县", @"district", _districtField)
    
    NSString *companyAddress = [self.companyAddressField.text trimBlank];
    check(companyAddress, @"请填写公司详细地址", @"companyAddress", self.companyAddressField)
    
    NSString *corp = [self.corpField.text trimBlank];
    check(corp, @"请填写企业法人", @"corp", self.corpField)
    
    NSString *money = [self.moneyField.text trimBlank];
    check(money, @"请填写注册资金", @"money", self.moneyField)
    
    NSString *licenseNo = [self.licenseNoField.text trimBlank];
    check(licenseNo, @"请填写营业执照代码", @"licenseNo", self.licenseNoField)
    
    NSString *orgNo = [self.orgNoField.text trimBlank];
    check(orgNo, @"请填写组织机构代码", @"orgNo", self.orgNoField)
    
    NSString *taxregNo = [self.taxRegNoField.text trimBlank];
    check(taxregNo, @"请填写税务登记代码", @"taxregNo", self.taxRegNoField)
    
    [_paramDic setValue:self.contactNameField.text forKey:@"contactName"];
    [_paramDic setValue:self.contactTelField.text forKey:@"contactTel"];
    [_paramDic setValue:self.contactPhoneField.text forKey:@"contactPhone"];
    [_paramDic setValue:self.contactPostcodeField.text forKey:@"contactPostcode"];

    if (self.licensePhoto.img.image  == nil){
        AlertTitle(@"请上传营业执照正本照片!");
        return;
    }
    if (self.orgPhoto.img.image == nil){
        AlertTitle(@"请上传组织机构代码证照片!");
        return;
    }
    if (self.taxRegPhoto.img.image == nil){
        AlertTitle(@"请上传税务登记证照片!");
        return;
    }
    if (self.logoPhoto.img.image == nil){
        AlertTitle(@"请上传企业logo!");
        return;
    }
    
    [MBProgressHUD showMessage:@"正在提交信息"];
    
    NSArray *fielArray = @[
                           @{@"img":self.licensePhoto.img.image,
                             @"name":@"licenseImgFile"},
                           @{@"img":self.orgPhoto.img.image,
                             @"name":@"orgImgFile"},
                           @{@"img":self.taxRegPhoto.img.image,
                             @"name":@"taxregImgFile"},
                           @{@"img":self.logoPhoto.img,
                             @"name":@"logoImgFile"}
                           ];
    
    [[HttpRequest shareRequst]companyRegistWithParam:_paramDic fileArray:fielArray success:^(id obj) {

        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
            [sender setEnabled:NO];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
        
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}

- (void)uploadViewClickUpload:(UploadView *)uploadView btn:(UIButton *)upBtn{
    
    _viewTag = uploadView.tag;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"用户相册",nil];
    [actionSheet showInView:self.view];
}

#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    
    if (buttonIndex == 0)
    {
        //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if(buttonIndex == 1)
    {
        //用户相册
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else{
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType =sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

#pragma mark - ImagePicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UploadView *view = (UploadView *)[self.picView viewWithTag:_viewTag];
    [view.img setImage:image];
    [view.upBtn setTitle:@"更改照片" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
    UITextField *field = (UITextField *)[self.view viewWithTag:_textfieldTag];
    
    field.text = [_dataArray objectAtIndex:row];
    
    field.selectedTextRange = 0;
    
    switch (_textfieldTag) {
        case 201:
            _comTypeId = [(ComType *)[_comTypes objectAtIndex:row] id];
            break;
        case 202:
            _comSubTypeId = [(ComSubType *)[_comSubTypes objectAtIndex:row] id];
            break;
        case 203:
            _proId= row;
            self.cityField.enabled = YES;
            [self.cityField becomeFirstResponder];
            self.districtField.enabled = NO;
            self.cityField.text = @"";
            self.districtField.text = @"";
            break;
        case 204:
            _cityId = row;
            self.districtField.enabled = YES;
            [self.districtField becomeFirstResponder];
            self.districtField.text = @"";
            break;
        default:
            break;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _textfieldTag = textField.tag;
    if ([textField isKindOfClass:[CustomTextField class]]){
        switch (_textfieldTag) {
            case 201:
                _dataArray = [_comTypes valueForKeyPath:@"name"];
                break;
            case 202:
                _dataArray = [_comSubTypes valueForKeyPath:@"name"];
                break;
            case 203:
                _dataArray = _provinces;
                break;
            case 204:
                _dataArray = [[AreaUtil shareInstance]getCityArrayByProId:_proId];
                break;
            case 205:
                _dataArray = [[AreaUtil shareInstance]getDistrictArrayProId:_proId andCityId:_cityId];
                break;
            default:
                break;
        }
        [self.dataPicker reloadAllComponents];
    }
}


- (void)agree{
    self.title = @"公司注册";
    [_webView removeFromSuperview];
    self.navigationItem.rightBarButtonItem = nil;
}

@end
