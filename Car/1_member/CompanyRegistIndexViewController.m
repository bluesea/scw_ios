//
//  CompanyRegistIndexViewController.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "CompanyRegistIndexViewController.h"
#import "CompanyRegistViewController.h"

@interface CompanyRegistIndexViewController ()

@end

@implementation CompanyRegistIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册主页";
        self.navigationItem.leftBarButtonItem.title = @"返回";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)comanyRegist:(UIButton *)sender {
    CompanyRegistViewController *companyRegist = [[CompanyRegistViewController alloc] init];
    [self.navigationController pushViewController:companyRegist animated:YES];
}

- (IBAction)driverRegist:(UIButton *)sender {
}

- (IBAction)companyCheck:(UIButton *)sender {
}

- (IBAction)orderCheck:(UIButton *)sender {
}

- (IBAction)businessCheck:(UIButton *)sender {
}

@end
