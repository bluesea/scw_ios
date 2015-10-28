//
//  OrderCell.h
//  Car
//
//  Created by Leon on 9/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderAbstract.h"

@interface DriverOrderCell : UITableViewCell

@property (nonatomic,strong) OrderAbstract *order;


+ (instancetype) cellWithTableView:(UITableView *)tableView;
@end

