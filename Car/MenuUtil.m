//
//  MenuUtil.m
//  Car
//
//  Created by Leon on 10/16/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "MenuUtil.h"

@implementation MenuUtil
#warning 修改个人中心里的控制器名称,也要修改这里

#pragma mark  司机菜单
+ (NSArray *)driverMenu{
    
    NSArray *array = @[
                       @{@"title":@"附近业务",       @"vc":@"NearbyBusinessController"},
                       @{@"title":@"运力流向",    @"vc":@"TransportController"},
                       @{@"title":@"财务管理",  @"vc":@"FinanceManagerController"},
                       @{@"title":@"事故录入",  @"vc":@"AccidentEntryController"},
                       @{@"title":@"我的论坛",  @"vc":@"MyForumViewController"},
                       @{@"title":@"银行账户",  @"vc":@"BankAccountViewController"},
                       @{@"title":@"个人资料",  @"vc":@"DriverInfoController"},
                       @{@"title":@"修改密码",  @"vc":@"ChangePwdController"},
                       @{@"title":@"关于送车网",  @"vc":@"AboutUsController"}
                       ];
    
    return array;
}

#pragma mark 资源型管理员菜单
+ (NSArray *)resourceManagerMenu{
    
    NSArray *array = @[
                       @{@"title":@"业务管理",  @"vc":@"BzManageController"},
                       @{@"title":@"批单审核",  @"vc":@"PidanManageController"},
                       @{@"title":@"订单管理",  @"vc":@"OrderManageController"},
                       @{@"title":@"业务跟踪",  @"vc":@"BusinessTraceController"},
                       @{@"title":@"财务管理",  @"vc":@""},
                       @{@"title":@"发布资讯",  @"vc":@"PublishViewController"},
                       @{@"title":@"发布通知",  @"vc":@"PublishViewController"},
                       @{@"title":@"我的论坛",  @"vc":@"MyForumViewController"},
                       @{@"title":@"员工维护",  @"vc":@"EmployeeManageController"},
                       @{@"title":@"公司资料维护",  @"vc":@"ComInfoViewController"},
                       @{@"title":@"银行账户",  @"vc":@"BankAccountViewController"},
                       @{@"title":@"个人资料",  @"vc":@"ManagerInfoController"},
                       @{@"title":@"修改密码",  @"vc":@"ChangePwdController"},
                       @{@"title":@"关于送车网",  @"vc":@"AboutUsController"}
                       ];
    return array;
}

#pragma mark  运力菜单
+ (NSArray *)transManagerMenu{
    NSArray *array = @[
                       @{@"title":@"业务管理",    @"vc":@"BzManageController"},
                       @{@"title":@"批单管理",    @"vc":@"PidanManageController"},
                       @{@"title":@"订单管理",  @"vc":@"OrderManageController"},
                       @{@"title":@"财务管理",  @"vc":@"FinanceManagerController"},
                       @{@"title":@"事故记录查询",  @"vc":@"AccidentListController"},
                       @{@"title":@"业务跟踪",  @"vc":@"BusinessTraceController"},
                       @{@"title":@"发布资讯",  @"vc":@"PublishViewController"},
                       @{@"title":@"发布通知",  @"vc":@"PublishViewController"},
                       @{@"title":@"我的论坛",  @"vc":@"MyForumViewController"},
                       @{@"title":@"员工维护",  @"vc":@"EmployeeManageController"},
                       @{@"title":@"司机维护",  @"vc":@"EmployeeManageController"},
                       @{@"title":@"司机扫描",  @"vc":@"DriverScanController"},
                       @{@"title":@"个性提醒设置",  @"vc":@"DriverScanController"},
                       @{@"title":@"公司资料维护",  @"vc":@"ComInfoViewController"},
                       @{@"title":@"银行账户",  @"vc":@"BankAccountViewController"},
                       @{@"title":@"个人资料",  @"vc":@"ManagerInfoController"},
                       @{@"title":@"修改密码",  @"vc":@"ChangePwdController"},
                       @{@"title":@"关于送车网",  @"vc":@"AboutUsController"}
                       ];
    return array;
}


@end
