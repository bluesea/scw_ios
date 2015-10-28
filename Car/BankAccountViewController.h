//
//  BankAccountViewController.h
//  Car
//
//  Created by Leon on 10/20/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankAccountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)  UITableView *accountTable;

@end
