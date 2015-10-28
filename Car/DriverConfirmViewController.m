//
//  DriverConfirmViewController.m
//  Car
//
//  Created by Leon on 10/14/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverConfirmViewController.h"
#import "UIImageView+WebCache.h"
#import "DriverModel.h"
#import "BzFollowViewController.h"

@interface DriverConfirmViewController (){
    NSString *orderId;
    DriverModel *driver;
    double longitude;
    double latitude;
}

@end

@implementation DriverConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"身份确认";
    
    [self initData];
}

- (void)initData{
    
    [MBProgressHUD showMessage:@"正在加载"];
    
    [[HttpRequest shareRequst] getDriverDetailById:[NSString stringWithFormat:@"%d",_driverId] managerId:UserDefaults(@"userId") success:^(id obj) {
        LSLog(@"---->%@", obj);
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.intValue == 0){
            [self initUIWith:[obj objectForKey:@"record"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
        
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
        
    }];
}

- (void)initUIWith:(NSDictionary *)dic{
    double height = 10;
    // 司机信息展示
    driver = [DriverModel driverWithDic:[dic valueForKey:@"driver"]];
    
    self.nameLbl.text = driver.name;
    self.codeLbl.text = driver.code;
    self.comNameLbl.text = driver.comName;
    self.ageLbl.text = [NSString stringWithFormat:@"%@",driver.age];
    self.phoneLbl.text = driver.phone;
    self.driverTypeLbl.text = driver.driverType;
    self.qualificationNoLbl.text = [driver.qualificationNo isKindOfClass:[NSNull class]]?@"":driver.qualificationNo;
    self.licenseNoLbl.text = [driver.licenseNo isKindOfClass:[NSNull class]]?@"":driver.licenseNo;
    self.mileageLbl.text = driver.mileage;
    self.acdntNumLbl.text = [NSString stringWithFormat:@"%@",driver.acdntNum];
    
    if (![driver.photo isKindOfClass:[NSNull class]]){
        [self.photo sd_setImageWithURL:[NSURL URLWithString:driver.photo]];
    }
    if (![driver.cardPhoto isKindOfClass:[NSNull class]]){
        [self.cardPhoto sd_setImageWithURL:[NSURL URLWithString:driver.cardPhoto]];
    }
    if (![driver.qualificationPhoto isKindOfClass:[NSNull class]]){
        [self.qualificationPhoto sd_setImageWithURL:[NSURL URLWithString:driver.qualificationPhoto]];
    }
    if (![driver.licensePhoto isKindOfClass:[NSNull class]]){
        [self.licensePhoto sd_setImageWithURL:[NSURL URLWithString:driver.licensePhoto]];
    }
    
    height += (self.driverInfoView.frame.size.height + 10);
    
    // 业务信息展示
    if (![[dic objectForKey:@"order"] isKindOfClass:[NSNull class]]){
        NSDictionary *order = [dic objectForKey:@"order"];
        self.ori2Lbl.text = [order valueForKey:@"ori2"];
        self.des2Lbl.text = [order valueForKey:@"des2"];
        self.stimeLbl.text = [[order valueForKey:@"stime"] substringToIndex:10];
        self.statusNameLbl.text = [order valueForKey:@"statusName"];
        self.moneyLbl.text = [NSString stringWithFormat:@"%@",[order valueForKey:@"money"]];
        self.infoLbl.text = [NSString stringWithFormat:@"%@辆%@",[order valueForKey:@"carNum"],[order valueForKey:@"carTypeName"]];
        orderId = [order valueForKey:@"id"];
        
        self.bzInfoView.hidden = NO;
        
        height += (self.bzInfoView.frame.size.height + 10);
    }
    
    //按钮展示
    NSNumber *showButton = [dic objectForKey:@"showButton"];
    if (showButton.intValue == 1){
        self.subBtn.frame = CGRectMake(10, height, self.subBtn.frame.size.width,self.subBtn.frame.size.height);
        self.bzFollowBtn.frame = CGRectMake(10, height, self.bzFollowBtn.frame.size.width,self.bzFollowBtn.frame.size.height);
        self.subBtn.hidden = NO;
        height += (self.subBtn.frame.size.height + 10);
        
    } else if (showButton.intValue == 2){
        self.bzFollowBtn.frame = CGRectMake(10, height, self.bzFollowBtn.frame.size.width,self.bzFollowBtn.frame.size.height);
        self.bzFollowBtn.hidden = NO;
        height += (self.bzFollowBtn.frame.size.height + 10);
    }
    
    height += 20;
    
    self.mainView.contentSize = CGSizeMake(320, height);
    
    [MBProgressHUD hideHUD];
    self.mainView.hidden = NO;
    //    self.
}


- (IBAction)subAction:(UIButton *)sender {
    
    [MBProgressHUD showMessage:@"正在提交"];
    
    [[HttpRequest shareRequst] orderConfirmTransByOrderId:orderId success:^(id obj) {
        LSLog(@"---success");
        NSNumber *code = [obj valueForKey:@"code"];
        if (code == 0){
            self.subBtn.hidden = YES;
            self.bzFollowBtn.hidden = NO;
            
        }
    } fail:^(NSString *errorMsg) {
        LSLog(@"---fail");
    }];
}

- (IBAction)bzFollowAction:(UIButton *)sender {
    BzFollowViewController *bzFollow = [[BzFollowViewController alloc] init];
    bzFollow.driverArray = @[driver];
    bzFollow.showCompany = YES;
    [self.navigationController pushViewController:bzFollow animated:YES];
}


@end
