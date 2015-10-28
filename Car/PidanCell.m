//
//  PidanCell.m
//  Car
//
//  Created by Leon on 10/27/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "PidanCell.h"
#import "EndorseAbstract.h"

@interface PidanCell()

@property (weak, nonatomic) IBOutlet UILabel *ori2Label;
@property (weak, nonatomic) IBOutlet UILabel *des2Label;
@property (weak, nonatomic) IBOutlet UILabel *comLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation PidanCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"PidanCell";
    PidanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PidanCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setEndorse:(EndorseAbstract *)endorse{
    _endorse = endorse;
    self.ori2Label.text = _endorse.ori2;
    self.des2Label.text = _endorse.des2;
    self.comLabel.text = _endorse.comName;
    self.timeLabel.text = _endorse.ctime;
    self.statusLabel.text = _endorse.statusName;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元",_endorse.money];
    UIColor *color;
    switch (_endorse.status) {
        case EndorseStatusGrabed : //已抢单
        case EndorseStatusPassed : //已通过
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
    self.statusLabel.backgroundColor = color;
}


//- (void)setPidan:(PidanModel *)pidan{
//    _pidan = pidan;
//    self.ori2Label.text = _pidan.ori2;
//    self.des2Label.text = _pidan.des2;
//    self.comLabel.text = _pidan.comName;
//    self.timeLabel.text = _pidan.ctime;
//    self.statusLabel.text = _pidan.statusName;
//    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元",_pidan.money];
//    UIColor *color;
//    switch (_pidan.status) {
//        case PidanStatusGraped : //已抢单
//        case PidanStatusApproved : //已通过
//            color = RGBColor(78, 187, 227);
//            break;
//        case PidanStatusCanceled: //已取消
//            color = RGBColor(159,161,161);
//            break;
//        case PidanStatusCarring: //承运中
//            color = RGBColor(160,219,116);
//            break;
//        case PidanStatusBalanced: //已经算
//            color = RGBColor(233,129,220);
//            break;
//        default:
//            break;
//    }
//    self.statusLabel.backgroundColor = color;
//}


@end
