//
//  ComDetailView.m
//  Car
//
//  Created by Leon on 11/4/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ComDetailView.h"
#import "CompanyModel.h"

@interface ComDetailView()
/** 公司名称 */
@property (weak, nonatomic) IBOutlet UILabel *comName;
/** 报价 */
@property (weak, nonatomic) IBOutlet UILabel *money;
/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;
/** 企业法人 */
@property (weak, nonatomic) IBOutlet UILabel *leader;
/** 注册资金 */
@property (weak, nonatomic) IBOutlet UILabel *foundMoney;
/** 营业执照代码 */
@property (weak, nonatomic) IBOutlet UILabel *lisenceNo;
/** 组织机构代码 */
@property (weak, nonatomic) IBOutlet UILabel *orgNo;
/** 税务登记代码 */
@property (weak, nonatomic) IBOutlet UILabel *taxNo;
/** 联系人姓名 */
@property (weak, nonatomic) IBOutlet UILabel *contact;
/** 联系固话 */
@property (weak, nonatomic) IBOutlet UILabel *tel;
/** 联系手机 */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** 联系邮编 */
@property (weak, nonatomic) IBOutlet UILabel *postcode;

@end

@implementation ComDetailView

+ (instancetype) comDetailView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ComDetailView" owner:nil options:nil]lastObject];
}

- (void)setCompany:(CompanyModel *)company{
    _company = company;
    self.comName.text = _company.name;
    self.money.text = _company.money;
    self.address.text = _company.comArea;
    self.leader.text = _company.corp;
    self.foundMoney.text = _company.comMoney;
    self.lisenceNo.text = _company.licenseNo;
    self.orgNo.text = _company.orgNo;
    self.taxNo.text = _company.taxregNo;
    self.contact.text =_company.contact;
    self.postcode.text = _company.contactPostcode;
    self.tel.text = _company.contactTel;
    self.phone.text = _company.contactPhone;
}


@end
