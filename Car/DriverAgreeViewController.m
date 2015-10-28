//
//  DriverAgreeViewController.m
//  Car
//
//  Created by Leon on 11/19/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverAgreeViewController.h"
#import "BzViewController.h"

@interface DriverAgreeViewController ()

@end

@implementation DriverAgreeViewController

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
    self.title = @"驾驶员使用协议";
    // Do any additional setup after loading the view.
    [(UIWebView *)self.view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://121.40.177.96/songche/ws/app/driverAgree"]]];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"同意" style:UIBarButtonItemStyleDone target:self action:@selector(agree)];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)agree{
    BzViewController *bz = [[BzViewController alloc] init];
    [self.navigationController pushViewController:bz animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
