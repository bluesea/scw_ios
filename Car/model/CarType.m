//
//  CarType.m
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "CarType.h"

@implementation CarType

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_id forKey:@"id"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_code forKey:@"code"];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        self.id = [aDecoder decodeIntegerForKey:@"id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    return self;
}


- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype) carTypeWithDic:(NSDictionary *)dic{
    return  [[self alloc] initWithDic:dic];
}

@end
