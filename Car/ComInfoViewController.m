//
//  ComInfoViewController.m
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ComInfoViewController.h"
#import "ComInfoModifyController.h"
#import "CompanyModel.h"
#import "UIImageView+WebCache.h"

@interface ComInfoViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
@property (nonatomic, strong) CompanyModel *company;

@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@property (weak, nonatomic) IBOutlet UILabel *comType;
@property (weak, nonatomic) IBOutlet UILabel *comSubType;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *corp;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *licenseNo;
@property (weak, nonatomic) IBOutlet UILabel *orgNo;
@property (weak, nonatomic) IBOutlet UILabel *taxregNo;
@property (weak, nonatomic) IBOutlet UILabel *contact;
@property (weak, nonatomic) IBOutlet UILabel *contactTel;
@property (weak, nonatomic) IBOutlet UILabel *contactPhone;
@property (weak, nonatomic) IBOutlet UILabel *contactPostcode;
@property (weak, nonatomic) IBOutlet UIImageView *licensePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *orgPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *taxregPhoto;



@end

@implementation ComInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公司资料";
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(modifyInfo)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)viewWillAppear:(BOOL)animated{
    self.mainView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [MBProgressHUD showMessage:@"正在加载.."];
    
    [self loadData];
}

- (void)loadData{
    [[HttpRequest shareRequst] getCompanyInfoWithId:UserDefaults(@"comId") success:^(id obj) {
        NSLog(@"%@",obj);
        NSNumber *code = [obj valueForKey:@"code"];
        if (code.integerValue == 0){
            [self dealWithCompany:[[obj valueForKey:@"record"] valueForKey:@"company"] ];
        }
        [MBProgressHUD hideHUD];
    } fail:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg];
    }];
}

- (void)dealWithCompany:(NSDictionary *)dic{
    _company  = [CompanyModel companyWithDic:dic];
    _comType.text = _company.comTypeName;
    _comSubType.text  = _company.comSubTypeName;
    _name.text = _company.name;
    _address.text = _company.address;
    _corp.text = _company.corp;
    _money.text = [NSString stringWithFormat:@"%@",_company.money];
    _licenseNo.text = _company.licenseNo;
    _orgNo.text = _company.orgNo;
    _taxregNo.text = _company.taxregNo;
    _contact.text = _company.contact;
    _contactPhone.text = _company.contactPhone;
    _contactTel.text = _company.contactTel;
    _contactPostcode.text = _company.contactPostcode;
    
    [_logoView sd_setImageWithURL:[NSURL URLWithString:_company.headPicUrl] placeholderImage:[UIImage imageNamed:@"no_pic"]];
    [_licensePhoto sd_setImageWithURL:[NSURL URLWithString:_company.licensePhoto] placeholderImage:[UIImage imageNamed:@"no_pic"]];
    [_taxregPhoto sd_setImageWithURL:[NSURL URLWithString:_company.taxregPhoto] placeholderImage:[UIImage imageNamed:@"no_pic"]];
    [_orgPhoto sd_setImageWithURL:[NSURL URLWithString:_company.orgPhoto] placeholderImage:[UIImage imageNamed:@"no_pic"]];
    
    
    self.mainView.hidden = NO;
    [MBProgressHUD hideHUD];
}

- (void)modifyInfo{
    ComInfoModifyController *comModify = [[ComInfoModifyController alloc] init];
    comModify.company = _company;
    [self.navigationController pushViewController:comModify animated:YES];
}


@end
