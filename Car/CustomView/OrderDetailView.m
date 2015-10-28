//
//  OrderDetailView.m
//  Car
//
//  Created by Leon on 11/7/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "OrderDetailView.h"
#import "PermissionUtil.h"
#import "BusinessDetail.h"

@interface OrderDetailView()

/** 业务车型 */
@property (weak, nonatomic) IBOutlet UILabel *carType;
/** 运费 */
@property (weak, nonatomic) IBOutlet UILabel *transfee;
/** 发布公司 */
@property (weak, nonatomic) IBOutlet UILabel *comName;
/** 规格 */
@property (weak, nonatomic) IBOutlet UILabel *carModel;
/** 准驾类型 */
@property (weak, nonatomic) IBOutlet UILabel *driverType;
/** 车长 */
@property (weak, nonatomic) IBOutlet UILabel *carLong;
/** 车宽 */
@property (weak, nonatomic) IBOutlet UILabel *carWidth;
/** 车高 */
@property (weak, nonatomic) IBOutlet UILabel *carHeight;
/** 吨位 */
@property (weak, nonatomic) IBOutlet UILabel *carWeight;
/** 燃料 */
@property (weak, nonatomic) IBOutlet UILabel *fuelName;
/** 车辆数 */
@property (weak, nonatomic) IBOutlet UILabel *carNum;
/** 驾驶员数 */
@property (weak, nonatomic) IBOutlet UILabel *driverNum;
/** 始发地 */
@property (weak, nonatomic) IBOutlet UILabel *ori;
/** 目的地 */
@property (weak, nonatomic) IBOutlet UILabel *des;
/** 始发时间 */
@property (weak, nonatomic) IBOutlet UILabel *stime;
/** 到达时间 */
@property (weak, nonatomic) IBOutlet UILabel *etime;
/** 预计天数 */
@property (weak, nonatomic) IBOutlet UILabel *schedate;
/** 备注 */
@property (weak, nonatomic) IBOutlet UILabel *remark;
/** 发车人 */
@property (weak, nonatomic) IBOutlet UILabel *sender;
/** 发车人电话 */
@property (weak, nonatomic) IBOutlet UILabel *senderPhone;
/** 发车地 */
@property (weak, nonatomic) IBOutlet UILabel *senderArea;
/** 接车人 */
@property (weak, nonatomic) IBOutlet UILabel *receiver;
/** 接车人电话 */
@property (weak, nonatomic) IBOutlet UILabel *receivePhone;
/** 接车地 */
@property (weak, nonatomic) IBOutlet UILabel *receiverArea;

@end

@implementation OrderDetailView

+ (instancetype) orderView {
    return  [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailView" owner:nil options:nil]lastObject];
}

- (void)setBz:(BusinessDetail *)bz{
    _bz = bz;
//    if ([PermissionUtil checkPermissionWithRole:ROLE_DRIVER ]){
//        self.transfee.text = _bz.transfee;
//    } else {
        self.transfee.text = _bz.money;
//    }
    
    self.comName.text = _bz.comName;
    self.carModel.text = _bz.carModelName;
    self.carType.text = _bz.carTypeName;
    self.driverType.text = _bz.driverType;
    self.carLong.text =_bz.carLong;
    self.carWeight.text = _bz.carWeight;
    self.carWidth.text = _bz.carWidth;
    self.carHeight.text = _bz.carHight;
    self.carNum.text = [NSString stringWithFormat:@"%d",_bz.carNum];
    self.fuelName.text = _bz.fuelName;
    self.driverNum.text = [NSString stringWithFormat:@"%d",_bz.driverNum];
    self.stime.text = _bz.stime;
    self.etime.text = _bz.etime;
    self.schedate.text = [NSString stringWithFormat:@"%@",_bz.schedate];
    self.remark.text = _bz.remark;
    self.ori.text = _bz.oriArea;
    self.des.text = _bz.desArea;
    self.sender.text = _bz.sender;
    self.senderPhone.text = _bz.senderPhone;
    self.senderArea.text = _bz.senArea;
    self.receiver.text =_bz.receiver;
    self.receivePhone.text = _bz.receiverPhone;
    self.receiverArea.text =_bz.recArea;

}

@end
