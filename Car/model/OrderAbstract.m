//
//  OrderAbstract.m
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "OrderAbstract.h"

@implementation OrderAbstract

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype) orderAbstractWithDic:(NSDictionary *)dic{
    return  [[self alloc]initWithDic:dic];
}

@end
