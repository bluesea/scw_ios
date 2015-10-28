//
//  BusinessAbstract.h
//  Car
//  业务摘要
//  Created by Leon on 11/13/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject
/** 编号ID */
@property (nonatomic, assign) NSInteger id;
/** 始发省 */
@property (nonatomic, copy) NSString *ori1;
/** 始发市 */
@property (nonatomic, copy) NSString *ori2;
/** 始发区 */
@property (nonatomic, copy) NSString *ori3;
/** 目的省 */
@property (nonatomic, copy) NSString *des1;
/** 目的市 */
@property (nonatomic, copy) NSString *des2;
/** 目的县 */
@property (nonatomic, copy) NSString *des3;
/** 始发时间 */
@property (nonatomic, copy) NSString *stime;
/** 创建时间 */
@property (nonatomic, copy) NSString *ctime;
/** 公司名称 */
@property (nonatomic, copy) NSString *comName;
/** 车数量 */
@property (nonatomic, assign) NSInteger carNum;
/** 车型 */
@property (nonatomic, copy) NSString *carTypeName;


- (instancetype) initWithDic:(NSDictionary *)dic;
+ (instancetype) businessWithDic:(NSDictionary *)dic;

@end
