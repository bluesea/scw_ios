//
//  MemberRegisterController.m
//  Car
//
//  Created by Leon on 9/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "MemberRegisterController.h"
#import "WebViewController.h"
#import "DriverRegistViewController.h"
#import "CompanyRegistViewController.h"

#define COM_FLAG 1
#define DRIVER_FLAG 2

@interface MemberRegisterController ()

//UI
@property (weak, nonatomic) IBOutlet UIButton *comBtn;
@property (weak, nonatomic) IBOutlet UIButton *driverBtn;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

//ACTION
- (IBAction)selectType:(UIButton *)sender;
- (IBAction)submitAction:(UIButton *)sender;

//PARAM
@property (nonatomic, assign) NSInteger flag;

@end

@implementation MemberRegisterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"选择会员";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mainView.layer.borderWidth = 1;
    self.mainView.layer.borderColor = [RGBColor(209, 209, 209) CGColor];
    self.mainView.layer.cornerRadius = 5;
    self.submitBtn.layer.cornerRadius = 5;
    
    _flag = 0;
}

- (IBAction)selectType:(UIButton *)sender {
    if (sender == self.comBtn){
        [self.comBtn setSelected:YES];
        [self.driverBtn setSelected:NO];
        _flag = COM_FLAG;
    } else {
        [self.comBtn setSelected:NO];
        [self.driverBtn setSelected:YES];
        _flag = DRIVER_FLAG;
    }
}



- (IBAction)submitAction:(UIButton *)sender {
    if (_flag == COM_FLAG){
        CompanyRegistViewController *view = [[CompanyRegistViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    } else if (_flag == DRIVER_FLAG){
        DriverRegistViewController *view = [[DriverRegistViewController alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择会员类型!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
}
@end
