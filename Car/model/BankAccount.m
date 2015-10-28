//
//  Account.m
//  Car
//
//  Created by Leon on 10/20/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}
+ (instancetype) accountWithDid:(NSDictionary *)dic{
    return  [[self alloc]initWithDic:dic];
}

@end
