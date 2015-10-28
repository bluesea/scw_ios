//
//  NewsModel.h
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *pubName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, assign) NSInteger isAble;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, assign) NSInteger typeId;
@property (nonatomic, copy) NSString *loginname;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) newsModelWithDic:(NSDictionary *)dic;


@end
