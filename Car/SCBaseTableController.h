//
//  SCBaseTableController.h
//  Car
//
//  Created by Leon on 11/20/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
/** 分页数量 */
#define PAGECOUNT 10

@interface SCBaseTableController : UITableViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNum;


/**
 *  首次进入是否需要刷新
 */
- (void)startHeaderRefresh;
/**
 *  加载数据
 */
- (void)loadData;
/**
 *  停止刷新
 */
- (void)endRefresh;
/**
 * 检测返回数据
 */
- (void)checkResponseArray:(NSArray*)array;

@end
