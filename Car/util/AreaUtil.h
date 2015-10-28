//
//  AreaUtil.h
//  Car
//  省市县工具
//  Created by Leon on 14-9-29.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaUtil : NSObject

+ (AreaUtil *)shareInstance;

@property  (strong, nonatomic) NSArray *areaArray;
/**
 *  获取省份列表
 *
 *  @return return value description
 */
- (NSArray *)getProvinceArray;
/**
 *  获得城市列表
 *
 *  @param proId 省份id
 *
 *  @return return value description
 */
- (NSArray *)getCityArrayByProId:(long)proId;
/**
 *  获取区县列表
 *
 *  @param proId  省份id
 *  @param cityId 城市id
 *
 *  @return return value description
 */
- (NSArray *)getDistrictArrayProId:(long)proId andCityId:(long)cityId;


@end
