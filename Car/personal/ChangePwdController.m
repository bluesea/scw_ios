//
//  ChangePwdController.m
//  Car
//
//  Created by Leon on 9/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ChangePwdController.h"
#import "NSString+Extension.h"


@interface ChangePwdController () <UIAlertViewDelegate>

@end

@implementation ChangePwdController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void)initUI{
    self.submitBtn.layer.cornerRadius = 5;
    self.cancelBtn.layer.cornerRadius = 5;
    self.mainView.layer.cornerRadius = 5;
    self.mainView.layer.borderWidth = 1;
    self.mainView.layer.borderColor = [RGBColor(209, 209, 209) CGColor];
}


- (IBAction)cancelAction:(UIButton *)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitAction:(UIButton *)sender {
    NSString *userId = UserDefaults(@"userId");
    NSString *oldPwdString = self.oldPwd.text;
    NSString *newPwdString = self.nPwd.text;
    NSString *confrimPwdString = self.confirmPwd.text;
    
    if (oldPwdString.length == 0){
        AlertTitle(@"请填写旧密码!");
        return;
    }
    if (newPwdString.length < 6){
        AlertTitle(@"密码长度不足!");
        return;
    }
    if (![newPwdString isEqualToString:confrimPwdString]){
        AlertTitle(@"两次密码不一致!");
        return;
    }
    
    [[HttpRequest shareRequst]changePwdWithUserId:userId oldPwd:[oldPwdString md5Encryption] newPwd:[newPwdString md5Encryption] success:^(id obj) {
 
        NSString  *code = [obj objectForKey:@"code"];
        if ([code intValue] == 0){
            self.oldPwd.text = @"";
            self.nPwd.text = @"";
            self.confirmPwd.text = @"";
            [self cancel];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }

    } fail:^(NSString *errorMsg) {
        LSLog(@"----请求失败!");
    }];
}

- (void)cancel{
    if (_firstChange){
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请重新登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SC_AUTO_LOGIN];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SC_REM_PWD];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotification" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
