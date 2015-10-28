//
//  UserModel.m
//  Car
//
//  Created by Leon on 14-9-18.
//  Copyright (c) 2014年 com.cwvs. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static UserModel  *shareuser = nil; //第一步：静态实例，并初始化。


+(UserModel *)shareUser{
    
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

- (void) setUserWithDic:(NSDictionary *)dic{
    self.loginname = dic[@"loginname"];
    self.password = dic[@"password"];
    self.nicknamme = dic[@"nickname"];
    self.ctime = dic[@"ctime"];
    self.userId = dic[@"id"];
    self.type = dic[@"type"];
    self.isAdmin = dic[@"isAdmin"];
    self.status = dic[@"status"];
}


@end
