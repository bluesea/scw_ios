//
//  BzDetailController.m
//  Car
//
//  Created by Leon on 11/3/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BzDetailController.h"
#import "BusinessDetail.h"
#import "BzdetailView.h"
#import "PermissionUtil.h"
@interface BzDetailController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
//bz
@property (weak, nonatomic) IBOutlet UILabel *ori2;
@property (weak, nonatomic) IBOutlet UILabel *des2;
@property (weak, nonatomic) IBOutlet UILabel *stime;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *ctime;
//detail
@property (nonatomic, weak) BzDetailView *detailView;

- (IBAction)grapAction:(UIButton *)sender;
@end

@implementation BzDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [MBProgressHUD showMessage:@"正在加载"];
    
    _detailView = [BzDetailView bzDetailView];
    _detailView.frame = CGRectMake(8, 112, 304, 618);
    
    [self.mainView addSubview:_detailView];
    
    [self loadData];
}

- (void)loadData{
    [[HttpRequest shareRequst] getBzDetailById:self.businessId success:^(id obj) {
        NSNumber *code = [obj objectForKey:@"code"];
        if (0 == code.intValue){
            BusinessDetail  *bzDetail = [BusinessDetail  businessDetailWithDic:[[obj objectForKey:@"record"] objectForKey:@"business"]];
            
            _detailView.bz = bzDetail;
            self.ori2.text = bzDetail.ori2;
            self.des2.text = bzDetail.des2;
            self.stime.text = bzDetail.stime;
            self.ctime.text = bzDetail.ctime;
            self.info.text = [NSString stringWithFormat:@"%d辆%@",bzDetail.carNum,bzDetail.carTypeName];
            self.mainView.hidden = NO;
            
            [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
        
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}

- (IBAction)grapAction:(UIButton *)sender {
    
    UIAlertView *alert;
    
    if ([PermissionUtil checkPermissionWithRole:ROLE_DRIVER]){
        alert = [[UIAlertView alloc] initWithTitle:@"请输入运输车数量!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"抢单", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *field = [alert textFieldAtIndex:0];
        field.placeholder = @"请输入运输车数量";
        field.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if  ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_TRA]){
        alert = [[UIAlertView alloc] initWithTitle:@"请输入报价!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"抢单", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *field = [alert textFieldAtIndex:0];
        field.placeholder = @"请输入报价(单位:元)";
        field.keyboardType = UIKeyboardTypeDecimalPad;
    }
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){

        
        if ([PermissionUtil checkPermissionWithRole:ROLE_MANAGER_TRA]){
            NSString *money = [alertView textFieldAtIndex:0].text;
            if (money.length > 0){
                [MBProgressHUD showMessage:@"正在提交请求..."];
                [[HttpRequest shareRequst] grabEndorseWithBzId:self.businessId userId:UserDefaults(@"userId") money:money success:^(id obj) {
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
        }
        else if  ([PermissionUtil checkPermissionWithRole: ROLE_DRIVER]){
            NSString *carNum = [alertView textFieldAtIndex:0].text;
            if (carNum.length > 0){
                [MBProgressHUD showMessage:@"正在提交请求..."];
                [[HttpRequest shareRequst] grabBzWithUserId:UserDefaults(@"userId") businessId:self.businessId carNum:carNum  success:^(id obj) {
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
        }
    }
    
}

@end
