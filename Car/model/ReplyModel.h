//
//  ReplyModel.h
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//
//"id": 2,
//"title": "Re:论坛报名第一帖！",
//"type": 1,
//"content": "沙发！自己帖子自己抢！",
//"pid": 1,
//"ctime": "2014-11-04 11:00:06",
//"isAble": 0,
//"pubName": "小明",
//"deleteFlag": false

#import <Foundation/Foundation.h>

@interface ReplyModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger newsId;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) BOOL deleteFlag;
@property (nonatomic, copy) NSString *replyerName;
@property (nonatomic, copy) NSString *ctime;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) replyWithDic:(NSDictionary *)dic;
@end
