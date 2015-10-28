//
//  AccidentCell.m
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "OrderAbstractCell.h"

@interface OrderAbstractCell()
@property (weak, nonatomic) IBOutlet UILabel *ori2;
@property (weak, nonatomic) IBOutlet UILabel *des2;
@property (weak, nonatomic) IBOutlet UILabel *driver;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *ctime;
@property (weak, nonatomic) IBOutlet UILabel *comName;

@end

@implementation OrderAbstractCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"orderAbstractCell";
    OrderAbstractCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderAbstractCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setOrder:(OrderAbstract *)order{
    _order = order;
    _ori2.text = _order.ori2;
    _des2.text = _order.des2;
    _driver.text = _order.driverName;
    _status.text = _order.statusName;
    _comName.text = _order.comName;
    _ctime.text = _order.stime;
    UIColor *color;
    switch (_order.status) {
        case kOrderStatusGrabed : //已抢单
        case kOrderStatusPassed:
            color = RGBColor(78, 187, 227);
            break;
        case kOrderStatusUndoed: //已取消
            color = RGBColor(159,161,161);
            break;
        case kOrderStatusTransporting: //承运中
        case kOrderStatusArrived:
        case kOrderStatusConfirm:
            color = RGBColor(160,219,116);
            break;
        case kOrderStatusSlipsent:
        case kOrderStatusSlipgot:
            color = RGBColor(247,166,111);
            break;
        case kOrderStatusAccident: //已经算
        case kOrderStatusAccover:
            color = RGBColor(237,94,94);
            break;
        case kOrderStatusSettled:
        case kOrderStatusPaid:
            color = RGBColor(233,129,220);
            break;
        default:
            break;
    }
    _status.backgroundColor = color;
}

@end
