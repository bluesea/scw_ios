//
//  LoginViewController.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "LoginViewController.h"
#import "ChangePwdController.h"
#import "UserModel.h"
#import "SpeedLocation.h"
#import "NSString+Extension.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *forgetPwdBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)forgetPwdAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;


@property (weak, nonatomic) IBOutlet UIButton *remPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBtn;

- (IBAction)autoLoginAction:(UIButton *)sender;
- (IBAction)remPwdAction:(UIButton *)sender;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializations
        //        [self initUi];
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        self.navigationItem.leftBarButtonItem = cancelBtn;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUi];
}
#pragma mark - UI
- (void)initUi{
    
    //导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    if ([UserDefaults(SC_REM_PWD) boolValue]){
        self.remPwdBtn.selected = YES;
        self.loginBtn.enabled = YES;
        self.usernameField.text = UserDefaults(@"SC_LOGIN_NAME");
        self.pwdField.text = UserDefaults(@"SC_LOGIN_PASSWORD");
    }
    self.autoLoginBtn.selected = [UserDefaults(SC_AUTO_LOGIN)boolValue];
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInput) name:UITextFieldTextDidChangeNotification object:self.usernameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInput) name:UITextFieldTextDidChangeNotification object:self.pwdField];

}

#pragma mark - 输入框监听
- (void) textInput{
    self.loginBtn.enabled = (self.usernameField.text.length && self.pwdField.text.length > 5 );
}

#pragma mark - 登录
- (IBAction)loginAction:(UIButton *)sender {
    //登陆
    NSString *username = self.usernameField.text;
    NSString *password = self.pwdField.text;
    
    if([username length] == 0) {
        [MBProgressHUD showError:@"用户名不能为空!"];
        return;
    }
    
    if([password length] == 0) {
        [MBProgressHUD showError:@"密码不能为空!"];
        return;
    }

    
    [MBProgressHUD showMessage:@"正在登录..."];
    [[HttpRequest shareRequst]loginWithNmae:username pass:[password md5Encryption] success:^(id obj) {
        
        NSString  *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            
            NSDictionary *record = [obj objectForKey:@"record"];
            NSInteger status = [[record valueForKeyPath:@"user.status"] integerValue];
            if ( status == 2){
                [MBProgressHUD hideHUD];
                ChangePwdController *pwdView = [[ChangePwdController alloc]init];
                pwdView.firstChange = YES;
                [self.navigationController pushViewController:pwdView animated:YES];
                return ;
            }
            
            [[AppDelegate shareAppdelegate].user  setUserWithDic:[record objectForKey:@"user"]];
            
            NSDictionary *userDic = [record objectForKey:@"user"];
            NSString *userId = [userDic objectForKey:@"id"];
            NSString *nickName = [userDic objectForKey:@"nickName"];
            
            [[NSUserDefaults standardUserDefaults] setValue:userId forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] setValue:nickName forKey:@"nickName"];
            
            NSString *role = [record objectForKey:@"role"];
            [[NSUserDefaults standardUserDefaults] setValue:role forKey:SC_ROLE];
            
            //司机登陆
            if ([role isEqualToString:@"司机"]){
                //发送通知开始更新地理信息
                NSDictionary *remindConf = [record valueForKey:@"remindConf"];
                [[NSUserDefaults standardUserDefaults] setValue:[remindConf valueForKey:@"speedId"] forKey:SC_DRIVER_SPEED];
                [[NSUserDefaults standardUserDefaults] setValue:[remindConf valueForKey:@"hourIds"] forKey:SC_DRIVER_HOUR_ALERT];
                
            }
            //管理员登陆
            else {
                NSString *comId = [[record valueForKey:@"manager"] valueForKey:@"comId"];
                [[NSUserDefaults standardUserDefaults] setValue:comId forKey:@"comId"];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginedNotification" object:nil];
            
            [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"SC_LOGIN_NAME"];
            [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"SC_LOGIN_PASSWORD"];
            [[NSUserDefaults standardUserDefaults] setBool:self.remPwdBtn.selected forKey:SC_REM_PWD];
            [[NSUserDefaults standardUserDefaults] setBool:self.autoLoginBtn.selected forKey:SC_AUTO_LOGIN];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [MBProgressHUD hideHUD];
            
            [self cancel];
        } else {
            
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
        
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
    
    //第一次,跳转到修改密码页面
    //    ChangePwdController *pwdView = [[ChangePwdController alloc]init];
    //    UINavigationController *navi =[[UINavigationController alloc]initWithRootViewController:pwdView];
    //    [self presentViewController:navi animated:YES completion:nil];
}

- (IBAction)forgetPwdAction:(UIButton *)sender {
    
}



- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)autoLoginAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected){
        [_remPwdBtn setSelected:YES];
    }
}

- (IBAction)remPwdAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected){
        [_autoLoginBtn setSelected:NO];
    }
}
@end
