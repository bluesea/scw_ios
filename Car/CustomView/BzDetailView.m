//
//  BzDetailView.m
//  Car
//
//  Created by Leon on 11/3/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BzDetailView.h"
#import "BusinessDetail.h"
#import "PermissionUtil.h"

@interface BzDetailView ()

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


@end

@implementation BzDetailView

+ (BzDetailView *) bzDetailView{
    return [[[NSBundle mainBundle] loadNibNamed:@"BzDetailView" owner:nil options:nil]lastObject];
}

- (void)setBz:(BusinessDetail *)bz{
    _bz = bz;
    if ([PermissionUtil checkPermissionWithRole:ROLE_DRIVER ]){
        self.transfee.text = _bz.transfee;
    } else {
        self.transfee.text = _bz.money;
    }
    
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
    
}

@end
