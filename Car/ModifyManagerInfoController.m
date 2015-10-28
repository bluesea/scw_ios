//
//  ModifyManagerInfoController.m
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ModifyManagerInfoController.h"
#import "UploadView.h"

@interface ModifyManagerInfoController ()<UploadViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UploadView *headView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

- (IBAction)sexAction:(UIButton *)sender;
- (IBAction)submitAction;


@property (nonatomic, copy) NSString *sex;

@end

@implementation ModifyManagerInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.name.text = _manager.name;
    self.age.text = [NSString stringWithFormat:@"%@",_manager.age];
    self.phone.text =_manager.phone;
    self.email.text =_manager.email;
    self.address.text = _manager.address;
    
    _headView.uploadViewDelegate = self;
    
    if (_manager.sex == 2){
        [self.femaleBtn setSelected:YES];
        _sex = @"2";
    } else {
        [self.maleBtn setSelected:YES];
        _sex = @"1";
    }
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

    [_headView.img setImage:image];
    [_headView.upBtn setTitle:@"更改照片" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)submitAction {
    [MBProgressHUD showMessage:@"正在提交"];

    NSDictionary *param = @{
                            @"userId": [NSString stringWithFormat:@"%d",_manager.managerId],
                            @"name":_name.text,
                            @"sex":_sex,
                            @"age":_age.text,
                            @"phone":_phone.text,
                            @"email":_email.text,
                            @"address":_address.text
                            };
    
    NSMutableArray *array = [NSMutableArray array];

    
    if (self.headView.img.image != nil){
        [array addObject:@{@"img":self.headView.img.image,
                           @"name":@"headPicFile"}];
    }
    
    [[HttpRequest shareRequst] managerModifyWithParam:param fileArray:array success:^(id obj) {
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
