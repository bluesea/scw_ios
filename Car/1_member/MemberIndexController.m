//
//  MemberIndexController.m
//  Car
//
//  Created by Leon on 14-9-20.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "MemberIndexController.h"
#import "MemberRegisterController.h"
#import "PersonalViewController.h"
#import "AdView.h"
#import "WebViewController.h"
#import "Advert.h"

@interface MemberIndexController ()

- (IBAction)regist:(UIButton *)sender;
- (IBAction)memberCenter:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet AdView *adView;
@property (nonatomic, strong) NSMutableArray *adverts;

@end

@implementation MemberIndexController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 会员注册
- (IBAction)regist:(UIButton *)sender {
    MemberRegisterController *memberRegist = [[MemberRegisterController alloc] init];
    [self.navigationController pushViewController:memberRegist animated:YES];
}

#pragma mark - 进入会员中心
- (IBAction)memberCenter:(UIButton *)sender {
    if ([AppDelegate shareAppdelegate].isLogin) {
        PersonalViewController *person  = [[PersonalViewController alloc] init];
        [self.navigationController pushViewController:person animated:YES];
    } else {
        [MBProgressHUD showError:@"请返回首页登录!"];
    }
}

@end
