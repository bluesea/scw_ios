//
//  EmployeeManageController.m
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "EmployeeManageController.h"
#import "AddEmployeeController.h"
#import "AddDriverController.h"
#import "Employee.h"
#import "EmployeeCell.h"

@interface EmployeeManageController () <EmployeeCellDelegate>

@end

@implementation EmployeeManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addEmployee)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    self.tableView.rowHeight = 70;
    [self startHeaderRefresh];
}

- (void)addEmployee{

    if ([self.title isEqualToString:@"员工维护" ]){
        AddEmployeeController *addEmployee = [[AddEmployeeController alloc] init];
        [self.navigationController pushViewController:addEmployee animated:YES];
    } else if ([self.title isEqualToString:@"司机维护" ]) {
        AddDriverController *addDriver = [[AddDriverController alloc] init];
        [self.navigationController pushViewController:addDriver animated:YES];
    }
    
}


- (void)loadData {
    
    if ([self.title isEqualToString:@"员工维护" ]){
        [[HttpRequest shareRequst] getManagerForCompanyWithId:UserDefaults(@"userId") page:[NSString stringWithFormat:@"%d",self.pageNum] success:^(id obj) {
            NSNumber *code = [obj objectForKey:@"code"];
            if (code.intValue == 0){
                NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
                [self checkResponseArray:array];
                for(NSDictionary *dic in array){
                    Employee *employee = [Employee employeeWithDic:dic];
                    [self.dataArray addObject:employee];
                }
                [self.tableView reloadData];
                
            }
            [self endRefresh];
        } fail:^(NSString *errorMsg) {
            [self endRefresh];
        }];
    } else if ([self.title isEqualToString:@"司机维护" ]) {
        [[HttpRequest shareRequst] getDriverForCompanyWithId:UserDefaults(@"userId") page:[NSString stringWithFormat:@"%d",self.pageNum] name:@"" cardNo:@"" success:^(id obj) {
            NSNumber *code = [obj objectForKey:@"code"];
            if (code.intValue == 0){
                NSArray *array = [[[obj objectForKey:@"record"] objectForKey:@"grid"]objectForKey:@"rows"];
                [self checkResponseArray:array];
                for(NSDictionary *dic in array){
                    Employee *employee = [Employee employeeWithDic:dic];
                    [self.dataArray addObject:employee];
                }
                [self.tableView reloadData];
                
            }
            [self endRefresh];
        } fail:^(NSString *errorMsg) {
            [self endRefresh];
        }];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EmployeeCell *cell = [EmployeeCell cellWithTable:tableView];
    cell.employee = [self.dataArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
    
}

- (void)statusBtnChanged:(EmployeeCell *)cell{

    Employee *emp = cell.employee;
    
    NSString *status = emp.status ? @"0": @"1";
    
    [MBProgressHUD showMessage:@"正在提交..."];
    
    if ([self.title isEqualToString:@"员工维护" ]){
        [[HttpRequest shareRequst] managerSwitchWithId:[NSString stringWithFormat:@"%d",emp.id] status:status success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
                emp.status = !emp.status;
            } else {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
                cell.status.on = !cell.status.on;
                [cell.status setOn:!cell.status.on animated:YES];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
            [cell.status setOn:!cell.status.on animated:YES];
        }];
    } else if ([self.title isEqualToString:@"司机维护" ]) {
        [[HttpRequest shareRequst] driverSwitchWithId:[NSString stringWithFormat:@"%d",emp.id] status:status success:^(id obj) {
            NSNumber *code = [obj valueForKey:@"code"];
            if (code.intValue == 0){
                [MBProgressHUD showSuccess:[obj valueForKey:@"msg"]];
                emp.status = !emp.status;
            } else {
                [MBProgressHUD showError:[obj valueForKey:@"msg"]];
                cell.status.on = !cell.status.on;
                [cell.status setOn:!cell.status.on animated:YES];
            }
        } fail:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg];
            [cell.status setOn:!cell.status.on animated:YES];
        }];
    }
}

@end
