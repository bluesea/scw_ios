//
//  NewsView.m
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import "NewsView.h"
#import "NSString+Extension.h"

@interface NewsView()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *pubName;
@property (weak, nonatomic) IBOutlet UILabel *ctime;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation NewsView


+ (instancetype) newsView{
    NewsView *view = [[[NSBundle mainBundle] loadNibNamed:@"NewsView" owner:nil options:nil] lastObject];
    return  view;
}

- (void)setNewsModel:(NewsModel *)newsModel{
    _newsModel = newsModel;
    _title.text = _newsModel.title;
    _pubName.text =_newsModel.pubName;
    _ctime.text = _newsModel.ctime;
    _content.text = _newsModel.content;
    CGFloat contentWith = _content.frame.size.width;
    CGSize contentSize = [_newsModel.content getSizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(contentWith, CGFLOAT_MAX)];
    LSLog(@"%f",contentWith);
    _content.frame = CGRectMake(_content.frame.origin.x, _content.frame.origin.y, contentSize.width,contentSize.height);
    LSLog(@"%@",NSStringFromCGRect(_content.frame));
    _height = CGRectGetMaxY(_content.frame);
//    [_webView loadHTMLString:_newsModel.content baseURL:nil];
//    LSLog(@"%f", _webView.pageLength);
}

- (void)setForumTopic:(ForumTopic *)forumTopic{
    _forumTopic = forumTopic;
    _title.text = _forumTopic.title;
    _pubName.text =_forumTopic.pubName;
    _ctime.text = _forumTopic.ctime;
    _content.text = _forumTopic.content;
    CGFloat contentWith = _content.frame.size.width;
    CGSize contentSize = [_newsModel.content getSizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(contentWith, CGFLOAT_MAX)];
    LSLog(@"%f",contentWith);
    _content.frame = CGRectMake(_content.frame.origin.x, _content.frame.origin.y, contentSize.width,contentSize.height);
    LSLog(@"%@",NSStringFromCGRect(_content.frame));
    _height = CGRectGetMaxY(_content.frame);

}


@end
