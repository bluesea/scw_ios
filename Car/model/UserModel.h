//
//  UserModel.h
//  Car
//
//  Created by Leon on 14-9-18.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/** 登录名 */
@property (nonatomic, strong) NSString *loginname;
/** 密码 */
@property (nonatomic, strong) NSString *password;
/** 昵称 */
@property (nonatomic, strong) NSString *nicknamme;
/** 创建时间 */
@property (nonatomic, strong) NSString *ctime;
/** userId */
@property (nonatomic, strong) NSString *userId;
/** 类型 */
@property (nonatomic, strong) NSString *type;
/** 是否管理员 */
@property (nonatomic, strong) NSString *isAdmin;
/** 状态 */
@property (nonatomic, strong) NSString *status;

+(UserModel *)shareUser;

//-(void)getuserInfoFromDictionary:(NSDictionary*)dic;
- (void) setUserWithDic:(NSDictionary *)dic;

@end
