//
//  NewsDetailController.h
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//


#import "NewsModel.h"
#import "ForumTopic.h"
@interface NewsDetailController : UIViewController

@property (nonatomic, strong) NewsModel *model;
@property (nonatomic, strong) ForumTopic *forumTopic;
@property (nonatomic, assign) NSInteger detailType;  //1 新闻  2 论坛

@end
