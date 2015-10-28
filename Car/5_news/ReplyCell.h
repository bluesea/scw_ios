//
//  ReplyCell.h
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReplyModel;
@class ForumReply;

@interface ReplyCell : UITableViewCell

@property (nonatomic, strong) ReplyModel *replay;
@property (nonatomic, strong) ForumReply *forumReply;

+ (ReplyCell *) cellWithTableView:(UITableView *)tableView;
@end
