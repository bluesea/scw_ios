//
//  ManagerInfoController.m
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ManagerInfoController.h"
#import "ModifyManagerInfoController.h"
#import "ManagerModel.h"
#import "UIImageView+WebCache.h"

@interface ManagerInfoController ()
@property (weak, nonatomic) IBOutlet UIImageView *headPhoto;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (nonatomic, strong) ManagerModel *manager;

@end

@implementation ManagerInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人资料";
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(modifyInfo)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
    [MBProgressHUD showMessage:@"正在加载"];
}

- (void)viewDidAppear:(BOOL)animated{
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
    _manager = [[ManagerModel alloc] initWithDic:[userInfo objectForKey:@"userInfo"]];
    _name.text = _manager.name;
    _age.text = [NSString stringWithFormat:@"%@",_manager.age];
    _phone.text = _manager.phone;
    _email.text = _manager.email;
    _address.text = _manager.address;
    _sex.text = _manager.sexName;
    [_headPhoto sd_setImageWithURL:[NSURL URLWithString:_manager.headPicUrl]];
    [MBProgressHUD hideHUD];
}


- (void)modifyInfo{
    ModifyManagerInfoController *modify = [[ModifyManagerInfoController alloc] init];
    modify.manager = _manager;
    [self.navigationController pushViewController:modify animated:YES];
}

@end
