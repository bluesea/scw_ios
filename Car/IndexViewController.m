//
//  IndexViewController.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "IdConfirmViewController.h"
#import "NewsTrainController.h"
#import "ForumIndexController.h"
#import "MemberIndexController.h"
#import "FinanceViewController.h"
#import "CallViewController.h"
//#import "SpeedLocation.h"
#import "PermissionUtil.h"
#import "BzViewController.h"
#import "DriverConfirmViewController.h"
#import "WebViewController.h"
#import "AlertSetController.h"
#import "BankAccountViewController.h"
#import "BusinessListController.h"
#import "ModifyDriverInfoController.h"
#import "DriverAgreeViewController.h"
#import "PersonalViewController.h"
#import "FinanceManagerController.h"
#import "CarType.h"
#import "CarModel.h"
#import "ComType.h"
#import "ComSubType.h"

@interface IndexViewController () <UIActionSheetDelegate>
{
    UIBarButtonItem *loginBtn;
    UIBarButtonItem *logoutBtn;
}

@end

@implementation IndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"送车网";
        loginBtn = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
        logoutBtn = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(logoutAction)];
        self.navigationItem.rightBarButtonItem = loginBtn;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beLogined) name:@"loginedNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"loginOutNotification" object:nil];
    }
    return self;
}

#pragma mark - life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [MBProgressHUD showMessage:@"正在加载"];
    [self initUI];
    //登录了
    [self loginCheck];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loginCheck{
    if ([UserDefaults(SC_AUTO_LOGIN) boolValue]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginedNotification" object:nil];
    }
}


#pragma mark - initUI
- (void)initUI{
    self.navigationController.navigationBar.translucent = NO;
    
//    CGPoint bottomOffset = CGPointMake(self.advScroll.contentOffset.x, self.advScroll.contentSize.height - self.advScroll.bounds.size.height);
//    [self.advScroll setContentOffset:bottomOffset animated:NO];
//    
//    [self.advScroll setContentSize:CGSizeMake(320 * 5, 132)];
//    for (int i = 0; i < 5; i ++) {
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 320, 0, 320, 132)];
//        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"adverts%d.jpg", i + 1]]];
//        imageView.backgroundColor = [UIColor blueColor];
//        [self.advScroll addSubview:imageView];
//    }

    
    
    //禁用运力扫描按钮
    [self setTranScanEnable:NO];
    
    [self loadBaseData];
}

//加载基础数据并保存
- (void) loadBaseData{
    [[HttpRequest shareRequst] getBasedata:^(id obj) {
        NSNumber *code = [obj valueForKeyPath:@"code"];
        if (code.intValue == 0){
            NSDictionary *record = [obj valueForKey:@"record"];
            NSMutableArray *tmpCarTypes = [NSMutableArray array];
            
            NSArray *carTypes = [record valueForKey:@"carTypes"];
            for (NSDictionary *dic in carTypes) {
                CarType *cartype = [CarType carTypeWithDic:dic];
                [tmpCarTypes addObject:cartype];
            }
            
            NSMutableArray *tmpCarModels = [NSMutableArray array];
            
            NSArray *carModels = [record valueForKey:@"carModels"];
            for (NSDictionary *dic in carTypes) {
                CarModel *carmodel = [CarModel carModelWithDic:dic];
                [tmpCarModels addObject:carmodel];
            }
            
            NSMutableArray *comTypes = [NSMutableArray array];
            for (NSDictionary *dic in [record valueForKey:@"comTypes"]){
                ComType *comType = [ComType comTypeWithDic:dic];
                [comTypes addObject:comType];
            }
            
            NSMutableArray *comSubTypes = [NSMutableArray array];
            for (NSDictionary *dic in [record valueForKey:@"comSubTypes"]){
                ComSubType *comSbuType = [ComSubType comSubTypeWithDic:dic];
                [comSubTypes addObject:comSbuType];
            }
            
            NSArray *fuels = [[record valueForKey:@"fuels"] valueForKeyPath:@"name"];
            NSArray *couriers = [[record valueForKey:@"couriers"] valueForKeyPath:@"name"];
            
            NSDictionary *dic = @{@"carTypes":tmpCarTypes,
                                  @"comTypes":comTypes,
                                  @"comSubTypes":comSubTypes,
                                  @"carModels":carModels,
                                  @"fuels":fuels,
                                  @"couriers":couriers,
                                  @"carModels":tmpCarModels
                                  };
            if ([NSKeyedArchiver archiveRootObject:dic toFile:SCBaseData]){
                LSLog(@"--->OK");
            } else{
                LSLog(@"--->ERROR");
            }
        }
        [MBProgressHUD hideHUD];
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD hideHUD];
    }];
}

