//
//  ManagerModel.m
//  Car
//
//  Created by Leon on 11/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ManagerModel.h"

@implementation ManagerModel

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        self.name = dic[@"name"];
        self.headPicUrl = dic[@"headPicUrl"];
        self.address = dic[@"address"];
        self.phone = dic[@"phone"];
        self.managerId = [dic[@"id"] integerValue];
        self.sexName = dic[@"sexName"];
        self.sex = [dic[@"sex"] integerValue];
        self.email = dic[@"email"];
        self.age = dic[@"age"];
    }
    return self;
}

+ (instancetype) managerWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

@end
