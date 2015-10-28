//
//  DriverModel.m
//  Car
//
//  Created by Leon on 14-9-18.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "DriverModel.h"

@implementation DriverModel


- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        self.name = dic[@"name"];
        self.code = dic[@"code"];
        self.phone = dic[@"phone"];
        self.driverType = dic[@"driverType"];
        self.cardNo = dic[@"cardNo"];
        self.photo = dic[@"photo"];
        self.licenseNo = dic[@"licenseNo"];
        self.cardPhoto = dic[@"cardPhoto"];
        self.licensePhoto = dic[@"licensePhoto"];
        self.address = dic[@"address"];
        self.age = dic[@"age"];
        self.driverId = [dic[@"id"] intValue];
        self.status = [dic[@"status"] integerValue];
        self.statusName = dic[@"statusName"];
        self.sex = [dic[@"sex"] integerValue];
        self.mileage = dic[@"mileage"];
        self.acdntNum = dic[@"acdntNum"];
        self.level = dic[@"level"];
        self.qualificationNo = dic[@"qualificationNo"];
        self.qualificationPhoto = dic[@"qualificationPhoto"];
        self.longitude = dic[@"longitude"];
        self.latitude = dic[@"latitude"];
        self.comName = dic[@"comName"];
        self.sexName = dic[@"sexName"];
        self.headPicUrl = dic[@"headPicUrl"];
    }
    return self;
}

+ (instancetype) driverWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

@end
