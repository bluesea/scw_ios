//
//  NewsListViewController.h
//  Car
//
//  Created by Leon on 9/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseTableController.h"
#import "NewsType.h"

@class  NewsListController;

@protocol NewsListDelegate <NSObject>

@optional
- (void)showNewsDetail:(NewsListController *)controller index:(NSInteger )index;

@end


@interface NewsListController : SCBaseTableController
//@property (weak, nonatomic) IBOutlet UITableView *newsList;
//@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NewsType *type;
@property (nonatomic, weak) id<NewsListDelegate> newsListDeleage;

- (void)viewDidCurrentView;

@end
