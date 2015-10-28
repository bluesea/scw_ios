//
//  EndorseAbstract.m
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "EndorseAbstract.h"

@implementation EndorseAbstract

- (instancetype) initWithDic:(NSDictionary *)dic{
    if( self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) endorseAbstractWithDic:(NSDictionary *)dic{
    return  [[self alloc] initWithDic:dic];
}

@end
