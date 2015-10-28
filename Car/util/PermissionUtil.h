//
//  PermissionUtil.h
//  Car
//
//  Created by Leon on 14-9-30.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PermissionUtil : NSObject

+ (BOOL)checkPermissionWithRole:(NSString *)role;

@end
