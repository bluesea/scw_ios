//
//  MessageModel.h
//  Car
//  消息实体类
//  Created by Leon on 14-9-27.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 发送时间 */
@property (nonatomic, copy) NSString *ctime;
/** 发送人 */
@property (nonatomic, copy) NSString *fromName;
/** 编号 */
@property (nonatomic, assign) NSInteger id;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) msgWithDid:(NSDictionary *)dic;

@end
