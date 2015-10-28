//
//  ForumCell.m
//  Car
//
//  Created by Leon on 9/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "ForumCell.h"
#import "ForumTopic.h"

@interface ForumCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ctime;
@property (weak, nonatomic) IBOutlet UILabel *pubname;

@end

@implementation ForumCell

+ (ForumCell *) cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ForumCell";
    ForumCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ForumCell" owner:nil options:nil]lastObject];
    }
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    return cell;
}

- (void)setForumTopic:(ForumTopic *)forumTopic{
    _forumTopic = forumTopic;
    
    _title.text = _forumTopic.title;
    _ctime.text = _forumTopic.ctime;
    _pubname.text =_forumTopic.pubName;
}


@end
