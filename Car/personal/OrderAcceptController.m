//
//  OrderAcceptController.m
//  Car
//
//  Created by Leon on 14-9-29.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "OrderAcceptController.h"
#import "UploadView.h"

@interface OrderAcceptController () <UploadViewDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, assign) NSInteger viewTag;

@property (weak, nonatomic) IBOutlet UploadView *receiptImg;
@property (weak, nonatomic) IBOutlet UploadView *mancarImg;

- (IBAction)submitAction:(UIButton *)sender;


@end

@implementation OrderAcceptController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认收货";
    _receiptImg.uploadViewDelegate = self;
    _mancarImg.uploadViewDelegate = self;
}



#pragma mark 提交请求
- (IBAction)submitAction:(UIButton *)sender {
    //    if self.
    
    if (self.receiptImg.img.image == nil){
        AlertTitle(@"请上传签字回单照片!");
        return;
    }
    if (self.mancarImg.img.image == nil){
        AlertTitle(@"请上传人车合影照片!!");
        return;
    }
    
    NSDictionary *param = @{
                            @"orderId":[NSString stringWithFormat:@"%d",_orderId]
                            };
    
    NSArray *fileArray = @[@{
                               @"img":self.receiptImg.img.image,
                               @"name":@"receiptImgFile"
                               },@{
                               @"img":self.mancarImg.img.image,
                               @"name":@"mancarImgFile"
                               }];
    
    
    [[HttpRequest shareRequst]accidentRecord:param files:fileArray success:^(id obj) {
        LSLog(@"----ok  :   %@",[obj objectForKey:@"msg"]);
        AlertTitle([obj objectForKey:@"msg"]);
        if ([[obj objectForKey:@"code"] intValue] == 0){
            [sender setEnabled:NO];
        }
    } fail:^(NSString *errorMsg) {
        LSLog(@"----fail");
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
#pragma mark - ImagePicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UploadView *view = (UploadView *)[self.view viewWithTag:_viewTag];
    [view.img setImage:image];
    [view.upBtn setTitle:@"更改照片" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}




@end