//运力扫描按钮设置 运力管理员可用
- (void) setTranScanEnable:(BOOL) enable{
    UITabBarItem *item = [[AppDelegate shareAppdelegate].tabBarController.tabBar.items objectAtIndex:2];
    item.enabled = enable;
}

#pragma mark - ------IBAction------

- (IBAction)indexAction:(UIButton *)sender {
    UIViewController *subController;
    switch (sender.tag) {
        case 0: //会员注册
            if ([AppDelegate shareAppdelegate].isLogin) {
                subController  = [[PersonalViewController alloc] init];
            } else {
                [MBProgressHUD showError:@"请返回首页登录!"];
                return;
            }
            break;
        case 4: //新闻中心
            subController = [[NewsTrainController alloc] init];
            break;
        case 5: //论坛
            subController = [[ForumIndexController alloc] init];
            break;
        case 7: //一键电话
            subController = [[CallViewController alloc] init];
            break;
        default:
            break;
    }
    
    subController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:subController animated:YES];
    
}


#pragma mark 登录
- (void)login{
    LoginViewController *login = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark 注销
- (void)logoutAction{
    //需要确认,防止误操作
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"确定要退出吗?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self logout];
    }  else {
        LSLog(@"---> CANCEL");
    }
}


- (void)logout{
    
    self.navigationItem.rightBarButtonItem = loginBtn;
    
    [AppDelegate shareAppdelegate].isLogin = NO;
    
    [self stopUploadLocation];
    
    [self setTranScanEnable:NO];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SC_AUTO_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)beLogined{
    self.navigationItem.rightBarButtonItem = logoutBtn;
    [AppDelegate shareAppdelegate].isLogin = YES;
    if ([PermissionUtil checkPermissionWithRole:ROLE_DRIVER]){
        [self startUploadLocation];
    } else if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_TRA]){
        [self setTranScanEnable:YES];
    }
}


#pragma mark - NSNotificationCenter
- (void)startUploadLocation{
    LSLog(@"----我要更新地理信息");
//    [[SpeedLocation shareInstance] start];
}

- (void)stopUploadLocation{
    LSLog(@"----我要停止更新地理信息");
//    [[SpeedLocation shareInstance] stop];
}



#pragma mark 身份验证(司机不可用)
- (IBAction)checkAction:(UIButton *)sender {
    if (![AppDelegate shareAppdelegate].isLogin){
        [self login];
        return;
    }
    if ([PermissionUtil checkPermissionWithRole:ROLE_DRIVER]){
        [MBProgressHUD showError:@"您不能进入该版块!"];
        return;
    }
    IdConfirmViewController * checkView = [[IdConfirmViewController alloc] init];
    checkView.hidesBottomBarWhenPushed = YES;
    checkView.title = @"身份确认";
    [self.navigationController pushViewController:checkView animated:YES];
}

#pragma mark 业务发布 (运力管理员可用)
- (IBAction)bzAction:(UIButton *)sender {
    if (![AppDelegate shareAppdelegate].isLogin){
        [self login];
        return;
    }
    
    if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_TRA]){
        BusinessListController *bzView = [[BusinessListController alloc] init];
        bzView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bzView animated:YES];
    } else {
        [MBProgressHUD showError:@"您不能进入该版块!"];
    }
  
}

#pragma mark 送车连接 (司机可用)
- (IBAction)sendCarAction:(UIButton *)sender {
    if (![AppDelegate shareAppdelegate].isLogin){
        [self login];
        return;
    }
    if (![PermissionUtil checkPermissionWithRole:ROLE_DRIVER]){
        [MBProgressHUD showError:@"您不能进入该版块!"];
        return;
    }
    DriverAgreeViewController * driverAgree = [[DriverAgreeViewController alloc] init];
    driverAgree.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:driverAgree animated:YES];
    
}

#pragma mark 财务管理
- (IBAction)financeAction:(UIButton *)sender {
    
    if (![AppDelegate shareAppdelegate].isLogin){
        [self login];
        return;
    }
    
    FinanceManagerController *financeViewController = [[FinanceManagerController alloc] init];
    financeViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:financeViewController animated:YES];
}

@end
