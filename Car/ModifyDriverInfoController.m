//
//  ModifyDriverInfoController.m
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ModifyDriverInfoController.h"
#import "UploadView.h"


@interface ModifyDriverInfoController ()<UploadViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy) NSString *sex;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *driverType;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

@property (weak, nonatomic) IBOutlet UITextField *qualificationNo;
@property (weak, nonatomic) IBOutlet UITextField *licenseNo;

@property (weak, nonatomic) IBOutlet UploadView *head;
@property (weak, nonatomic) IBOutlet UploadView *photo;
@property (weak, nonatomic) IBOutlet UploadView *cardPhoto;
@property (weak, nonatomic) IBOutlet UploadView *qualificationPhoto;
@property (weak, nonatomic) IBOutlet UploadView *licensePhoto;

@property (nonatomic, assign) NSInteger viewTag;

@property (nonatomic, strong) NSArray *driverTypes;



- (IBAction)sexAction:(UIButton *)sender;
- (IBAction)submitAction;

@end

@implementation ModifyDriverInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.name.text = _driver.name;
    self.phone.text = _driver.phone;
    self.driverType.text = _driver.driverType;
    self.qualificationNo.text = _driver.qualificationNo;
    self.licenseNo.text = _driver.licenseNo;
    if (_driver.sex == 1){
        [self.maleBtn setSelected:YES];
    } else {
        [self.femaleBtn setSelected:YES];
    }
    
    _sex = [NSString stringWithFormat:@"%d",_driver.sex];
    
    UIPickerView *dataPicker = [[UIPickerView alloc] init];
    self.driverType.inputView = dataPicker;
    dataPicker.delegate = self;
    dataPicker.dataSource = self;
    
    _head.uploadViewDelegate = self;
    _cardPhoto.uploadViewDelegate = self;
    _photo.uploadViewDelegate = self;
    _licensePhoto.uploadViewDelegate = self;
    _qualificationPhoto.uploadViewDelegate = self;
}

- (NSArray *)driverTypes{
    if (_driverTypes == nil){
        _driverTypes = @[@"A1",@"A2",@"B1"];
    }
    return _driverTypes;
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

- (IBAction)submitAction {
    [MBProgressHUD showMessage:@"正在提交信息..."];
    
    NSDictionary *param = @{
                            @"userId":[NSString stringWithFormat:@"%d",_driver.driverId],
                            @"name":_name.text,
                            @"driverType":_driverType.text,
                            @"sex":_sex,
                            @"qualificationNo":_qualificationNo.text,
                            @"licenseNo":_licenseNo.text
                            };
    NSMutableArray *array = [NSMutableArray array];
//
//    DriverModel *driver = [[DriverModel alloc] init];
//    driver.name = _driver.name;
//    driver.driverType = _driverType.text;
//    driver.sex = [_sex integerValue];
//    driver.qualificationNo = _qualificationNo.text;
//    driver.licenseNo = _licenseNo.text;
    
    if (self.head.img.image != nil){
        [array addObject:@{@"img":self.head.img.image,
                          @"name":@"headPicFile"}];
    }
    if (self.photo.img.image != nil){
        [array addObject:@{@"img":self.photo.img.image,
                           @"name":@"photoFile"}];
    }
    if (self.cardPhoto.img.image != nil){
        [array addObject:@{@"img":self.cardPhoto.img.image,
                           @"name":@"cardPhotoFile"}];
    }
    if (self.qualificationPhoto.img.image != nil){
        [array addObject:@{@"img":self.qualificationPhoto.img.image,
                           @"name":@"qualificationPhotoFile"}];
    }
    if (self.licensePhoto.img.image != nil){
        [array addObject:@{@"img":self.licensePhoto.img.image,
                           @"name":@"licensePhotoFile"}];
    }

    LSLog(@" array : %@ ", array);
    LSLog(@" param : %@", param);
    
    
    [[HttpRequest shareRequst] driverModifyWithParam:param fileArray:array success:^(id obj) {
        [MBProgressHUD showError:[obj valueForKey:@"msg"]];
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
    UploadView *view = (UploadView *)[self.view viewWithTag:_viewTag];
    [view.img setImage:image];
    [view.upBtn setTitle:@"更改照片" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.driverTypes.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.driverTypes[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.driverType.text = self.driverTypes[row];
}

@end
