//
//  Check.m
//  Car
//
//  Created by Leon on 11/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "Check.h"

@implementation Check

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) checkWithDic:(NSDictionary *)dic{
    return  [[self alloc] initWithDic:dic];
}

@end
