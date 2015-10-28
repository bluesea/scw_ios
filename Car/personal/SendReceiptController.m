//
//  SendReceiptController.m
//  Car
//
//  Created by Leon on 14-9-28.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "SendReceiptController.h"
#import "UploadView.h"

@interface SendReceiptController () <UploadViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *couriers;
@property (weak, nonatomic) UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet CustomTextField *courierField;
@property (weak, nonatomic) IBOutlet UITextField *courierNumField;
- (IBAction)submitAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UploadView *uploadView;
@end

@implementation SendReceiptController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)initUI{
    UIPickerView  *picker = [[UIPickerView alloc]init];
    _pickerView.delegate = self;
    _pickerView = picker;

    self.courierField.inputView = _pickerView;
}

- (NSArray *)couriers{
    if ( _couriers == nil){
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:SCBaseData];
        _couriers = [dic valueForKey:@"couriers"];
    }
    return  _couriers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 提交请求
- (IBAction)submitAction:(UIButton *)sender {
    
    if(self.courierField.text.length ==0){
        AlertTitle(@"请选择快递公司!");
        [self.courierField becomeFirstResponder];
        return;
    }
    if(self.courierNumField.text.length == 0){
        AlertTitle(@"请填写快递单号!");
        [self.courierNumField becomeFirstResponder];
        return;
    }
    if (self.uploadView.img.image == nil){
        AlertTitle(@"请上传快递照片!");
        return;
    }
    
    [MBProgressHUD showMessage:@"正在提交"];
    
    
    NSDictionary *dic = @{
                          @"orderId":[NSString stringWithFormat:@"%d",_orderId],
                          @"courierName":self.courierField.text,
                          @"expressNo":self.courierNumField.text
                          };
    
    NSArray *fileArray = @[@{
                               @"img":self.uploadView.img.image,
                               @"name":@"expressImgFile"
                               }];
    
    [[HttpRequest shareRequst]accidentRecord:dic files:fileArray success:^(id obj) {
        
        if ([[obj objectForKey:@"code"] intValue] == 0){
            [sender setEnabled:NO];
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];    
}

- (void)uploadViewClickUpload:(UploadView *)uploadView btn:(UIButton *)upBtn{
    
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
    
    [_uploadView.img setImage:image];
    [_uploadView.upBtn setTitle:@"更改照片" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - PickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  self.couriers.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  self.couriers[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.courierField.text = self.couriers[row];
}



@end
