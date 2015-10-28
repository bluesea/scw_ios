//
//  NewsModel.m
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype) newsModelWithDic:(NSDictionary *)dic{
    return  [[self alloc] initWithDic:dic];
}

@end
