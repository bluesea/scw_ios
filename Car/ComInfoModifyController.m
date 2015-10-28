//
//  ComInfoModifyController.m
//  Car
//
//  Created by Leon on 11/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ComInfoModifyController.h"
#import "CustomTextField.h"
#import "UploadView.h"
#import "AreaUtil.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"

@interface ComInfoModifyController () <UploadViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//UI
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet CustomTextField *comType;
@property (weak, nonatomic) IBOutlet CustomTextField *comSubtype;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet CustomTextField *province;
@property (weak, nonatomic) IBOutlet CustomTextField *city;
@property (weak, nonatomic) IBOutlet CustomTextField *district;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *corp;
@property (weak, nonatomic) IBOutlet UITextField *money;

@property (weak, nonatomic) IBOutlet UITextField *licenseNo;
@property (weak, nonatomic) IBOutlet UITextField *orgNo;
@property (weak, nonatomic) IBOutlet UITextField *taxregNo;

@property (weak, nonatomic) IBOutlet UITextField *contact;
@property (weak, nonatomic) IBOutlet UITextField *contactTel;
@property (weak, nonatomic) IBOutlet UITextField *contactPhone;
@property (weak, nonatomic) IBOutlet UITextField *contactPostcode;

//图片
@property (weak, nonatomic) IBOutlet UploadView *licenseImg;
@property (weak, nonatomic) IBOutlet UploadView *orgImg;
@property (weak, nonatomic) IBOutlet UploadView *taxImg;
@property (weak, nonatomic) IBOutlet UploadView *logoImg;

@property (nonatomic, assign) NSInteger imgViewTag;
@property (nonatomic, assign) NSInteger customFieldTag;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger proId;
@property (nonatomic, assign) NSInteger cityId;

@property (nonatomic, copy) NSString *comTypeId;
@property (nonatomic, copy) NSString *comSubtypeId;

@property (nonatomic, weak) UIPickerView *dataPicker;
@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *comTypeArray;
@property (nonatomic, strong) NSArray *comSubTypeArray;


- (IBAction)submitAction;

@end

@implementation ComInfoModifyController

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

    [self initUI];
    
    [self initData];
}
- (void)initUI{
    
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    _dataPicker = pickerView;
    _dataPicker.dataSource = self;
    _dataPicker.delegate = self;
    
    _province.inputView = pickerView;
    _city.inputView = pickerView;
    _district.inputView = pickerView;
    
    
    _logoImg.uploadViewDelegate = self;
    _licenseImg.uploadViewDelegate = self;
    _taxImg.uploadViewDelegate = self;
    _orgImg.uploadViewDelegate = self;
    
    _comType.text = _company.comTypeName;
    _comSubtype.text  = _company.comSubTypeName;
    _name.text = _company.name;
    _address.text = _company.address;
    _corp.text = _company.corp;
    _money.text = [NSString stringWithFormat:@"%@",_company.money];
    _licenseNo.text = _company.licenseNo;
    _orgNo.text = _company.orgNo;
    _taxregNo.text = _company.taxregNo;
    _contact.text = _company.contact;
    _contactPhone.text = _company.contactPhone;
    _contactTel.text = _company.contactTel;
    _contactPostcode.text = _company.contactPostcode;
    _province.text = _company.province;
    _city.text = _company.city;
    _district.text = _company.district;
//    [_licenseImg.img sd_setImageWithURL:[NSURL URLWithString:_company.licensePhoto]];
//    [_taxImg.img sd_setImageWithURL:[NSURL URLWithString:_company.taxregPhoto]];
//    [_orgImg.img sd_setImageWithURL:[NSURL URLWithString:_company.orgPhoto]];
//    [_logoImg.img sd_setImageWithURL:[NSURL URLWithString:_company.headPicUrl]];
    
    
    NSArray *array = [self.mainScrollView subviews];
    for (UIView *subview  in array){
        NSArray *subArray = [subview subviews];
        for (UIView *sub in subArray){
            if ([sub isKindOfClass:[UITextField class]]){
                ((UITextField *)sub).delegate = self;
                if ([sub isKindOfClass:[CustomTextField class]]){
                    ((UITextField *)sub).inputView = _dataPicker;
                }
            }
        }
    }
}


