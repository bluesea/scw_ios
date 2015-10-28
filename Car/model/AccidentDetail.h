//
//  AccidentDetail.h
//  Car
//  事故信息
//  Created by Leon on 11/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccidentDetail : NSObject

@property (nonatomic, copy) NSString *process;
@property (nonatomic, copy) NSString *photo1;
@property (nonatomic, copy) NSString *photo2;
@property (nonatomic, copy) NSString *photo3;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) accidentDetailWithDic:(NSDictionary *)dic;
@end
