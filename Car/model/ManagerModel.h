//
//  ManagerModel.h
//  Car
//
//  Created by Leon on 11/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagerModel : NSObject
/** 头像 */
@property (nonatomic, copy) NSString *headPicUrl;
/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** 性别 */
@property (nonatomic, copy) NSString *sexName;

@property (nonatomic, assign) NSInteger sex;
/** 年龄 */
@property (nonatomic, copy) NSString *age;
/** 电话 */
@property (nonatomic, copy) NSString *phone;
/** 邮箱 */
@property (nonatomic, copy) NSString *email;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** id */
@property (nonatomic, assign) NSInteger managerId;


- (instancetype) initWithDic:(NSDictionary *)dic;

+ (instancetype) managerWithDic:(NSDictionary *)dic;

@end
