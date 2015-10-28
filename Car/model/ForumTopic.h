//
//  ForumTopic.h
//  Car
//  论坛实体类
//  Created by Leon on 11/6/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumTopic : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 发帖人姓名 */
@property (nonatomic, copy) NSString *pubName;
/** 发布时间 */
@property (nonatomic, copy) NSString *ctime;
/** 删除标记 */
@property (nonatomic, assign) BOOL deleteFlag;
/** 可用 */
@property (nonatomic, assign) NSInteger isAble;
/** 所属版块 */
@property (nonatomic, assign) NSInteger type;
/** 帖子id */
@property (nonatomic, assign) NSInteger id;
/** 父级id */
@property (nonatomic, copy) NSString *pid;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) forumTopicWithDic:(NSDictionary *)dic;

@end
