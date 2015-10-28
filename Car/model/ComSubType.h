//
//  ComSubType.h
//  Car
//
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComSubType : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *comTypeName;
@property (nonatomic, copy) NSString *comTypeId;

- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) comSubTypeWithDic:(NSDictionary *)dic;

@end
