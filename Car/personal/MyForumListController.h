//
//  MyForumListViewController.h
//  Car
//
//  Created by Leon on 9/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBaseTableController.h"

@class MyForumListController;

@protocol MyForumListDelegate <NSObject>

@optional
- (void)showNewsDetail:(MyForumListController *)controller index:(NSInteger )index;

@end


@interface MyForumListController : SCBaseTableController

- (void)viewDidCurrentView;

@property (nonatomic, weak) id<MyForumListDelegate> myForumListDelegate;
@property (nonatomic,assign) NSInteger isMain;

@end
