//
//  IdConfirmViewController.m
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "IdConfirmViewController.h"
#import "DriverListController.h"

@interface IdConfirmViewController ()

@end

@implementation IdConfirmViewController

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
    // Do any additional setup after loading the view from its nib.
    [self initData];
    
}

- (void)initData{
    [[HttpRequest shareRequst]getDriverCount:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (code.intValue == 0){
            self.driverNum.text = [NSString stringWithFormat:@"%@",[[obj objectForKey:@"record"]  objectForKey:@"driverCount" ]];
        }
    } fail:^(NSString *errorMsg) {
        ;
    }];
}

- (IBAction)search:(UIButton *)sender {
    //测试查询结果页面
    [self.view endEditing:YES];
    
    DriverListController *driverlist = [[DriverListController alloc]init];
    
    driverlist.name = self.driverName.text;
    driverlist.cardNo = self.driverId.text;
    driverlist.scanType = DriverScanTypeConfirmDirver;
    
    [self.navigationController pushViewController:driverlist animated:YES];
}

@end
