//
//  AccidentViewController.m
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AccidentEntryController.h"
#import "UploadView.h"

@interface AccidentEntryController () <UploadViewDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, assign) NSInteger viewTag;
@property (nonatomic ,strong) NSMutableArray *fileArray;

@property (weak, nonatomic) IBOutlet UploadView *photo1;
@property (weak, nonatomic) IBOutlet UploadView *photo2;
@property (weak, nonatomic) IBOutlet UploadView *photo3;

@property (weak, nonatomic) IBOutlet UITextView *processFiled;
- (IBAction)submitAction:(UIButton *)sender;


@end

@implementation AccidentEntryController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"事故录入";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent =  NO;
    _fileArray = [NSMutableArray array];
    _photo1.uploadViewDelegate = self;
    _photo2.uploadViewDelegate = self;
    _photo3.uploadViewDelegate = self;
    //    filepath = [FilePathUtil createDirectoryWithFolderName:@"AccidentFile"];
}


#pragma mark 提交请求
- (IBAction)submitAction:(UIButton *)sender {
    //    if self.
    
    [_fileArray removeAllObjects];
    
    if (self.photo1.img.image != nil){
        NSDictionary *dic = @{
                              @"img":self.photo1.img.image,
                              @"name":@"photo1ImgFile",
                              };
        [_fileArray addObject:dic];
        
    } else {
        AlertTitle(@"请选择事故照片1!");
        return;
    }
    if (self.photo2.img.image != nil){
        NSDictionary *dic = @{
                              @"img":self.photo2.img.image,
                              @"name":@"photo2ImgFile",
                              };
        [_fileArray addObject:dic];
    } else {
        AlertTitle(@"请选择事故照片2!");
        return;
    }
    
    if (self.photo3.img.image != nil){
        NSDictionary *dic = @{
                              @"img":self.photo3.img.image,
                              @"name":@"photo3ImgFile",
                              };
        [_fileArray addObject:dic];
    } else {
        AlertTitle(@"请选择事故责任书照片!");
        return;
    }
    
    [MBProgressHUD showMessage:@"正在提交"];
    
    
    NSString *userId = UserDefaults(@"userId");
    
    NSDictionary *param = @{
                            @"process":self.processFiled.text,
                            @"userId":userId
                            };
    
    [[HttpRequest shareRequst]accidentRecord:param files:_fileArray success:^(id obj) {
        LSLog(@"----ok  :   %@",[obj objectForKey:@"msg"]);
        if ([[obj objectForKey:@"code"] intValue] == 0){
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
            [sender setEnabled:NO];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        LSLog(@"----fail");
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


@end

