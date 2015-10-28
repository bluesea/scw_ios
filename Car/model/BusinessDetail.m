//
//  Business.m
//  Car
//
//  Created by Leon on 14-9-28.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "BusinessDetail.h"

@implementation BusinessDetail

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}
+ (instancetype) businessDetailWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

@end
