//
//  BusniessCell.h
//  Car
//
//  Created by Leon on 8/19/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ori1Label;

@property (weak, nonatomic) IBOutlet UILabel *ori2Label;

@property (weak, nonatomic) IBOutlet UILabel *des1Label;

@property (weak, nonatomic) IBOutlet UILabel *des2Label;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *comNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@end
