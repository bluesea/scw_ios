//
//  NSString+Extension.h
//  QQDemo
//
//  Created by Leon on 11/1/14.
//  Copyright (c) 2014 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 *  获取字符串尺寸
 *
 *  @param font    <#font description#>
 *  @param maxSize <#maxSize description#>
 *
 *  @return <#return value description#>
 */
- (CGSize) getSizeWithFont:(UIFont*) font maxSize:(CGSize)maxSize;

/**
 *  手机号码校验
 *
 *  @return <#return value description#>
 */
- (BOOL)checkPhoneNumInput;

/**
 *  md5加密
 *
 *  @return <#return value description#>
 */
- (NSString *) md5Encryption;

/**
 *  删除两端空格
 *
 *  @return <#return value description#>
 */
- (NSString *)trimBlank;

/* NSNumber 转 NSString */
+ (NSString *)parserNumber:(NSNumber *)number;

@end
