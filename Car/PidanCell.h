//
//  PidanCell.h
//  Car
//
//  Created by Leon on 10/27/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class PidanModel;
@class EndorseAbstract;

@interface PidanCell : UITableViewCell

@property (nonatomic, strong) EndorseAbstract *endorse;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
