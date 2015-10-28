//
//  Account.h
//  Car
//  银行账户
//  Created by Leon on 10/20/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankAccount : NSObject
/** 银行名 */
@property (nonatomic, copy) NSString *bankName;
/** 账号 */
@property (nonatomic, copy) NSString *accNo;
/** 账户名称 */
@property (nonatomic, copy) NSString *accName;
/** 银行图标 **/
@property (nonatomic, copy) NSString *logoUrl;

/** 编号 */
@property (nonatomic, assign) NSInteger id;


- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) accountWithDid:(NSDictionary *)dic;

@end
