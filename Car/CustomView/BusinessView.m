//
//  OrderView.m
//  Car
//
//  Created by Leon on 10/29/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BusinessView.h"
#import "OrderAbstract.h"
#import "EndorseAbstract.h"

@interface BusinessView ()
/** 发布时间View */
@property (weak, nonatomic) IBOutlet UIView *ctimeView;
/** 承运价格View */
@property (weak, nonatomic) IBOutlet UIView *moneyView;
/** 始发地 */
@property (weak, nonatomic) IBOutlet UILabel *ori2;
/** 目的地 */
@property (weak, nonatomic) IBOutlet UILabel *des2;
/** 始发时间 */
@property (weak, nonatomic) IBOutlet UILabel *stime;
/** 业务信息 */
@property (weak, nonatomic) IBOutlet UILabel *bzInfo;
/** 状态 */
@property (weak, nonatomic) IBOutlet UILabel *statusName;
/** 发布时间 */
@property (weak, nonatomic) IBOutlet UILabel *ctime;
/** 运费 */
@property (weak, nonatomic) IBOutlet UILabel *money;

@end

@implementation BusinessView

+ (instancetype) businessViewStyle:(BzViewStyle)style{
    
    BusinessView *view = [[[NSBundle mainBundle] loadNibNamed:@"BusinessView" owner:nil options:nil]lastObject];
    view.bzViewStyle = style;
    switch (style) {
        case BzViewStyleWithTime :
            [view.ctimeView setHidden:NO];
            break;
        case BzViewStyleWithMoney:
            [view.moneyView setHidden:NO];
            break;
        default:
            break;
    }
    return view;
}

- (void)setEndorse:(EndorseAbstract *)endorse{
    _endorse = endorse;
    _ori2.text = _endorse.ori2;
    _des2.text = _endorse.des2;
    _stime.text = _endorse.stime;
    _statusName.text = _endorse.statusName;
    _bzInfo.text = [NSString stringWithFormat:@"%d辆%@",_endorse.carNum,_endorse.carTypeName];
    switch (_bzViewStyle) {
        case BzViewStyleWithTime :
            _ctime.text = _endorse.ctime;
            break;
        case BzViewStyleWithMoney:
            _money.text = [NSString stringWithFormat:@"%.2f元",_endorse.money];;
            break;
        default:
            break;
    }
    UIColor *color;
    switch (_endorse.status) {
        case EndorseStatusGrabed : //已抢单
        case EndorseStatusPassed: //已通过
            color = RGBColor(78, 187, 227);
            break;
        case EndorseStatusUndoed: //已取消
            color = RGBColor(159,161,161);
            break;
        case EndorseStatusTransporting: //承运中
            color = RGBColor(160,219,116);
            break;
        case EndorseStatusSettled: //已经算
            color = RGBColor(233,129,220);
            break;
        default:
            break;
    }
    _statusName.backgroundColor = color;
}

- (void)setOrder:(OrderAbstract *)order{
    _order = order;
    _ori2.text = _order.ori2;
    _des2.text = _order.des2;
    _stime.text = _order.stime;
    _statusName.text = _order.statusName;
    _bzInfo.text = [NSString stringWithFormat:@"%d辆%@",_order.carNum,_order.carTypeName];
    switch (_bzViewStyle) {
        case BzViewStyleWithMoney:
            _money.text = [NSString stringWithFormat:@"%@",_order.money];;
            break;
        default:
            break;
    }
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
    _statusName.backgroundColor = color;
}

@end
