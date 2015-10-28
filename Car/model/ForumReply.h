//
//  ForumReply.h
//  Car
//  论坛回帖
//  Created by Leon on 11/6/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ForumReply : NSObject
/** id */
@property (nonatomic, assign) NSInteger id;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 类型 */
@property (nonatomic, assign) NSInteger type;
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 主贴id? */
@property (nonatomic, assign) NSInteger pid;
/** 创建时间 */
@property (nonatomic, copy) NSString *ctime;
/** ? */
@property (nonatomic, assign) NSInteger isAble;
/** 发帖人姓名 */
@property (nonatomic, copy) NSString *pubName;
/** 删除标记 */
@property (nonatomic, assign) BOOL deleteFlag;

+ (instancetype) replyWithDic:(NSDictionary *)dic;
- (instancetype) initWithDic:(NSDictionary *)dic;

@end
