//
//  HuidanView.m
//  Car
//
//  Created by Leon on 10/30/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "HuidanView.h"
#import "UIImageView+WebCache.h"

@interface HuidanView ()

@property (weak, nonatomic) IBOutlet UILabel *courierName;
@property (weak, nonatomic) IBOutlet UILabel *expressNo;
@property (weak, nonatomic) IBOutlet UIImageView *expressPhoto;

@end

@implementation HuidanView

+(instancetype) huidanView{
    return [[[NSBundle mainBundle]loadNibNamed:@"HuidanView" owner:nil options:nil]lastObject];
}

- (void) setDic:(NSDictionary *)dic{
    _dic = dic;
    _courierName.text = [NSString stringWithFormat:@"%@",_dic[@"courierName"]];
    _expressNo.text = [NSString stringWithFormat:@"%@",_dic[@"expressNo"]];
    [_expressPhoto sd_setImageWithURL:[NSURL URLWithString:_dic[@"expressPhoto"]] placeholderImage:[UIImage imageNamed:@"no_pic"]];
}

@end
