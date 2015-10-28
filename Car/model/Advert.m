//
//  Adv.m
//  Car
//
//  Created by Leon on 11/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "Advert.h"

@implementation Advert

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_id forKey:@"id"];
    [aCoder encodeObject:_url forKey:@"url"];
    [aCoder encodeObject:_picUrl forKey:@"picUrl"];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        self.id = [aDecoder decodeIntegerForKey:@"id"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.picUrl = [aDecoder decodeObjectForKey:@"picUrl"];
    }
    return self;
}

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) advWithDic:(NSDictionary *)dic{
    return  [[self alloc] initWithDic:dic];
}

@end
