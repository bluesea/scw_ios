//
//  BbsUser.h
//  Car
//
//  Created by Leon on 11/6/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BbsUser : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** bbs登陆名 */
@property (nonatomic, copy) NSString *bbsName;
/** bbs昵称 */
@property (nonatomic, copy) NSString *nickName;
/** bbs密码 */
@property (nonatomic, copy) NSString *password;
/** bbs注册手机号 */
@property (nonatomic, copy) NSString *phone;
/** 创建时间 */
@property (nonatomic, copy) NSString *ctime;
/** ? */
@property (nonatomic, copy) NSString *ltime;
/** ? */
@property (nonatomic, assign) NSInteger postNum;

+ (instancetype) shareInstance;

+ (instancetype) bbsUserWithDic:(NSDictionary *)dic;

- (instancetype) initWithDic:(NSDictionary *)dic;


@end
