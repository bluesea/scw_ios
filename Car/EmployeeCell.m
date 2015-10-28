//
//  EmployeeCell.m
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "EmployeeCell.h"

#import "Employee.h"

@interface EmployeeCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;


- (IBAction)changeAction:(UISwitch *)sender;

@end

@implementation EmployeeCell

+ (EmployeeCell *) cellWithTable:(UITableView *)tableView{
    static NSString *ID = @"employeeCell";
    EmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EmployeeCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)setEmployee:(Employee *)employee{
    _employee = employee;
    _name.text= _employee.name;
    _phone.text= _employee.phone;
//    [_status setSelected:_employee.status];
    _status.on = _employee.status;
}


- (IBAction)changeAction:(UISwitch *)sender{
    if ([self.delegate respondsToSelector:@selector(statusBtnChanged:)]) {
        [self.delegate statusBtnChanged:self];
    }
}

@end
