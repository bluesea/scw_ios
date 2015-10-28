//
//  ForumLoginController.m
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ForumLoginController.h"
#import "NSString+Extension.h"
#import "ForumRegistController.h"

@interface ForumLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *bbsNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)loginAction;
- (IBAction)findPwdAction;
- (IBAction)regAction;
@end

@implementation ForumLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 登录
- (IBAction)loginAction {
    NSString *name = [self.bbsNameField.text trimBlank];
    if (name.length <= 0){
        AlertTitle(@"请填写用户名");
        return;
    }
    NSString *pwd = self.passwordField.text;
    if (pwd.length <= 0){
        AlertTitle(@"请输入密码");
        return;
    }
    
    [MBProgressHUD showMessage:@"正在提交"];
    
    [[HttpRequest shareRequst] bbsLoginWithBbsName:name password:pwd success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            [MBProgressHUD hideHUD];
            [[AppDelegate shareAppdelegate] setBbsLogin:YES];
            NSDictionary *bbsUser = [[obj valueForKey:@"record"] valueForKey:@"bbsUser"];
            [[NSUserDefaults standardUserDefaults] setValue:bbsUser[@"nickName"] forKey:@"bbsNickName"];
            [[NSUserDefaults standardUserDefaults] setValue:bbsUser[@"id"] forKey:@"bbsUserId"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
    
}
#pragma mark - 找回密码
- (IBAction)findPwdAction {
    
}
#pragma mark - 注册
- (IBAction)regAction {
    ForumRegistController *regist = [[ForumRegistController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}
@end
