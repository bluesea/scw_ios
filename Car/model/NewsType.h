//
//  NewsType.h
//  Car
//
//  Created by Leon on 11/5/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsType : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, assign) NSInteger board;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) newsTypeWithDic:(NSDictionary *)dic;


@end
