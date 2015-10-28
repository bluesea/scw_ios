//
//  BzFollowAnnoCell.m
//  Car
//
//  Created by Leon on 11/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "BzFollowAnnoCell.h"

@interface BzFollowAnnoCell()

@property (weak, nonatomic) IBOutlet UILabel *ori2;
@property (weak, nonatomic) IBOutlet UILabel *des2;
@property (weak, nonatomic) IBOutlet UILabel *driver;
@property (weak, nonatomic) IBOutlet UILabel *com;

@end

@implementation BzFollowAnnoCell

- (void)setBusiness:(BusinessTrace *)business
{
    _business = business;
    _ori2.text = _business.ori2;
    _des2.text = _business.des2;
    _driver.text = _business.driverName;
    _com.text = _business.comName;
}
@end
