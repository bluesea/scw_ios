//
//  ForumRegistController.m
//  Car
//
//  Created by Leon on 9/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ForumRegistController.h"
#import "NSString+Extension.h"
#import "BbsUser.h"

@interface ForumRegistController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *validCode;


@property (nonatomic, weak) UIWebView *webView;

- (IBAction)getCodeAction;
- (IBAction)registAction;
@end

@implementation ForumRegistController

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
    self.title = @"论坛注册协议";
    
    //先加载web页面协议
    CGRect frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height- 64);
    
    UIWebView *webView  = [[UIWebView alloc]initWithFrame:frame];
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"http://121.40.177.96/songche/ws/app/bbsAgree"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    _webView = webView;
    
}

- (void)agree{
    self.title = @"论坛注册";
    [_webView removeFromSuperview];
    self.navigationItem.rightBarButtonItem = nil;
}


- (IBAction)getCodeAction {
    NSString *phone = self.phoneField.text;
    if ([phone checkPhoneNumInput]){
        
        [MBProgressHUD showMessage:@"正在获取验证码"];
        
        [[HttpRequest shareRequst] getBbsValidCodeWithPhone:phone success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
                self.phoneField.enabled = NO;
            } else {
                 [MBProgressHUD showError:[obj valueForKey:@"msg"]];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
        }];
    } else {
        AlertTitle(@"请填写正确的手机号!");
    }
}

- (IBAction)registAction {
    
    //校验
    NSString *name = [self.usernameField.text trimBlank];
    if (name.length <= 0) {
        AlertTitle(@"请填写用户名");
        return;
    }
    
    NSString *nickname = [self.nicknameField.text trimBlank];
    if (nickname.length <= 0) {
        AlertTitle(@"请填写用户名");
        return;
    }
    
    NSString *password = self.passwordField.text;
    
    if (password.length < 6){
        AlertTitle(@"密码长度不能小于6位");
        return;
    }

    if(![password isEqualToString:self.confirmPwdField.text]){
        AlertTitle(@"两次输入的密码不一致");
        return;
    }
    
    NSString *phone = self.phoneField.text;
    
    NSString *code = [self.validCode.text trimBlank];
    
    if (code.length <= 0) {
        AlertTitle(@"请输入验证码");
        return;
    }
    
    
    NSDictionary *bbsUser = @{
                              @"nickName":nickname,
                              @"bbsName":name,
                              @"password":password,
                              @"phone":phone};
    
    NSString *userId = [AppDelegate shareAppdelegate].isLogin ? UserDefaults(@"userId") : @"";
    
    [MBProgressHUD showMessage:@"正在提交注册信息"];
    
    [[HttpRequest shareRequst]bbsRegistWithBbsUser:bbsUser validCode:code userId:userId success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){

            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];

    
}
@end
