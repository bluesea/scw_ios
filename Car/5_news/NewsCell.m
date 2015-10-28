//
//  NewsCell.m
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "NewsCell.h"
#import "NewsModel.h"

@interface NewsCell()
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *ctime;

@end

@implementation NewsCell

+ (NewsCell *) cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"newsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil]lastObject];
    }
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou.png"]];
    return cell;
}

- (void)setNewsModel:(NewsModel *)newsModel{
    _newsModel = newsModel;
    
    _title.text = _newsModel.title;
    _ctime.text = _newsModel.ctime;
}

@end
