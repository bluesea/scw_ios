//
//  DriverView.m
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverView.h"

@interface DriverView()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *no;
@property (weak, nonatomic) IBOutlet UILabel *com;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *driverType;
@property (weak, nonatomic) IBOutlet UILabel *cardNo;
@property (weak, nonatomic) IBOutlet UILabel *qualificationNo;
@property (weak, nonatomic) IBOutlet UILabel *licenseNo;
@property (weak, nonatomic) IBOutlet UILabel *mileage;
@property (weak, nonatomic) IBOutlet UILabel *acdntNum;


@end

@implementation DriverView

+(instancetype) driverView{
    return [[[NSBundle mainBundle] loadNibNamed:@"DriverView" owner:nil options:nil] lastObject];
}

- (void)setDriver:(DriverModel *)driver{
    _driver = driver;
    
    _name.text = _driver.name;
    _no.text = _driver.code;
    _com.text = _driver.comName;
    _age.text = [NSString stringWithFormat:@"%@",_driver.age];
    _phone.text = _driver.phone;
    _driverType.text = _driver.driverType;
    _cardNo.text = _driver.cardNo;
    _licenseNo.text = [NSString stringWithFormat:@"%@",_driver.licenseNo];
    _qualificationNo.text = [NSString stringWithFormat:@"%@",_driver.qualificationNo];
    _mileage.text = _driver.mileage;
    _acdntNum.text = [NSString stringWithFormat:@"%@",_driver.acdntNum];
    
}

@end
