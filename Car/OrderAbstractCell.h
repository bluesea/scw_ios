//
//  AccidentCell.h
//  Car
//
//  Created by Leon on 10/28/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderAbstract.h"

@interface OrderAbstractCell : UITableViewCell

@property (nonatomic, strong) OrderAbstract *order;
//@property (nonatomic, strong) BusinessModel *bz;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
