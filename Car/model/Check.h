//
//  Check.h
//  Car
//
//  Created by Leon on 11/11/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Check : NSObject

@property (nonatomic, copy) NSString *traCheckName;
@property (nonatomic, copy) NSString *resCheckName;

@property (nonatomic, assign) NSInteger resCheck;
@property (nonatomic, assign) NSInteger traCheck;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) checkWithDic:(NSDictionary *)dic;

@end
