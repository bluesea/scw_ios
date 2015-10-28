//
//  ManageBzCell.h
//  Car
//
//  Created by Leon on 10/27/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessAbstract.h"

@interface ManageBzCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BusinessAbstract *business;

@end
