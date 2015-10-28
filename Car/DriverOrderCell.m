//
//  OrderCell.m
//  Car
//
//  Created by Leon on 9/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "DriverOrderCell.h"

@interface DriverOrderCell()

@property (weak, nonatomic) IBOutlet UILabel *ori2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *des2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *stimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *carNumLbl;

@end

@implementation DriverOrderCell

+ (instancetype) cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"driverOrderCell";
    
    DriverOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DriverOrderCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

///** 已抢单 */
//OrderStatusGrabed = 1,
///** 已取消 */
//OrderStatusUndoed,
///** 已通过 */
//OrderStatusPassed,
///** 承运中 */
//OrderStatusTransporting,
///** 已到达 */
//OrderStatusArrived,
///** 到达确认 */
//OrderStatusConfirm,
///** 回单寄出 */
//OrderStatusSlipsent,
///** 回单收到 */
//OrderStatusSlipgot,
///** 出事故 */
//OrderStatusAccident,
///** 因故终止 */
//OrderStatusAccover,
///** 已结算 */
//OrderStatusSettled,
///** 已收款 */
//OrderStatusPaid

- (void)setOrder:(OrderAbstract *)order{
    _order = order;
    _ori2Lbl.text = _order.ori2;
    _des2Lbl.text = _order.des2;
    _statusLbl.text = _order.statusName;
    _carNumLbl.text = [NSString stringWithFormat:@"%d辆%@",_order.carNum,_order.carTypeName];
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
    _statusLbl.backgroundColor = color;
}

@end
