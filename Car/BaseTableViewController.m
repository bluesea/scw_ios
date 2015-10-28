//
//  BaseTableViewController.m
//  Car
//
//  Created by Leon on 14-9-24.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (id)init{
    return  [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)loadView{
    self.view = [[UITableView alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    self.tableView = (UITableView *)self.view;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    [self setupRefresh];
    
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
//    [self.dataArray removeAllObjects];
    _page = 0;
//    _refreshFlag = YES;
    [self loadData];
}

- (void)footerRereshing
{
    LSLog(@"---上拉");
//    _refreshFlag = NO;
    _page++;
    [self loadData];
}

//读取数据
#warning 继承后重写此方法
- (void)loadData{
    
}

- (void)endFresh{
    if([self.tableView isHeaderRefreshing]){
        [self.tableView headerEndRefreshing];
    } else {
        [self.tableView footerEndRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}


@end