- (void)initData{
    _provinceArray = [[AreaUtil shareInstance] getProvinceArray];
    
    _proId = [_provinceArray indexOfObject:_company.province];
    _cityId = [[[AreaUtil shareInstance]getCityArrayByProId:_proId] indexOfObject:_company.city];

}


#pragma mark - UploadViewDelegate
- (void)uploadViewClickUpload:(UploadView *)uploadView btn:(UIButton *)upBtn{
    
    _imgViewTag = uploadView.tag;
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
    UploadView *view = (UploadView *)[self.view viewWithTag:_imgViewTag];
    [view.img setImage:image];
    [view.upBtn setTitle:@"更改照片" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - PickerView Delegate

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
    UITextField *field = (UITextField *)[self.view viewWithTag:_customFieldTag];
    field.text =  [_dataArray objectAtIndex:row];
    //    field.text = [_dataArray objectAtIndex:row];
    field.selectedTextRange = 0;
    switch (_customFieldTag) {
        case 203:
            _proId= row;
            self.city.enabled = YES;
            [self.city becomeFirstResponder];
            self.district.enabled = NO;
            self.city.text = @"";
            self.district.text = @"";
            break;
        case 204:
            _cityId = row;
            self.district.enabled = YES;
            [self.district becomeFirstResponder];
            self.district.text = @"";
            break;
        default:
            break;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _customFieldTag = textField.tag;
    if ([textField isKindOfClass:[CustomTextField class]]){
        switch (_customFieldTag) {
            case 203:
                _dataArray = _provinceArray;
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

#define check(value,msg,key,element)  if (value.length == 0){AlertTitle(msg);[element becomeFirstResponder];return;} else {[param setObject:value forKey:key];}

- (IBAction)submitAction {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSString *name = [self.name.text trimBlank];
    check(name, @"请填写公司名称", @"name", self.name);
    
    NSString *province = [self.province.text trimBlank];
    check(province, @"请选择公司省份", @"province", self.province)
    NSString *city = [self.city.text trimBlank];
    check(city, @"请选择公司城市", @"city", self.city);
    NSString *district = [self.district.text trimBlank];
    check(district, @"请选择公司区县", @"district", self.district)
    
    NSString *companyAddress = [self.address.text trimBlank];
    check(companyAddress, @"请填写公司详细地址", @"address", self.address)
    
    NSString *corp = [self.corp.text trimBlank];
    check(corp, @"请填写企业法人", @"corp", self.corp)
    
    NSString *money = [self.money.text trimBlank];
    check(money, @"请填写注册资金", @"money", self.money)
    
    NSString *licenseNo = [self.licenseNo.text trimBlank];
    check(licenseNo, @"请填写营业执照代码", @"licenseNo", self.licenseNo)
    
    NSString *orgNo = [self.orgNo.text trimBlank];
    check(orgNo, @"请填写组织机构代码", @"orgNo", self.orgNo)
    
    NSString *taxregNo = [self.taxregNo.text trimBlank];
    check(taxregNo, @"请填写税务登记代码", @"taxregNo", self.taxregNo)
    
    [param setValue:self.contact.text forKey:@"contact"];
    [param setValue:self.contactTel.text forKey:@"contactTel"];
    [param setValue:self.contactPhone.text forKey:@"contactPhone"];
    [param setValue:self.contactPostcode.text forKey:@"contactPostcode"];
    [param setValue:[NSNumber numberWithInteger:_company.id] forKey:@"id"];
    
    NSMutableArray *fileArray = [NSMutableArray array];
    
    if (self.licenseImg.img.image != nil){
        [fileArray addObject:@{@"img":self.licenseImg.img.image,
                               @"name":@"licensePhotoFile"}];
    }
    if (self.orgImg.img.image != nil){
        [fileArray addObject:@{@"img":self.orgImg.img.image,
                               @"name":@"orgPhotoFile"}];
    }
    if (self.taxImg.img.image != nil){
        [fileArray addObject:@{@"img":self.taxImg.img.image,
                               @"name":@"taxregPhotoFile"}];
    }
    if (self.logoImg.img.image != nil){
        [fileArray addObject:@{@"img":self.logoImg.img.image,
                               @"name":@"headPicFile"}];
    }
    
    [MBProgressHUD showMessage:@"正在提交..."];
    
    [[HttpRequest shareRequst] modifyCompyInfoWithParam:param files:fileArray success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.integerValue == 0){
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}
@end
