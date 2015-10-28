//
//  ForumReply.m
//  Car
//
//  Created by Leon on 11/6/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ForumReply.h"

@implementation ForumReply

+ (instancetype) replyWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}
- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
