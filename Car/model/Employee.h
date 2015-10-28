//
//  Employee.h
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject
/** 员工姓名 */
@property (nonatomic, copy) NSString *name;
/** 员工ID */
@property (nonatomic, assign) NSInteger id;
/** 员工状态 */
@property (nonatomic, assign) BOOL status;
/** 员工电话 */
@property (nonatomic, copy) NSString *phone;
/** 员工身份证号 */
@property (nonatomic, copy) NSString *cardNo;

- (instancetype) initWithDic:(NSDictionary *)dic;

+ (instancetype) employeeWithDic:(NSDictionary *)dic;

@end
