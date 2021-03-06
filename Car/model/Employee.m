//
//  Employee.m
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "Employee.h"

@implementation Employee

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) employeeWithDic:(NSDictionary *)dic{
    return  [[self alloc]initWithDic:dic];
}

@end
