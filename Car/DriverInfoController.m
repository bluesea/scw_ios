//
//  DriverInfoController.m
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverInfoController.h"
#import "ModifyDriverInfoController.h"
#import "PermissionUtil.h"
#import "UIImageView+WebCache.h"
#import "DriverModel.h"

@interface DriverInfoController ()
@property (weak, nonatomic) IBOutlet UIScrollView *mainView;

@property(nonatomic, strong) DriverModel *driver;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 性别 */
@property (weak, nonatomic) IBOutlet UILabel *sex;
/** 电话 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** 准驾车型 */
@property (weak, nonatomic) IBOutlet UILabel *driverType;
/** 身份证号 */
@property (weak, nonatomic) IBOutlet UILabel *cardNo;
/** 从业资格证号 */
@property (weak, nonatomic) IBOutlet UILabel *qualificationNo;
/** 驾驶证号 */
@property (weak, nonatomic) IBOutlet UILabel *licenseNo;

/** 个人近照 */
@property (weak, nonatomic) IBOutlet UIImageView *photo;
/** 身份证照片 */
@property (weak, nonatomic) IBOutlet UIImageView *cardPhoto;
/** 从业资格证照 */
@property (weak, nonatomic) IBOutlet UIImageView *qualificationPhoto;
/** 驾驶证照片 */
@property (weak, nonatomic) IBOutlet UIImageView *licensePhoto;


@end

@implementation DriverInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人资料";
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(modifyInfo)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
    
//    [MBProgressHUD showMessage:@"正在加载"];
//    
//    [self loadData];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self loadData];
}

- (void) loadData
{
    [[HttpRequest shareRequst] getUserInfoWithUserId:UserDefaults(@"userId") success:^(id obj) {
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.integerValue == 0){
            [self dealWithUserInfo:[obj valueForKey:@"record"]];
        } else {
            [MBProgressHUD showError:[obj valueForKey:@"msg"]];
        }
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}


- (void)dealWithUserInfo:(NSDictionary *)userInfo{
    _driver = [[DriverModel alloc] initWithDic:[userInfo objectForKey:@"userInfo"]];
    self.name.text = _driver.name;
    self.sex.text = _driver.sexName;
    self.phone.text = _driver.phone;
    self.driverType.text = _driver.driverType;
    self.cardNo.text = _driver.cardNo;
    self.qualificationNo.text = _driver.qualificationNo;
    self.licenseNo.text = _driver.licenseNo;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_driver.headPicUrl]];
    [self.photo sd_setImageWithURL:[NSURL URLWithString:_driver.photo]];
    [self.cardPhoto sd_setImageWithURL:[NSURL URLWithString:_driver.cardPhoto]];
    [self.qualificationPhoto sd_setImageWithURL:[NSURL URLWithString:_driver.qualificationPhoto]];
    [self.licensePhoto sd_setImageWithURL:[NSURL URLWithString:_driver.licensePhoto]];
    
    self.mainView.hidden = NO;
    
    [MBProgressHUD hideHUD];
}


- (void)modifyInfo{
    ModifyDriverInfoController *modify = [[ModifyDriverInfoController alloc] init];
    
    modify.driver = _driver;
    
    [self.navigationController pushViewController:modify animated:YES];
}

@end
