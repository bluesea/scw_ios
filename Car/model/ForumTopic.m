//
//  ForumTopic.m
//  Car
//
//  Created by Leon on 11/6/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ForumTopic.h"

@implementation ForumTopic

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}
+ (instancetype) forumTopicWithDic:(NSDictionary *)dic{
    return  [[self alloc] initWithDic:dic];
}

@end
