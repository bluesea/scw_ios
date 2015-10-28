//
//  MyForumViewController.m
//  Car
//
//  Created by Leon on 9/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "MyForumViewController.h"
#import "MyForumListController.h"
#import "NewsDetailController.h"
#import "ForumTopic.h"
@interface MyForumViewController () <MyForumListDelegate>

@end

@implementation MyForumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的论坛";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view from its nib.
    self.myForumView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.myForumView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"0d68d9"];
    self.myForumView.shadowImage = [[UIImage imageNamed:@"blue_line.png"]
                                  stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];

    MyForumListController *myTopics = [[MyForumListController alloc] init];
    myTopics.isMain = 1;
    myTopics.myForumListDelegate = self;
    myTopics.title = @"我的帖子";
    MyForumListController  *myReplys = [[MyForumListController alloc]init];
    myReplys.isMain = 2;
    myTopics.myForumListDelegate = self;
    myReplys.title = @"我的回复";
    
    _forumArray  = @[myTopics,myReplys];
    
    [self.myForumView buildUI];
}

#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return [_forumArray count];
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return [_forumArray objectAtIndex:number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    MyForumListController *vc = [_forumArray objectAtIndex:number];
    [vc viewDidCurrentView];
}

- (void)showNewsDetail:(MyForumListController *)controller index:(NSInteger)index{
    NewsDetailController *detail = [[NewsDetailController alloc] init];
    ForumTopic *model = [controller.dataArray objectAtIndex:index];
    detail.ForumTopic = model;
    detail.detailType = 2;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
