//
//  Adv.h
//  Car
//
//  Created by Leon on 11/12/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Advert : NSObject <NSCoding>

@property (nonatomic,assign) NSInteger id;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *picUrl;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) advWithDic:(NSDictionary *)dic;

@end
