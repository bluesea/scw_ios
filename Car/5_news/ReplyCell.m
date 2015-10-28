//
//  ReplyCell.m
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ReplyCell.h"
#import "ReplyModel.h"
#import "ForumReply.h"

@interface ReplyCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ctime;
@property (weak, nonatomic) IBOutlet UILabel *content;


@end


@implementation ReplyCell
+ (ReplyCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"replyCell";
    
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ReplyCell" owner:nil options:nil]lastObject];
    }
    return  cell;
}

- (void)setReplay:(ReplyModel *)replay{
    _replay = replay;
    _name.text  = _replay.replyerName;
    _ctime.text = _replay.ctime;
    _content.text = _replay.content;
}

- (void)setForumReply:(ForumReply *)forumReply{
    _forumReply = forumReply;
    _name.text  = _forumReply.pubName;
    _ctime.text = _forumReply.ctime;
    _content.text = _forumReply.content;
}

@end
