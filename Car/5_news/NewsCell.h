//
//  NewsCell.h
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsCell : UITableViewCell

@property (nonatomic, strong) NewsModel *newsModel;

+ (NewsCell *) cellWithTableView:(UITableView *)tableView;

@end
