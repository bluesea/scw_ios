//
//  PermissionUtil.m
//  Car
//
//  Created by Leon on 14-9-30.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "PermissionUtil.h"

@implementation PermissionUtil

+ (BOOL)checkPermissionWithRole:(NSString *)role{
    
//    return [role isEqualToString:[AppDelegate shareAppdelegate].role];
//    LSLog(@"----%@",UserDefaults(@"ROLE"));
    return  [UserDefaults(SC_ROLE) hasPrefix:role];
    
}


@end
