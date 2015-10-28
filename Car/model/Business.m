//
//  BusinessAbstract.m
//  Car
//  业务摘要
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "Business.h"

@implementation Business

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) businessWithDic:(NSDictionary *)dic{
    return  [[self alloc] initWithDic:dic];
}

@end
