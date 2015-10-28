//
//  SCBaseTableController.m
//  Car
//
//  Created by Leon on 11/20/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "SCBaseTableController.h"
#import "MJRefresh.h"

@interface SCBaseTableController ()

@end

@implementation SCBaseTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    //设置上拉下拉
    [self setupRefresh];
}

- (void)startHeaderRefresh{
    [self.tableView headerBeginRefreshing];
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    LSLog(@"---下拉");
    // 1.添加假数据
    _pageNum = 0;
    [self loadData];
}

- (void)footerRereshing
{
    LSLog(@"---上拉");
    _pageNum ++;
    [self loadData];
}

- (void)endRefresh{
    if([self.tableView isHeaderRefreshing]){
        [self.tableView headerEndRefreshing];
    } else {
        [self.tableView footerEndRefreshing];
    }
}

- (void)checkResponseArray:(NSArray*)array{
    if ([self.tableView isHeaderRefreshing]){
        [self.dataArray removeAllObjects];
    }
    if (array.count < PAGECOUNT){
        [self.tableView removeFooter];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count;
}


- (void)dealloc{
    NSLog(@"-----------tableview dealooc");
}
@end
