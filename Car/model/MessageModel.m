//
//  MessageModel.m
//  Car
//
//  Created by Leon on 14-9-27.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self  = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype) msgWithDid:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

@end
