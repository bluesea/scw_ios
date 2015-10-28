//
//  AreaUtil.m
//  Car
//
//  Created by Leon on 14-9-29.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "AreaUtil.h"



@implementation AreaUtil

static AreaUtil *instrance = nil;

+ (AreaUtil *)shareInstance{
    
    @synchronized (self)
    {
        if (instrance == nil)
        {
            instrance= [[self alloc] init];
            instrance.areaArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
        }
    }
    return instrance;
}


- (NSArray *)getProvinceArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in _areaArray) {
        [array addObject:[dic objectForKey:@"state"]];
    }
    return array;
}

- (NSArray *)getCityArrayByProId:(long)proId{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in [[_areaArray objectAtIndex:proId] objectForKey:@"cities"]) {
        [array addObject:[dic objectForKey:@"city"]];
    }
    return array;
}

- (NSArray *)getDistrictArrayProId:(long)proId andCityId:(long)cityId{
    return  [[[[_areaArray objectAtIndex:proId] objectForKey:@"cities"] objectAtIndex:cityId] objectForKey:@"areas"];
}




@end
