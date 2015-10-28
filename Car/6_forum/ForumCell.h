//
//  ForumCell.h
//  Car
//
//  Created by Leon on 9/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForumTopic;

@interface ForumCell : UITableViewCell

@property (nonatomic, strong) ForumTopic *forumTopic;

+ (ForumCell *) cellWithTableView:(UITableView *)tableView;

@end
