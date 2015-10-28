//
//  CarModel.h
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) NSInteger carTypeId;
@property (nonatomic, copy) NSString *carTypeName;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) carModelWithDic:(NSDictionary *)dic;

@end
