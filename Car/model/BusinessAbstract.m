//
//  BusinessAbstract.m
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BusinessAbstract.h"

@implementation BusinessAbstract

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) businessAbstractWithDic:(NSDictionary *)dic{
    return  [[self alloc] initWithDic:dic];
}


@end
