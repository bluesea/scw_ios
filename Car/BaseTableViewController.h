//
//  BaseTableViewController.h
//  Car
//
//  Created by Leon on 14-9-24.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface BaseTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) BOOL refreshFlag;



//- (void)beginHeaderRefreshing;

- (void)headerRereshing;
- (void)footerRereshing;
- (void)loadData;
- (void)endFresh;

@end
