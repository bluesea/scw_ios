//
//  ManageBzCell.m
//  Car
//
//  Created by Leon on 10/27/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ManageBzCell.h"

@interface ManageBzCell()

@property (weak, nonatomic) IBOutlet UILabel *ori2;
@property (weak, nonatomic) IBOutlet UILabel *des2;
@property (weak, nonatomic) IBOutlet UILabel *stime;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *status;


@end

@implementation ManageBzCell

+ (instancetype) cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"managerCell";
    ManageBzCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ManageBzCell" owner:nil options:nil]lastObject];
    }
    return cell;
}


- (void)setBusiness:(BusinessAbstract *)business{
    _business = business;
    _ori2.text = _business.ori2;
    _des2.text = _business.des2;
    _stime.text =_business.stime;
    _status.text =_business.statusName;
    _info.text = [NSString stringWithFormat:@"%d辆%@",_business.carNum,_business.carTypeName];
    UIColor *color;
    switch (_business.status) {
        case BusinessStatusChecked:
        case BusinessStatusFtfChecked:
        case BusinessStatusClose:
            color = RGBColor(78, 187, 227);
            break;
        case BusinessStatusUncheck: //已取消
            color = RGBColor(159,161,161);
            break;
        case BusinessStatusTransporting: //承运中
        case BusinessStatusArrived:
            color = RGBColor(160,219,116);
            break;
        case BusinessStatusSettled:
            color = RGBColor(233,129,220);
            break;
        default:
            break;
    }
    _status.backgroundColor = color;
}


@end
