//
//  MenuUtil.h
//  Car
//  个人中心菜单
//  Created by Leon on 10/16/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuUtil : NSObject
/**
 *  司机菜单
 *
 *  @return <#return value description#>
 */
+ (NSArray *)driverMenu;
/**
 *  资源型管理员菜单
 *
 *  @return <#return value description#>
 */
+ (NSArray *)resourceManagerMenu;
/**
 *  运力型管理员菜单
 *
 *  @return <#return value description#>
 */
+ (NSArray *)transManagerMenu;

@end
