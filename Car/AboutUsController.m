//
//  CompanyViewController.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "AboutUsController.h"
#import "WebViewController.h"

@interface AboutUsController ()

@end

@implementation AboutUsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"公司主页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.translucent = NO;
}

- (IBAction)showInfoAction:(UIButton *)sender {
    WebViewController *adView = [[WebViewController alloc]init];
    switch (sender.tag) {
        case 0:
            adView.link = @"http://www.songchew.com/songche/ws/app/leader";
            adView.title = @"领导照片";
            break;
        case 1:
            adView.link = @"http://www.songchew.com/songche/ws/app/orgchart";
            adView.title = @"公司机构";
            break;
        case 2:
            adView.link = @"http://www.songchew.com/songche/ws/app/about";
            adView.title = @"企业概况";
            break;
        case 3:
            adView.link = @"http://www.songchew.com/songche/ws/app/license";
            adView.title = @"公司资质";
            break;
        case 5:
            adView.link = @"http://www.songchew.com/songche/ws/app/link";
            adView.title = @"联系方式";
            break;
        default:
            return;
            break;
    }
    
//    subController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adView animated:YES];
}
@end
