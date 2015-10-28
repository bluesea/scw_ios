//
//  EmployeeCell.h
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Employee;
@class EmployeeCell;

@protocol EmployeeCellDelegate <NSObject>
@optional
- (void)statusBtnChanged:(EmployeeCell *)cell;
@end

@interface EmployeeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *status;
@property (nonatomic, strong) Employee *employee;
@property (nonatomic, weak) id<EmployeeCellDelegate> delegate;

+ (EmployeeCell *) cellWithTable:(UITableView *)tableView;

@end
