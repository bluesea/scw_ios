//
//  CarType.h
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarType : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) carTypeWithDic:(NSDictionary *)dic;

@end
