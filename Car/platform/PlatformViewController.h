//
//  PlatformViewController.h
//  Car
//
//  Created by Leon on 8/8/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlatformViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *totalNum;

@property (weak, nonatomic) IBOutlet UILabel *completeNum;
@property (weak, nonatomic) IBOutlet UILabel *doingNum;
@property (weak, nonatomic) IBOutlet UILabel *bzNewNum;

@end
