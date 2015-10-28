//
//  NewsView.h
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "ForumTopic.h"

@interface NewsView : UIView

@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, strong) NewsModel *newsModel;
@property (nonatomic, strong) ForumTopic *forumTopic;

+ (instancetype) newsView;

@end
