//
//  BzManageViewController.h
//  Car
//
//  Created by Leon on 9/10/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinanceViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)showHistory:(UIButton *)sender;
@end
