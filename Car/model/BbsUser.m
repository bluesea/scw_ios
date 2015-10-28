//
//  BbsUser.m
//  Car
//
//  Created by Leon on 11/6/14.
//  Copyright (c) 2014 com.cwvs. All rights reserved.
//
//private Integer id;
//private SysUser sysUser;
//private String bbsName;
//private String nickName;
//private String password;
//private String phone;
//private String headPicUrl;
//private Timestamp ctime;
//private Timestamp ltime;
//private Integer postNum;

#import "BbsUser.h"

@implementation BbsUser

static BbsUser  *shareuser = nil; //第一步：静态实例，并初始化。

+ (instancetype) shareInstance{
    {
        @synchronized (self)
        {
            if (shareuser == nil)
            {
                shareuser= [[self alloc] init];
            }
        }
        return shareuser;
    }
}

+ (instancetype) bbsUserWithDic:(NSDictionary *)dic{
    return  [[self alloc]initWithDic:dic];
}

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}

@end
